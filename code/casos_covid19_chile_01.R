library(here)
source(here("code","libraries.R"))


covid19_chile <- tribble(~date,         ~cases,      ~type ,
                         "2020-03-03",       1, "confirmed",
                         "2020-03-04",       3, "confirmed",
                         "2020-03-05",       4, "confirmed",
                         "2020-03-06",       5, "confirmed",
                         "2020-03-07",       7, "confirmed",
                         "2020-03-08",      10, "confirmed",
                         "2020-03-09",      15, "confirmed",
                         "2020-03-10",      17, "confirmed",
                         "2020-03-11",      23, "confirmed",
                         "2020-03-12",      33, "confirmed",
                         "2020-03-13",      43, "confirmed",
                         "2020-03-14",      61, "confirmed",
                         "2020-03-15",      75, "confirmed",
                         "2020-03-16",     156, "confirmed",
                         "2020-03-17",     201, "confirmed",
                         "2020-03-03",       0, "recovered",
                         "2020-03-04",       0, "recovered",
                         "2020-03-05",       0, "recovered",
                         "2020-03-06",       0, "recovered",
                         "2020-03-07",       0, "recovered",
                         "2020-03-08",       0, "recovered",
                         "2020-03-09",       0, "recovered",
                         "2020-03-10",       0, "recovered",
                         "2020-03-11",       0, "recovered",
                         "2020-03-12",       0, "recovered",
                         "2020-03-13",       0, "recovered",
                         "2020-03-14",       0, "recovered",
                         "2020-03-15",       0, "recovered",
                         "2020-03-16",       0, "recovered",
                         "2020-03-17",       0, "recovered",
)

write_rds(covid19_chile, here("data", "covid19_chile.rds"))
write_csv2(covid19_chile, here("data","covid19_chile_01.csv"))

covid19_chile_gg <- covid19_chile    %>% ggplot(aes(x = date, y = cases, color = type))
covid19_chile_gg <- covid19_chile_gg %+% geom_point(size = 4)
covid19_chile_gg <- covid19_chile_gg %+% scale_fill_viridis_d()
covid19_chile_gg <- covid19_chile_gg %+% labs(title = "COVID19 Casos confirmados en Chile")
covid19_chile_gg <- covid19_chile_gg %+% theme_minimal()
covid19_chile_gg <- covid19_chile_gg %+% theme(axis.text.x = element_text(angle = 45))
covid19_chile_gg
