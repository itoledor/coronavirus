library(here)
source(here("code","covid19-chile_00_libraries.R"))

data_acum <- read_xls(here("raw","total-examenes-acumulados.xls"))
data_acum <- data_acum %>% mutate(fecha = fecha %>% round())
data_acum <- data_acum %>% group_by(fecha)
data_acum <- data_acum %>% summarise(total_examenes_acumulados = mean(total_examenes_acumulados))
data_acum <- data_acum %>% mutate(fecha = fecha + as.Date("2020-03-01") - 1)

data_dia <- read_xls(here("raw","total-examenes-diarios.xls"))
data_dia <- data_dia %>% mutate(fecha = fecha %>% round())
data_dia <- data_dia %>% group_by(fecha)
data_dia <- data_dia %>% summarise(total_examenes_diarios = mean(total_examenes_diarios))
data_dia <- data_dia %>% mutate(fecha = fecha + as.Date("2020-03-01") - 1)

data_test <- data_dia %>% left_join(data_acum)
covid19_chile_gg_test <- data_test %>% ggplot() 
covid19_chile_gg_test <- covid19_chile_gg_test %+% geom_col(aes(x = fecha, y = total_examenes_diarios), fill = "lightseagreen")
covid19_chile_gg_test <- covid19_chile_gg_test %+% geom_point(aes(x = fecha, y = total_examenes_acumulados*1400/8000), color = "tomato")
covid19_chile_gg_test <- covid19_chile_gg_test %+% geom_line(aes(x = fecha, y = total_examenes_acumulados*1400/8000), color = "tomato")
covid19_chile_gg_test <- covid19_chile_gg_test %+% scale_y_continuous(name = "Total exámenes diarios", sec.axis = sec_axis(~.*8000/1400, name = "Total exámenes acumulados")) 
covid19_chile_gg_test <- covid19_chile_gg_test %+% labs(title = "Exámenes realizados por dia de informe") 
covid19_chile_gg_test <- covid19_chile_gg_test %+% labs(subtitle = "Al día 23 de marzo") 
covid19_chile_gg_test <- covid19_chile_gg_test %+% labs(caption = "Fuente: http://epi.minsal.cl/\r\n @NachoToledoR") 

ggsave(here("figs",paste0("covid19_chile_",Sys.Date(),"_test.png")), covid19_chile_gg_test, width = 6, height = 4)

write_csv2(data_test, here("data", paste0("covid19_chile_",Sys.Date(),"_tests.csv")))