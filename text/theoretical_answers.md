# Text Analysis - Theoretical Questions Answers

## Question 4.8: How does TF-IDF enhance the relevance of a search result?

**TF-IDF (Term Frequency-Inverse Document Frequency)** enhances search result relevance by:

1. **Balancing term frequency with rarity**: TF-IDF considers not just how often a term appears in a document (TF), but also how rare it is across the entire collection (IDF).

2. **Downweighting common words**: Words that appear frequently across many documents (like "the", "and", "is") receive lower IDF scores, preventing them from dominating search results.

3. **Emphasizing distinctive terms**: Terms that are frequent in a specific document but rare in the corpus get high TF-IDF scores, making them more relevant for that document.

4. **Improving precision**: By highlighting terms that are characteristic of a document rather than generic, TF-IDF helps search engines return more precise and relevant results.

**Formula**: TF-IDF(t,d) = TF(t,d) × IDF(t)
- TF(t,d) = frequency of term t in document d
- IDF(t) = log(total documents / documents containing term t)

## Question 4.9: Why should we reduce the dimensions in text analysis? How to achieve that?

### Why reduce dimensions:

1. **Curse of dimensionality**: High-dimensional spaces (thousands of features/words) make analysis computationally expensive and prone to overfitting.

2. **Noise reduction**: Many dimensions represent noise or irrelevant variations rather than meaningful patterns.

3. **Computational efficiency**: Lower dimensions mean faster processing, less memory usage, and more efficient algorithms.

4. **Better generalization**: Reducing dimensions can help models generalize better to new data by focusing on the most important features.

5. **Interpretability**: Lower-dimensional representations are easier to visualize and understand.

### How to achieve dimension reduction:

1. **Feature selection**:
   - Remove stop words (common words like "the", "and")
   - Use statistical methods (chi-square, mutual information)
   - Select top N features by frequency or TF-IDF

2. **Feature extraction/transformation**:
   - **PCA (Principal Component Analysis)**: Linear transformation to lower-dimensional space
   - **LSA (Latent Semantic Analysis)**: Uses SVD to find latent semantic dimensions
   - **Topic modeling**: LDA (Latent Dirichlet Allocation) to reduce to topic dimensions
   - **Word embeddings**: Represent words as dense vectors (Word2Vec, GloVe, BERT)

3. **Stemming/Lemmatization**: Reduce word variations to root forms

4. **Thresholding**: Remove terms that appear in too few or too many documents

## Question 4.10: Yoyodyne Bank Text Analysis

### (a) How should Yoyodyne Bank do such a text analysis?

**Step-by-step approach:**

1. **Data Collection**:
   - Set up APIs or web scraping tools to collect posts from Twitter, Facebook, Google+
   - Filter for posts mentioning "Yoyodyne Bank" or relevant keywords
   - Collect metadata (date, user, engagement metrics)

2. **Data Preprocessing**:
   - Clean text (remove URLs, hashtags, special characters)
   - Tokenization
   - Remove stop words
   - Apply stemming/lemmatization
   - Handle multilingual content (if applicable)

3. **Text Analysis Techniques**:
   - **Sentiment Analysis**: Classify posts as positive, negative, or neutral
   - **Topic Modeling**: Use LDA or similar to identify key themes/concerns
   - **Keyword Extraction**: Identify most mentioned topics
   - **TF-IDF Analysis**: Find distinctive terms in customer feedback
   - **Named Entity Recognition**: Identify specific products, services, locations mentioned

4. **Analysis and Visualization**:
   - Create word clouds for different sentiment categories
   - Generate time series of sentiment trends
   - Categorize feedback by topic (fees, customer service, products, etc.)
   - Compare sentiment across different platforms

5. **Actionable Insights**:
   - Identify common complaints and praise points
   - Track changes in sentiment over time
   - Prioritize areas for improvement
   - Monitor response to changes in services

### (b) Advantages and Challenges

**Advantages:**
1. **Real-time feedback**: Get immediate insights from customer opinions
2. **Large sample size**: Access to vast amounts of customer feedback
3. **Cost-effective**: Less expensive than traditional surveys
4. **Unbiased data**: Customers voluntarily express opinions (no survey bias)
5. **Trend identification**: Track changes in customer sentiment over time
6. **Competitive intelligence**: Compare with competitors' mentions

**Challenges:**
1. **Data quality**: Noisy, informal language, slang, abbreviations
2. **Sentiment ambiguity**: Sarcasm, irony, context-dependent meaning
3. **Volume and scale**: Large amounts of data requiring efficient processing
4. **Privacy concerns**: Ethical and legal considerations in data collection
5. **Multilingual content**: Need for translation and cross-language analysis
6. **Spam and bots**: Filtering out fake or promotional content
7. **Representativeness**: Social media users may not represent entire customer base
8. **Context loss**: Short posts may lack context
9. **Technical complexity**: Requires expertise in NLP and data processing
10. **Platform limitations**: API restrictions, rate limits, changing platform policies

## Question 4.11: Bag of Words and Stemming Analysis

### Given Review:
"Sneaky Fees!

Do you carefully read every word on your statement and every notice your bank every sent you? If you've missed one, Yoyodyne Bank is NOT the bank for you! Close all your accounts especially if you're going overseas!!"

### (a) Bag of Words (case-insensitive, stop words removed)

After removing stop words from the Snowball English stop word list, the bag of words would be:

**Words (case-insensitive, stop words removed):**
- sneaky
- fees
- carefully
- read
- word
- statement
- notice
- bank
- sent
- missed
- yoyodyne
- bank
- close
- accounts
- especially
- going
- overseas

**Note**: "bank" appears twice in the original text but would be counted once in a true bag-of-words representation (though it may have frequency = 2).

**Alphabetically sorted bag of words:**
accounts, bank, carefully, close, especially, fees, going, missed, notice, overseas, read, sent, sneaky, statement, word, yoyodyne

### (b) Bag of Words with Stemming

Using the Porter stemming algorithm (Snowball stemmer), the stemmed bag of words would be:

**Original → Stemmed:**
- sneaky → sneaki
- fees → fee
- carefully → care
- read → read
- word → word
- statement → statement
- notice → notic
- bank → bank
- sent → sent
- missed → miss
- yoyodyne → yoyodyn
- bank → bank
- close → close
- accounts → account
- especially → especi
- going → go
- overseas → oversea

**Alphabetically sorted stemmed bag of words:**
account, bank, care, close, especi, fee, go, miss, notic, oversea, read, sent, sneaki, statement, word, yoyodyn

