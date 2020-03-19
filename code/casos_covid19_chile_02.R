library(here)
source(here("code","libraries.R"))

covid19_chile <- read_html('https://www.minsal.cl/nuevo-coronavirus-2019-ncov/casos-confirmados-en-chile-covid-19/')
covid19_chile <- covid19_chile %>% html_nodes(css = '#main table:nth-child(1) tr~ tr+ tr td')
covid19_chile <- covid19_chile %>% html_text()
covid19_chile <- covid19_chile %>% matrix(ncol = 3, byrow = TRUE)
covid19_chile <- covid19_chile %>% as_tibble()
covid19_chile <- covid19_chile %>% set_colnames(covid19_chile %>% slice(1) %>% unlist %>% make_clean_names)
covid19_chile <- covid19_chile %>% tail(-1)
covid19_chile <- covid19_chile %>% mutate(fecha = Sys.Date())

write_csv2(covid19_chile, here("data", paste0("covid19_chile_",Sys.Date(),".csv")))
