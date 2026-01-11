setwd("/home/romank/studDir/DS_R/lab7/7_R")

survey <- read.csv("survey.csv")

str(survey)
head(survey)
summary(survey)

survey$Price <- as.factor(survey$Price)

model <- glm(MYDEPV ~ Price + Income + Age, data = survey, family = binomial)
 
summary(model)

coef(model)

model_coefs <- coef(model)
coef_names <- names(model_coefs)
coef_values <- as.numeric(model_coefs)
coef_colors <- ifelse(coef_values > 0, "#2E86AB", "#A23B72")

par(mar = c(5, 8, 4, 2))
barplot(coef_values, names.arg = coef_names, 
        horiz = TRUE, las = 1, col = coef_colors,
        main = "Logistic Regression Coefficients",
        xlab = "Coefficient Value", 
        cex.names = 0.9, cex.axis = 0.9, cex.main = 1.1)
abline(v = 0, lwd = 2, col = "black")
grid(nx = NULL, ny = NA, col = "gray90", lty = 1)
legend("topright", 
       legend = c("Positive", "Negative"),
       fill = c("#2E86AB", "#A23B72"), 
       cex = 0.9, bty = "n")
par(mar = c(5, 4, 4, 2))

income_coef <- coef(model)["Income"]
income_or_change <- (exp(income_coef) - 1) * 100
income_or_change

price30_coef <- coef(model)["Price30"]
price30_or_change <- (exp(price30_coef) - 1) * 100
price30_or_change

par(mfrow = c(2, 2))
plot(model, which = 1:4)
par(mfrow = c(1, 1))

survey$Price <- relevel(survey$Price, ref = "30")
model_relevel <- glm(MYDEPV ~ Price + Income + Age, data = survey, family = binomial)
summary(model_relevel)

library(pROC)
predicted_probs <- predict(model, type = "response")
roc_obj <- roc(survey$MYDEPV, predicted_probs, quiet = TRUE)
auc_value <- auc(roc_obj)
plot(roc_obj, main = "ROC Curve - Logistic Regression Model", 
     col = "#2E86AB", lwd = 3, 
     xlab = "False Positive Rate (1 - Specificity)", 
     ylab = "True Positive Rate (Sensitivity)")
abline(a = 0, b = 1, lty = 2, col = "gray50", lwd = 2)
legend("bottomright", 
       legend = paste("AUC =", round(as.numeric(auc_value), 4)),
       col = "#2E86AB", lwd = 3, cex = 1.2, bty = "n")
grid(col = "gray90", lty = 1)
auc_value

new_data <- data.frame(Age = 30, Income = 50, Price = factor("20", levels = c("10", "20", "30")))
predict(model, newdata = new_data, type = "response")

survey$Price <- relevel(survey$Price, ref = "10")
model <- glm(MYDEPV ~ Price + Income + Age, data = survey, family = binomial)

age_seq <- seq(min(survey$Age), max(survey$Age), length.out = 100)
mean_income <- mean(survey$Income)
price_levels <- c("10", "20", "30")
colors_price <- c("#A23B72", "#F18F01", "#C73E1D")

pred_age_all <- data.frame()
for(price_val in price_levels) {
  pred_temp <- data.frame(
    Age = age_seq,
    Income = mean_income,
    Price = factor(price_val, levels = price_levels)
  )
  pred_temp$probability <- predict(model, newdata = pred_temp, type = "response")
  pred_temp$PriceLevel <- price_val
  pred_age_all <- rbind(pred_age_all, pred_temp)
}

plot(pred_age_all$Age[pred_age_all$PriceLevel == "10"], 
     pred_age_all$probability[pred_age_all$PriceLevel == "10"], 
     type = "l", lwd = 3, col = colors_price[1],
     xlab = "Age (years)", ylab = "Predicted Probability", 
     main = "Predicted Probability vs Age\n(Mean Income, Different Prices)",
     ylim = c(0, 1), xlim = c(min(age_seq), max(age_seq)))
lines(pred_age_all$Age[pred_age_all$PriceLevel == "20"], 
      pred_age_all$probability[pred_age_all$PriceLevel == "20"], 
      lwd = 3, col = colors_price[2])
lines(pred_age_all$Age[pred_age_all$PriceLevel == "30"], 
      pred_age_all$probability[pred_age_all$PriceLevel == "30"], 
      lwd = 3, col = colors_price[3])
grid(col = "gray90", lty = 1)
legend("bottomright", 
       legend = c("Price $10", "Price $20", "Price $30"),
       col = colors_price, lwd = 3, cex = 1.0, bty = "n")
abline(h = 0.5, lty = 2, col = "gray50")

income_seq <- seq(min(survey$Income), max(survey$Income), length.out = 100)
mean_age <- mean(survey$Age)

pred_income_all <- data.frame()
for(price_val in price_levels) {
  pred_temp <- data.frame(
    Age = mean_age,
    Income = income_seq,
    Price = factor(price_val, levels = price_levels)
  )
  pred_temp$probability <- predict(model, newdata = pred_temp, type = "response")
  pred_temp$PriceLevel <- price_val
  pred_income_all <- rbind(pred_income_all, pred_temp)
}

plot(pred_income_all$Income[pred_income_all$PriceLevel == "10"], 
     pred_income_all$probability[pred_income_all$PriceLevel == "10"], 
     type = "l", lwd = 3, col = colors_price[1],
     xlab = "Income (thousands $)", ylab = "Predicted Probability",
     main = "Predicted Probability vs Income\n(Mean Age, Different Prices)",
     ylim = c(0, 1), xlim = c(min(income_seq), max(income_seq)))
lines(pred_income_all$Income[pred_income_all$PriceLevel == "20"], 
      pred_income_all$probability[pred_income_all$PriceLevel == "20"], 
      lwd = 3, col = colors_price[2])
lines(pred_income_all$Income[pred_income_all$PriceLevel == "30"], 
      pred_income_all$probability[pred_income_all$PriceLevel == "30"], 
      lwd = 3, col = colors_price[3])
grid(col = "gray90", lty = 1)
legend("bottomright", 
       legend = c("Price $10", "Price $20", "Price $30"),
       col = colors_price, lwd = 3, cex = 1.0, bty = "n")
abline(h = 0.5, lty = 2, col = "gray50")

survey$prediction_prob <- predict(model, type = "response")
survey$prediction_class <- ifelse(survey$prediction_prob > 0.5, 1, 0)

confusion_matrix <- table(Actual = survey$MYDEPV, Predicted = survey$prediction_class)
confusion_matrix

accuracy <- sum(diag(confusion_matrix)) / sum(confusion_matrix)
accuracy

conf_matrix_df <- as.data.frame(confusion_matrix)
colnames(conf_matrix_df) <- c("Actual", "Predicted", "Count")
conf_matrix_wide <- matrix(confusion_matrix, nrow = 2, ncol = 2, 
                           dimnames = list(Actual = c("0", "1"), 
                                         Predicted = c("0", "1")))

par(mar = c(5, 5, 4, 2))
image(1:2, 1:2, conf_matrix_wide, 
      col = colorRampPalette(c("#E8F4F8", "#2E86AB"))(100),
      xlab = "Predicted", ylab = "Actual",
      main = "Confusion Matrix",
      axes = FALSE, xlim = c(0.5, 2.5), ylim = c(0.5, 2.5))
axis(1, at = 1:2, labels = c("0", "1"))
axis(2, at = 1:2, labels = c("0", "1"), las = 1)
text(rep(1:2, each = 2), rep(1:2, 2), 
     labels = as.vector(conf_matrix_wide),
     cex = 1.5, font = 2, col = "white")
text(1.5, 2.5, labels = paste("Accuracy =", round(accuracy * 100, 2), "%"),
     cex = 1.1, font = 2)
par(mar = c(5, 4, 4, 2))

sum_mydepv <- sum(survey$MYDEPV)
sum_predictions <- sum(survey$prediction_prob)
sum_mydepv
sum_predictions
abs(sum_mydepv - sum_predictions)

survey$odds_ratio <- survey$prediction_prob / (1 - survey$prediction_prob)
head(survey[, c("MYDEPV", "prediction_prob", "odds_ratio")])

new_person <- data.frame(
  Age = 25,
  Income = 58,
  Price = factor("20", levels = c("10", "20", "30"))
)
prob_new_person <- predict(model, newdata = new_person, type = "response")
prob_new_person
