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

covid19_chile <- tibble(file_name = dir(here("data")))
covid19_chile <- covid19_chile %>% filter(file_name %>% str_ends('.csv'))
covid19_chile <- covid19_chile %>% mutate(data = here("data", file_name) %>% map(read_csv2, col_types = 'cddc'))
covid19_chile <- covid19_chile %>% unnest(data)

covid19_chile_gg <- covid19_chile    %>% filter(region == 'Total')
covid19_chile_gg <- covid19_chile_gg %>% ggplot(aes(x = fecha, y = casos_totales, color = region))
covid19_chile_gg <- covid19_chile_gg %+% geom_point(size = 4)
covid19_chile_gg <- covid19_chile_gg %+% scale_fill_viridis_d()
covid19_chile_gg <- covid19_chile_gg %+% labs(title = "COVID19 Casos confirmados en Chile")
covid19_chile_gg <- covid19_chile_gg %+% theme_minimal()
covid19_chile_gg <- covid19_chile_gg %+% theme(axis.text.x = element_text(angle = 45, hjust = 1))
covid19_chile_gg

ggsave(here("figs",paste0("covid18_chile_",Sys.Date(),".png")), width = 5, height = 4)


