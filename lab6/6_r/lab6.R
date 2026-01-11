# Загрузка данных
zeta <- read.csv("zeta.csv")

# Оставляем только записи для женщин (убираем дубликаты по доходу)
zeta <- zeta[zeta$sex == "F", ]

# Удаляем колонки zcta и sex
zeta$zcta <- NULL
zeta$sex <- NULL
zeta$X <- NULL

# Удаление выбросов
zeta <- subset(zeta, 
               # meaneducation > 8 & meaneducation < 18 &
               meanhouseholdincome > 10000 & meanhouseholdincome < 200000 &
               meanemployment > 0 & meanemployment < 3 &
               meanage > 20 & meanage < 60)

# Создание переменной log_income
zeta$log_income <- log10(zeta$meanhouseholdincome)

# Переименование колонок
names(zeta)[names(zeta) == "meanage"] <- "age"
names(zeta)[names(zeta) == "meaneducation"] <- "education"
names(zeta)[names(zeta) == "meanemployment"] <- "employment"

# ===== Анализ линейной регрессии =====

# a. Scatter plot: age vs log_income
plot(zeta$age, zeta$log_income,
     main = "Зависимость log_income от age",
     xlab = "Age", ylab = "Log Income",
     col = "blue", pch = 16, cex = 0.5)

# b. Линейная регрессия log_income ~ age
model_age <- lm(log_income ~ age, data = zeta)
summary(model_age)

# c-e. R-squared и F-statistic уже в summary выше

# f. Scatter plot: education vs log_income  
plot(zeta$education, zeta$log_income,
     main = "Зависимость log_income от education",
     xlab = "Education", ylab = "Log Income",
     col = "green", pch = 16, cex = 0.5)

# g. Линейная регрессия log_income ~ education
model_edu <- lm(log_income ~ education, data = zeta)
summary(model_edu)

# h. Множественная регрессия: log_income ~ age + education + employment
model_multi <- lm(log_income ~ age + education + employment, data = zeta)
summary(model_multi)

# i. Процентное изменение дохода на единицу образования
coef_education <- coef(model_multi)["education"]
percent_change <- (10^coef_education - 1) * 100
print(paste("Изменение дохода на единицу education:", round(percent_change, 2), "%"))

# j. График predicted vs actual
predicted <- predict(model_multi)
actual <- zeta$log_income

plot(actual, predicted,
     main = "Predicted vs Actual (log_income)",
     xlab = "Actual", ylab = "Predicted",
     col = "purple", pch = 16, cex = 0.5)
abline(0, 1, col = "red", lwd = 2)  # линия y = x

# k. Анализ по диапазонам дохода
zeta$income_range <- cut(zeta$meanhouseholdincome, 
                         breaks = c(10000, 50000, 100000, 150000, 200000),
                         labels = c("Low", "Medium", "High", "Very High"))
zeta$predicted <- predicted
zeta$residuals <- actual - predicted

aggregate(residuals ~ income_range, data = zeta, 
          FUN = function(x) c(mean = mean(x), sd = sd(x)))

