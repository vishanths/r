library(dplyr)

# Read datasets
sales_data <- read.csv("C:/Users/nnm22/Desktop/vishanth/r/sales_new (1).csv")
customer_data <- read.csv("C:/Users/nnm22/Desktop/vishanth/r/customer.csv")

# Check the structure of both datasets
str(sales_data)
str(customer_data)

# Print unique values of the "Name" column in both datasets
unique(sales_data$Name)
unique(customer_data$Name)

# Merge datasets based on common variable
merged_data <- merge(sales_data, customer_data, by = "Name", all = TRUE)

# Check the merged data
print("Merged Data:")
print(merged_data)

# Calculate total sales amount
merged_data <- merged_data %>%
  mutate(Total_Sales = Quantity * Price)

# Calculate total sales amount by country
sales_by_country <- merged_data %>%
  group_by(Country) %>%
  summarise(Total_Sales = sum(Total_Sales))

# Filter data for USA customers
usa_customers <- merged_data %>%
  filter(Country == "USA")

# Print the results
print("Sales by Country:")
print(sales_by_country)
print("USA Customers:")
print(usa_customers)
