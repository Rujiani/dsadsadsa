library(rpart)
library(rpart.plot)
library(ROCR)
library(plotly)
library(htmlwidgets)
library(reshape2)

data <- read.csv("survey.csv")
train <- data[1:600, ]
test <- data[601:750, ]

tree_info <- rpart(MYDEPV ~ Price + Income + Age,
                   data = train,
                   method = "class",
                   parms = list(split = "information"),
                   control = rpart.control(xval = 3))

printcp(tree_info)
rpart.plot(tree_info, 
           main = "Classification Tree (Information Gain)",
           type = 4,
           extra = 101,
           box.palette = "RdYlGn",
           branch.lty = 3,
           shadow.col = "gray",
           nn = TRUE)

pred_train <- predict(tree_info, train, type = "class")
conf_train <- table(Actual = train$MYDEPV, Predicted = pred_train)
conf_train

conf_train_df <- as.data.frame.matrix(conf_train)
conf_train_df$Actual <- rownames(conf_train_df)
conf_train_long <- reshape2::melt(conf_train_df, id.vars = "Actual", variable.name = "Predicted", value.name = "Count")

p_conf_train <- plot_ly(conf_train_long, x = ~Predicted, y = ~Actual, z = ~Count, type = "heatmap",
                        colors = colorRamp(c("white", "steelblue", "darkblue")),
                        text = ~paste("Actual:", Actual, "<br>Predicted:", Predicted, "<br>Count:", Count),
                        hoverinfo = "text") %>%
  layout(title = list(text = "Confusion Matrix (Training Data)", font = list(size = 18)),
         xaxis = list(title = "Predicted"),
         yaxis = list(title = "Actual"),
         plot_bgcolor = 'rgb(250, 250, 250)',
         paper_bgcolor = 'white')

print(p_conf_train)
htmlwidgets::saveWidget(p_conf_train, "confusion_matrix_train.html")

resub_error <- 1 - sum(diag(conf_train)) / sum(conf_train)
resub_error

pred_prob <- predict(tree_info, train, type = "prob")[,2]
pred_obj <- prediction(pred_prob, train$MYDEPV)
perf <- performance(pred_obj, "tpr", "fpr")
auc <- performance(pred_obj, "auc")@y.values[[1]]

roc_data <- data.frame(
  FPR = perf@x.values[[1]],
  TPR = perf@y.values[[1]]
)

p_roc <- plot_ly(roc_data, x = ~FPR, y = ~TPR, type = 'scatter', mode = 'lines',
                 line = list(color = 'rgb(0, 100, 200)', width = 3),
                 name = paste0('ROC Curve (AUC = ', round(auc, 3), ')'),
                 hovertemplate = 'FPR: %{x:.3f}<br>TPR: %{y:.3f}<extra></extra>') %>%
  add_trace(x = c(0, 1), y = c(0, 1), mode = 'lines',
            line = list(color = 'gray', dash = 'dash', width = 2),
            name = 'Random Classifier') %>%
  layout(title = list(text = 'ROC Curve (Training Data)', font = list(size = 18)),
         xaxis = list(title = 'False Positive Rate', range = c(0, 1)),
         yaxis = list(title = 'True Positive Rate', range = c(0, 1)),
         hovermode = 'closest',
         legend = list(x = 0.7, y = 0.2),
         plot_bgcolor = 'rgb(250, 250, 250)',
         paper_bgcolor = 'white')

print(p_roc)
htmlwidgets::saveWidget(p_roc, "roc_curve.html")
auc

pred_test <- predict(tree_info, test, type = "class")
conf_test <- table(Actual = test$MYDEPV, Predicted = pred_test)
conf_test

conf_test_df <- as.data.frame.matrix(conf_test)
conf_test_df$Actual <- rownames(conf_test_df)
conf_test_long <- reshape2::melt(conf_test_df, id.vars = "Actual", variable.name = "Predicted", value.name = "Count")

p_conf_test <- plot_ly(conf_test_long, x = ~Predicted, y = ~Actual, z = ~Count, type = "heatmap",
                       colors = colorRamp(c("white", "steelblue", "darkblue")),
                       text = ~paste("Actual:", Actual, "<br>Predicted:", Predicted, "<br>Count:", Count),
                       hoverinfo = "text") %>%
  layout(title = list(text = "Confusion Matrix (Test Data)", font = list(size = 18)),
         xaxis = list(title = "Predicted"),
         yaxis = list(title = "Actual"),
         plot_bgcolor = 'rgb(250, 250, 250)',
         paper_bgcolor = 'white')

print(p_conf_test)
htmlwidgets::saveWidget(p_conf_test, "confusion_matrix_test.html")

accuracy_test <- sum(diag(conf_test)) / sum(conf_test)
accuracy_test

tree_gini <- rpart(MYDEPV ~ Price + Income + Age,
                   data = train,
                   method = "class",
                   parms = list(split = "gini"),
                   control = rpart.control(xval = 3))

printcp(tree_gini)
rpart.plot(tree_gini, 
           main = "Classification Tree (Gini)",
           type = 4,
           extra = 101,
           box.palette = "RdYlGn",
           branch.lty = 3,
           shadow.col = "gray",
           nn = TRUE)

best_cp <- tree_gini$cptable[which.min(tree_gini$cptable[,"xerror"]), "CP"]
tree_pruned <- prune(tree_gini, cp = best_cp)

printcp(tree_pruned)
rpart.plot(tree_pruned, 
           main = "Pruned Tree (Gini)",
           type = 4,
           extra = 101,
           box.palette = "RdYlGn",
           branch.lty = 3,
           shadow.col = "gray",
           nn = TRUE)

pred_gini <- predict(tree_gini, train, type = "class")
conf_gini <- table(Actual = train$MYDEPV, Predicted = pred_gini)
conf_gini
accuracy_gini <- sum(diag(conf_gini)) / sum(conf_gini)
accuracy_gini

pred_pruned <- predict(tree_pruned, train, type = "class")
conf_pruned <- table(Actual = train$MYDEPV, Predicted = pred_pruned)
conf_pruned
accuracy_pruned <- sum(diag(conf_pruned)) / sum(conf_pruned)
accuracy_pruned

comparison_data <- data.frame(
  Model = c("Before Pruning", "After Pruning"),
  Accuracy = c(accuracy_gini, accuracy_pruned),
  Variables = c(3, 2)
)

p_comparison <- plot_ly(comparison_data, x = ~Model, y = ~Accuracy, type = "bar",
                        marker = list(color = c("rgb(70, 130, 180)", "rgb(255, 140, 0)"),
                                      line = list(color = "rgb(0,0,0)", width = 1.5)),
                        text = ~paste("Accuracy:", round(Accuracy, 3), "<br>Variables:", Variables),
                        hoverinfo = "text") %>%
  layout(title = list(text = "Model Comparison: Before vs After Pruning", font = list(size = 18)),
         xaxis = list(title = "Model"),
         yaxis = list(title = "Accuracy", range = c(0.85, 0.95)),
         plot_bgcolor = 'rgb(250, 250, 250)',
         paper_bgcolor = 'white',
         showlegend = FALSE)

print(p_comparison)
htmlwidgets::saveWidget(p_comparison, "model_comparison.html")


