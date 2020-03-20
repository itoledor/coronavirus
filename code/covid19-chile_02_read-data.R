library(here)
source(here("code","covid19-chile_00_libraries.R"))

covid19_chile <- tibble(file_name = dir(here("data")))
covid19_chile <- covid19_chile %>% filter(file_name %>% str_ends('.csv'))
covid19_chile <- covid19_chile %>% mutate(data = here("data", file_name) %>% map(read_csv2))
covid19_chile <- covid19_chile %>% unnest(data)

write_rds(covid19_chile, here("data", "covid19_chile.rds"))



