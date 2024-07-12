
# Load necessary libraries 
library(rvest) 
# Specify the URL of the website to scrape 
url <- "https://coinmarketcap.com/" 
# Download the HTML content 
html_content <- read_html(url) 
# Define XPath selectors to extract data 
title_xpath <- '//*[@class="product_pod"]/h3/a' 
price_xpath <- '//*[@class="product_pod"]/div[2]/p[1]' 
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