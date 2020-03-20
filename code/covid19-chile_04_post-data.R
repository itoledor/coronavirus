library(here)
source(here("code","covid19-chile_00_libraries.R"))

twitter_credentials <- read_rds(here("data", "twitter_credentials.rds"))
app_name            <- twitter_credentials$app_name
consumer_key        <- twitter_credentials$consumer_key  
consumer_secret     <- twitter_credentials$consumer_secret  
access_token        <- twitter_credentials$access_token  
access_secret       <- twitter_credentials$access_secret  
google_map_key      <- twitter_credentials$google_map_key  

token <- create_token(app_name, consumer_key, consumer_secret, access_token, access_secret)

covid19_chile_actual <- read_rds(here("data","covid19_chile.rds"))
covid19_chile_actual <- covid19_chile_actual %>% filter(region == "Total")
covid19_chile_actual <- covid19_chile_actual %>% filter(fecha  == max(fecha))

status <- paste("Actualización\r\n",
                "Casos nuevos:" , covid19_chile_actual$casos_nuevos,"\r\n",
                "Casos totales:", covid19_chile_actual$casos_totales,"\r\n",
                "#AplanarLaCurva #rtweet #rstats")

rtweet::post_tweet(status = status, token = token, media = here("figs",paste0("covid19_chile_",Sys.Date(),"_2.png")))

