setwd("~/studDir/DS_R/lab4")

if (!require("RODBC")) install.packages("RODBC", repos = "https://cloud.r-project.org")
if (!require("ggplot2")) install.packages("ggplot2", repos = "https://cloud.r-project.org")
if (!require("dplyr")) install.packages("dplyr", repos = "https://cloud.r-project.org")
if (!require("cluster")) install.packages("cluster", repos = "https://cloud.r-project.org")
if (!require("factoextra")) install.packages("factoextra", repos = "https://cloud.r-project.org")
if (!require("usmap")) install.packages("usmap", repos = "https://cloud.r-project.org")

library(RODBC)
library(ggplot2)
library(dplyr)
library(cluster)
library(factoextra)
library(usmap)

load("income_elec_state.Rdata")

print(head(income_elec_state))
print(summary(income_elec_state))

cluster_data <- as.matrix(income_elec_state[, c("income", "elec")])

# 4.1a - K-means с k=10
set.seed(123)
km_10 <- kmeans(cluster_data, centers = 10, nstart = 25)

print(km_10$size)
print(km_10$centers)

par(mfrow = c(1, 1))
plot(cluster_data, 
     col = km_10$cluster,
     bg = NA,
     pch = 21,
     cex = 1.5,
     lwd = 2,
     main = "K-means Clustering of US States (k=10)",
     xlab = "Mean Household Income ($)",
     ylab = "Mean Household Electricity Usage ($)")

points(km_10$centers, col = 1:10, pch = 8, cex = 1.2, lwd = 1.5)

legend("topright", 
       legend = paste("Cluster", 1:10),
       col = 1:10, 
       pch = 21,
       pt.bg = NA,
       cex = 0.7)

text(cluster_data, labels = rownames(cluster_data), pos = 3, cex = 0.5)

df_plot <- data.frame(
  state = rownames(cluster_data),
  income = cluster_data[, "income"],
  electricity = cluster_data[, "elec"],
  cluster = as.factor(km_10$cluster)
)

centers_df <- data.frame(
  income = km_10$centers[, "income"],
  electricity = km_10$centers[, "elec"],
  cluster = as.factor(1:10)
)

p1 <- ggplot(df_plot, aes(x = income, y = electricity, color = cluster)) +
  geom_point(shape = 21, size = 4, fill = NA, stroke = 1.5) +
  geom_point(data = centers_df, aes(x = income, y = electricity), 
             shape = 8, size = 3, stroke = 1.2, show.legend = FALSE) +
  geom_text(aes(label = state), hjust = 0, vjust = -0.5, size = 2.5, show.legend = FALSE) +
  labs(title = "K-means Clustering of US States (k=10)",
       x = "Mean Household Income ($)",
       y = "Mean Household Electricity Usage ($)",
       color = "Cluster") +
  theme_minimal() +
  theme(legend.position = "right")

print(p1)
ggsave("kmeans_k10.png", p1, width = 12, height = 8, dpi = 150)

# 4.1b - Проверка воспроизводимости
for (i in 1:5) {
  km_temp <- kmeans(cluster_data, centers = 10, nstart = 1)
  print(sprintf("Run %d - Total within-cluster SS: %.2f", i, km_temp$tot.withinss))
}

# 4.1c - Определение оптимального k
set.seed(123)
wss <- numeric(15)
for (i in 1:15) {
  wss[i] <- sum(kmeans(cluster_data, centers = i, nstart = 25)$withinss)
}

par(mfrow = c(1, 1))
plot(1:15, wss, type = "b", 
     pch = 19, 
     xlab = "Number of Clusters (k)",
     ylab = "Within-groups Sum of Squares",
     main = "Elbow Method for Optimal k")

elbow_point <- 3
abline(v = elbow_point, lty = 2, col = "red")
text(elbow_point + 0.5, max(wss) * 0.8, paste("Suggested k =", elbow_point), col = "red")

sil_width <- numeric(14)
for (i in 2:15) {
  km_temp <- kmeans(cluster_data, centers = i, nstart = 25)
  sil <- silhouette(km_temp$cluster, dist(cluster_data))
  sil_width[i-1] <- mean(sil[, 3])
}

plot(2:15, sil_width, type = "b",
     pch = 19,
     xlab = "Number of Clusters (k)",
     ylab = "Average Silhouette Width",
     main = "Silhouette Method for Optimal k")

optimal_k_sil <- which.max(sil_width) + 1
abline(v = optimal_k_sil, lty = 2, col = "blue")
text(optimal_k_sil + 0.5, max(sil_width) * 0.9, paste("Optimal k =", optimal_k_sil), col = "blue")

# Сравнение k=10 vs k=3 (оптимальное)
set.seed(123)
km_3 <- kmeans(cluster_data, centers = 3, nstart = 25)

par(mfrow = c(1, 2))

plot(cluster_data, 
     col = km_10$cluster,
     bg = NA,
     pch = 21,
     cex = 1.5,
     lwd = 2,
     main = "K-means: k=10 (переобучение)",
     xlab = "Income ($)",
     ylab = "Electricity ($)")
points(km_10$centers, col = 1:10, pch = 8, cex = 1.2, lwd = 1.5)

plot(cluster_data, 
     col = km_3$cluster,
     bg = NA,
     pch = 21,
     cex = 1.5,
     lwd = 2,
     main = "K-means: k=3 (оптимальное)",
     xlab = "Income ($)",
     ylab = "Electricity ($)")
points(km_3$centers, col = 1:3, pch = 8, cex = 1.5, lwd = 2)

par(mfrow = c(1, 1))

# ggplot сравнение k=10 vs k=3
df_k3 <- data.frame(
  state = rownames(cluster_data),
  income = cluster_data[, "income"],
  electricity = cluster_data[, "elec"],
  cluster = as.factor(km_3$cluster)
)

centers_k3 <- data.frame(
  income = km_3$centers[, "income"],
  electricity = km_3$centers[, "elec"],
  cluster = as.factor(1:3)
)

p_k3 <- ggplot(df_k3, aes(x = income, y = electricity, color = cluster)) +
  geom_point(shape = 21, size = 4, fill = NA, stroke = 1.5) +
  geom_point(data = centers_k3, aes(x = income, y = electricity), 
             shape = 8, size = 4, stroke = 1.5, show.legend = FALSE) +
  geom_text(aes(label = state), hjust = 0, vjust = -0.5, size = 2.5, show.legend = FALSE) +
  labs(title = "K-means Clustering: k=3 (Optimal)",
       x = "Mean Household Income ($)",
       y = "Mean Household Electricity Usage ($)",
       color = "Cluster") +
  theme_minimal() +
  theme(legend.position = "right")

print(p_k3)
ggsave("kmeans_k3_optimal.png", p_k3, width = 12, height = 8, dpi = 150)

print(sprintf("k=10: Total WSS = %.0f", km_10$tot.withinss))
print(sprintf("k=3:  Total WSS = %.0f", km_3$tot.withinss))
print(sprintf("k=3 cluster sizes: %s", paste(km_3$size, collapse = ", ")))

# 4.1d - Log10 трансформация
cluster_data_log <- log10(cluster_data)

set.seed(123)
km_log_10 <- kmeans(cluster_data_log, centers = 10, nstart = 25)

print(km_log_10$size)
print(km_log_10$centers)

par(mfrow = c(1, 2))

plot(cluster_data, 
     col = km_10$cluster,
     bg = NA,
     pch = 21,
     cex = 1.5,
     lwd = 2,
     main = "Original Scale (k=10)",
     xlab = "Income ($)",
     ylab = "Electricity ($)")
points(km_10$centers, col = 1:10, pch = 8, cex = 1.2, lwd = 1.5)
text(cluster_data, labels = rownames(cluster_data), pos = 3, cex = 0.4)

plot(cluster_data_log, 
     col = km_log_10$cluster,
     bg = NA,
     pch = 21,
     cex = 1.5,
     lwd = 2,
     main = "Log10 Scale (k=10)",
     xlab = "Log10(Income)",
     ylab = "Log10(Electricity)")
points(km_log_10$centers, col = 1:10, pch = 8, cex = 1.2, lwd = 1.5)
text(cluster_data_log, labels = rownames(cluster_data_log), pos = 3, cex = 0.4)

par(mfrow = c(1, 1))

df_plot_log <- data.frame(
  state = rownames(cluster_data_log),
  income = cluster_data_log[, "income"],
  electricity = cluster_data_log[, "elec"],
  cluster = as.factor(km_log_10$cluster)
)

centers_df_log <- data.frame(
  income = km_log_10$centers[, "income"],
  electricity = km_log_10$centers[, "elec"],
  cluster = as.factor(1:10)
)

p_log <- ggplot(df_plot_log, aes(x = income, y = electricity, color = cluster)) +
  geom_point(shape = 21, size = 4, fill = NA, stroke = 1.5) +
  geom_point(data = centers_df_log, aes(x = income, y = electricity), 
             shape = 8, size = 3, stroke = 1.2, show.legend = FALSE) +
  geom_text(aes(label = state), hjust = 0, vjust = -0.5, size = 2.5, show.legend = FALSE) +
  labs(title = "K-means Clustering of US States - Log10 Scale (k=10)",
       x = "Log10(Mean Household Income)",
       y = "Log10(Mean Household Electricity Usage)",
       color = "Cluster") +
  theme_minimal() +
  theme(legend.position = "right")

print(p_log)
ggsave("kmeans_k10_log.png", p_log, width = 12, height = 8, dpi = 150)

# 4.1e - Переоценка k на log данных
set.seed(123)
wss_log <- numeric(15)
for (i in 1:15) {
  wss_log[i] <- sum(kmeans(cluster_data_log, centers = i, nstart = 25)$withinss)
}

par(mfrow = c(1, 2))
plot(1:15, wss, type = "b", pch = 19,
     xlab = "Number of Clusters", ylab = "WSS",
     main = "Elbow: Original Scale")
plot(1:15, wss_log, type = "b", pch = 19,
     xlab = "Number of Clusters", ylab = "WSS",
     main = "Elbow: Log10 Scale")
par(mfrow = c(1, 1))

# Сравнение k=10 vs k=3 на log данных
set.seed(123)
km_log_3 <- kmeans(cluster_data_log, centers = 3, nstart = 25)

par(mfrow = c(1, 2))

plot(cluster_data_log, 
     col = km_log_10$cluster,
     bg = NA, pch = 21, cex = 1.5, lwd = 2,
     main = "Log Scale: k=10",
     xlab = "Log10(Income)", ylab = "Log10(Electricity)")
points(km_log_10$centers, col = 1:10, pch = 8, cex = 1.2, lwd = 1.5)

plot(cluster_data_log, 
     col = km_log_3$cluster,
     bg = NA, pch = 21, cex = 1.5, lwd = 2,
     main = "Log Scale: k=3 (optimal)",
     xlab = "Log10(Income)", ylab = "Log10(Electricity)")
points(km_log_3$centers, col = 1:3, pch = 8, cex = 1.5, lwd = 2)

par(mfrow = c(1, 1))

df_log_k3 <- data.frame(
  state = rownames(cluster_data_log),
  income = cluster_data_log[, "income"],
  electricity = cluster_data_log[, "elec"],
  cluster = as.factor(km_log_3$cluster)
)

centers_log_k3 <- data.frame(
  income = km_log_3$centers[, "income"],
  electricity = km_log_3$centers[, "elec"],
  cluster = as.factor(1:3)
)

p_log_k3 <- ggplot(df_log_k3, aes(x = income, y = electricity, color = cluster)) +
  geom_point(shape = 21, size = 4, fill = NA, stroke = 1.5) +
  geom_point(data = centers_log_k3, aes(x = income, y = electricity), 
             shape = 8, size = 4, stroke = 1.5, show.legend = FALSE) +
  geom_text(aes(label = state), hjust = 0, vjust = -0.5, size = 2.5, show.legend = FALSE) +
  labs(title = "K-means Log10 Scale: k=3 (Optimal)",
       x = "Log10(Income)", y = "Log10(Electricity)",
       color = "Cluster") +
  theme_minimal() +
  theme(legend.position = "right")

print(p_log_k3)
ggsave("kmeans_k3_log_optimal.png", p_log_k3, width = 12, height = 8, dpi = 150)

print(sprintf("Log k=10: Total WSS = %.4f", km_log_10$tot.withinss))
print(sprintf("Log k=3:  Total WSS = %.4f", km_log_3$tot.withinss))

# 4.1f - Поиск и удаление выбросов
print(summary(cluster_data))

par(mfrow = c(1, 2))
boxplot(cluster_data[, "income"], main = "Income", ylab = "$")
boxplot(cluster_data[, "elec"], main = "Electricity", ylab = "$")
par(mfrow = c(1, 1))

income_q1 <- quantile(cluster_data[, "income"], 0.25)
income_q3 <- quantile(cluster_data[, "income"], 0.75)
income_iqr <- income_q3 - income_q1
income_lower <- income_q1 - 1.5 * income_iqr
income_upper <- income_q3 + 1.5 * income_iqr

outlier_idx <- which(cluster_data[, "income"] < income_lower | 
                     cluster_data[, "income"] > income_upper)

if (length(outlier_idx) > 0) {
  print(income_elec_state[outlier_idx, ])
} else {
  low_income_states <- rownames(cluster_data)[cluster_data[, "income"] < 30000]
  if (length(low_income_states) > 0) {
    print(income_elec_state[rownames(income_elec_state) %in% low_income_states, ])
    outlier_idx <- which(rownames(cluster_data) %in% low_income_states)
  }
}

if (length(outlier_idx) > 0) {
  cluster_data_no_outlier <- cluster_data[-outlier_idx, ]
  
  set.seed(123)
  wss_no_outlier <- numeric(15)
  for (i in 1:15) {
    wss_no_outlier[i] <- sum(kmeans(cluster_data_no_outlier, centers = i, nstart = 25)$withinss)
  }
  
  par(mfrow = c(1, 2))
  plot(1:15, wss, type = "b", pch = 19,
       xlab = "Number of Clusters", ylab = "WSS",
       main = "With Outliers")
  plot(1:15, wss_no_outlier, type = "b", pch = 19,
       xlab = "Number of Clusters", ylab = "WSS",
       main = "Without Outliers")
  par(mfrow = c(1, 1))
} else {
  cluster_data_no_outlier <- cluster_data
}

# 4.1g - Карта США
optimal_k <- 4
set.seed(123)
km_final <- kmeans(cluster_data_no_outlier, centers = optimal_k, nstart = 25)

cluster_vector <- km_final$cluster
names(cluster_vector) <- rownames(cluster_data_no_outlier)

map_data_df <- data.frame(
  state = names(cluster_vector),
  cluster = as.factor(cluster_vector)
)

print(map_data_df[order(map_data_df$cluster), ])

p_map <- plot_usmap(data = map_data_df, values = "cluster", 
                    include = c(.south_region, .northeast_region, 
                               .north_central_region, .west_region),
                    color = "black", linewidth = 0.3) +
  scale_fill_brewer(palette = "Set1", name = "Cluster") +
  labs(title = paste("US States Clustered by Income & Electricity (k=", optimal_k, ")", sep = ""),
       subtitle = "48 contiguous states") +
  theme(legend.position = "right",
        plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
        plot.subtitle = element_text(hjust = 0.5))

print(p_map)
ggsave("us_map_clusters.png", p_map, width = 10, height = 7, dpi = 150)

for (i in 1:optimal_k) {
  states_in_cluster <- rownames(cluster_data_no_outlier)[km_final$cluster == i]
  print(sprintf("Cluster %d: %s", i, paste(states_in_cluster, collapse = ", ")))
}

# 4.1b - Иерархическая кластеризация
d <- dist(cluster_data, method = "euclidean")

linkage_methods <- c("complete", "single", "average", "ward.D2")

hc_list <- list()

for (method in linkage_methods) {
  hc <- hclust(d, method = method)
  hc_list[[method]] <- hc
  
  par(mar = c(5, 4, 3, 2))
  plot(hc, main = paste("Hierarchical Clustering:", toupper(method)),
       xlab = "", ylab = "Height", sub = "", cex = 0.7)
  rect.hclust(hc, k = 4, border = "red")
  
  png(paste0("hclust_", method, ".png"), width = 2000, height = 500, res = 100)
  par(mar = c(5, 4, 3, 2))
  plot(hc, main = paste("Hierarchical Clustering:", toupper(method)),
       xlab = "", ylab = "Height", sub = "", cex = 0.9)
  rect.hclust(hc, k = 4, border = "red")
  dev.off()
}

for (method in linkage_methods) {
  clusters <- cutree(hc_list[[method]], k = 5)
  print(sprintf("%s linkage - Cluster sizes: %s", 
                toupper(method), 
                paste(table(clusters), collapse = ", ")))
}

if (require(factoextra)) {
  fviz_dend(hc_list[["ward.D2"]], k = 5,
            cex = 0.5,
            main = "Hierarchical Clustering (Ward's Method)",
            xlab = "States",
            ylab = "Height",
            color_labels_by_k = TRUE,
            rect = TRUE)
}
