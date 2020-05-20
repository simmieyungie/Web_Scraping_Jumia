library(rvest)
library(tidyverse)


#Try to see how the website works
url <- "https://www.jumia.com.ng/mobile-phones/"

#Generate url sequence
links <- c(url, paste(rep(url, 24), "?page=", rep(2:25), sep = ""))

#Create a function that goes in to collect the price, and product name
 read_product <- function(urls){
   tibble(
    name = 
     url %>% 
       read_html() %>% 
       html_nodes(".name") %>% 
       html_text(),
    Price =
      urls %>% 
      read_html() %>% 
      html_nodes(".prc") %>% 
      html_text() 
    
   )
 }

#scrape laptops
laps <-  
   links %>% 
   set_names(1:25) %>% 
   map_dfr(read_product, .id = "page_number") %>% 
   mutate(date = Sys.Date(), time = Sys.time())



#Function works perfectly








