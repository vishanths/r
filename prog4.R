#install.packages(c("rvest", "xml2", "httr"))
library(rvest)
library(xml2)
library(httr)
# Define the URL
#url <- "https://www.example.com"
# If authentication is required, set your username and password
#username <- "your_username"
#password <- "your_password"
# Send a GET request
#response <- GET(url, authenticate(username, password))
# Specify the Target Website and URL
url <- "https://en.wikipedia.org/wiki/List_of_countries_and_dependencies_and_their_capitals_in_native_languages"
# Send HTTP Requests and Handle Authentication (if required)
response <- tryCatch(GET(url), error = function(e) e)
# Check if connection was successful
if (!inherits(response, "error")) {
  cat("Successfully connected to the website.\n")
  # Retrieve HTML Content and Parse XML/HTML
  html_content <- read_html(response$content, encoding = "UTF-8")
  # Extract Data from HTML
  # Extracting country names
  countries <- html_content %>%
    html_nodes(".wikitable tbody tr td:nth-child(2)") %>%
    html_text()
  # Extracting capital names
  capitals <- html_content %>%
    html_nodes(".wikitable tbody tr td:nth-child(3)") %>%
    html_text()
  # Perform Data Cleaning and Transformation
  # Remove unnecessary elements like references and decode HTML entities
  clean_countries <- gsub("\\[.*?\\]", "", countries)
  clean_countries <- gsub("&nbsp;", " ", clean_countries)
  clean_capitals <- gsub("\\[.*?\\]", "", capitals)
  clean_capitals <- gsub("&nbsp;", " ", clean_capitals)
  # Remove Unicode characters and symbols
  clean_countries <- enc2utf8(iconv(clean_countries, "UTF-8", "ASCII", sub = " "))
  clean_capitals <- enc2utf8(iconv(clean_capitals, "UTF-8", "ASCII", sub = " "))
  # Combine data into a data frame
  country_capitals <- data.frame(Country = clean_countries, Capital = clean_capitals)
  # Save or Analyze the Extracted Data
  # Save the extracted data to a CSV file
  write.csv(country_capitals, file = "country_capitals.csv", row.names = FALSE)
  print(country_capitals)
} else {
  cat("Failed to connect to the website. Please check your internet connection or the URL.\n")
}