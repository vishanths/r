
# Load necessary libraries 
library(rvest) 
# Specify the URL of the website to scrape 
url <- "https://coinmarketcap.com/" 
# Download the HTML content 
html_content <- read_html(url) 
# Define XPath selectors to extract data 
title_xpath <- '/html/body/div[1]/div[2]/div[1]/div[2]/div/div[1]/div[4]/table/tbody/tr/td[3]' 
price_xpath <- '/html/body/div[1]/div[2]/div[1]/div[2]/div/div[1]/div[4]/table/tbody/tr/td[4]' 
# Extract data using XPath selectors 
titles <- html_content %>% 
  html_nodes(xpath = title_xpath) %>% 
  html_text() %>% 
  trimws() # Remove leading/trailing whitespaces 
prices <- html_content %>% 
  html_nodes(xpath = price_xpath) %>% 
  html_text() %>% 
  trimws() # Remove leading/trailing whitespaces 
# Combine the extracted data into a data frame 
book_data <- data.frame(Title = titles, Price = prices) 
# Print the extracted data 
print(book_data) # Save the extracted data to a CSV file 
write.csv(book_data, "book_data.csv", row.names = FALSE)
#/html/body/div[1]/div[2]/div[1]/div[2]/div/div[1]/div[4]/table/tbody/tr[2]/td[3]/div/a/div/div/div/p
#/html/body/div[1]/div[2]/div[1]/div[2]/div/div[1]/div[4]/table/tbody/tr[2]/td[4]/div/a/span