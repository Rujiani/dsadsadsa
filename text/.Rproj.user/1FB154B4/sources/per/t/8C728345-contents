library("tm")
library("wordcloud")

data("crude")
doc2 <- crude[2]

dtm_b <- DocumentTermMatrix(doc2,
                           control = list(
                             removePunctuation = FALSE,
                             removeNumbers = FALSE
                           ))

freq_b <- colSums(as.matrix(dtm_b))
freq_b <- sort(freq_b, decreasing = TRUE)
top20_b <- head(freq_b, 20)

wordcloud(names(top20_b), top20_b, max.words = 20, 
          colors = brewer.pal(8, "Dark2"), random.order = FALSE)

dtm_c <- DocumentTermMatrix(doc2,
                           control = list(
                             removePunctuation = TRUE,
                             removeNumbers = TRUE,
                             stopwords = TRUE,
                             tolower = TRUE
                           ))

freq_c <- colSums(as.matrix(dtm_c))
freq_c <- sort(freq_c, decreasing = TRUE)
top20_c <- head(freq_c, 20)

wordcloud(names(top20_c), top20_c, max.words = 20,
          colors = brewer.pal(8, "Set2"), random.order = FALSE)

dtm_d <- DocumentTermMatrix(crude,
                           control = list(
                             weighting = weightTfIdf,
                             removePunctuation = FALSE,
                             removeNumbers = FALSE
                           ))

doc2_tfidf <- as.matrix(dtm_d[2, ])
doc2_tfidf_sorted <- sort(doc2_tfidf[1, ], decreasing = TRUE)
top20_d <- head(doc2_tfidf_sorted, 20)

wordcloud(names(top20_d), top20_d, max.words = 20,
          colors = brewer.pal(8, "Accent"), random.order = FALSE)

dtm_e <- DocumentTermMatrix(crude,
                           control = list(
                             weighting = weightTfIdf,
                             removePunctuation = TRUE,
                             removeNumbers = TRUE,
                             stopwords = TRUE,
                             tolower = TRUE
                           ))

doc2_tfidf_e <- as.matrix(dtm_e[2, ])
doc2_tfidf_sorted_e <- sort(doc2_tfidf_e[1, ], decreasing = TRUE)
top20_e <- head(doc2_tfidf_sorted_e, 20)

wordcloud(names(top20_e), top20_e, max.words = 20,
          colors = brewer.pal(8, "Set1"), random.order = FALSE)


print(dtm_e)
print(head(top20_b, 20))
print(head(top20_c, 20))
print(head(top20_d, 20))
print(head(top20_e, 20))
