income_data <- read.csv("zipIncome.txt", sep = "|", header = TRUE)
names(income_data) <- c("zipCode", "income")
data_summary <- summary(income_data$income)
print(data_summary)
library("ggplot2")
ggplot(income_data, aes(x = zipCode, y = income)) +
  geom_point(color = "blue", alpha = 0.6, size = 1) +
  labs(title = "Average Household Income by Zip Code",
       x = "Zip Codes",
       y = "Income") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
income_filtered <- subset(income_data, income > 7000 & income < 200000)
new_mean <- mean(income_filtered$income)
data_summary_final <- summary(income_filtered$income)
print(data_summary_final)
boxplot(income_filtered$income,
        main = "Box Plot of Household Income",
        ylab = "Income ($)",
        col = "lightblue")
boxplot(income_filtered$income,
        main = "Box Plot of Household Income (Log Scale)",
        ylab = "Income ($)",
        log = "y",
        col = "lightgreen")

ggplot(income_filtered, aes(x = zipCode, y = income)) +
  geom_point(position = position_jitter(width = 0.2), alpha = 0.2) +
  scale_y_log10() +
  labs(title = "Income by Zip Code",
       x = "Zip Code", 
       y = "Income ($)")

ggplot(income_filtered, aes(x = zipCode, y = income,  color = zipCode)) +
  geom_point(position = position_jitter(width = 0.4), alpha = 0.1) +
  geom_boxplot(outlier.shape = NA, color = "black", fill = NA, width = 0.8, linewidth = 0.3) +
  scale_y_log10() +
  labs(title = "Income Distribution by Zip Code",
       x = "Zip Code",
       y = "Income ($)") +
  theme(legend.position = "none")

ggplot(income_filtered, aes(x = zipCode, y = income)) +
  geom_point(position = position_jitter(width = 0.3), 
             alpha = 0.2, 
             size = 1) +
  scale_y_log10() +
  labs(title = "Household Income by Zip Code (Jittered Scatter Plot)",
       x = "Zip Code",
       y = "Income (log10 scale)") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

ggplot(income_filtered, aes(x = zipCode, y = income)) +
  geom_boxplot(fill = "lightblue", alpha = 0.7) +
  labs(title = "Average Household Income by Zip Code",
       x = "Zip Codes", y = "Income")

ggplot(income_filtered, aes(x = zipCode, y = income)) +
  geom_boxplot(fill = "lightblue", alpha = 0.7) +
  scale_y_log10() +
  labs(title = "Average Household Income by Zip Code (Log Scale)",
       x = "Zip Codes",
       y = "Income") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

ggplot(income_data, aes(x = zipCode, y = income)) +
  geom_boxplot(fill = "lightblue", alpha = 0.7) +
  labs(title = "Average Household Income by Zip Code",
       x = "Zip Codes", y = "Income")

ggplot(income_data, aes(x = zipCode, y = income)) +
  geom_boxplot(fill = "lightblue", alpha = 0.7) +
  scale_y_log10() +
  labs(title = "Average Household Income by Zip Code (Log Scale)",
       x = "Zip Codes",
       y = "Income") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

data <- read.csv("x.txt", header = TRUE)

ggplot(data,aes(x, y = x ^ 2))+
  geom_line()

