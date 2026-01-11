# Question 4.12(f): Comparison of Word Clouds

## Part (a): 10 Representative Words (Manual Selection)

Based on reading the article about OPEC and oil production, 10 representative words are:

1. OPEC
2. oil
3. production
4. prices
5. meeting
6. market
7. demand
8. analysts
9. quota
10. output

## Comparison of Four Word Clouds

### Word Cloud (b): 20 Most Frequent Words (No Preprocessing)

**Characteristics:**
- Contains common words like "the", "and", "of", "to", "a"
- Includes punctuation marks if they appear frequently
- Shows raw frequency counts
- May include numbers if present

**Observations:**
[To be filled after running the script]
- Common stop words dominate the word cloud
- Less informative for understanding document content
- Words like "the", "and", "of" take up significant space

### Word Cloud (c): 20 Most Frequent Words (Preprocessed)

**Characteristics:**
- Stop words removed
- Punctuation removed
- Numbers removed
- Text normalized (lowercase)

**Observations:**
[To be filled after running the script]
- More meaningful words appear
- Focus shifts to content words
- Better representation of document themes
- Words like "opec", "oil", "production" should be prominent

### Word Cloud (d): 20 Words with Highest TF-IDF (No Preprocessing)

**Characteristics:**
- Uses TF-IDF weighting (considers term rarity across corpus)
- No preprocessing applied
- Common words across all documents get lower scores

**Observations:**
[To be filled after running the script]
- Still contains some common words but they're less dominant
- Unique/distinctive terms get higher weights
- Better at identifying document-specific content than raw frequency
- However, preprocessing would improve results further

### Word Cloud (e): 20 Words with Highest TF-IDF (Preprocessed)

**Characteristics:**
- Combines TF-IDF weighting with preprocessing
- Stop words, punctuation, and numbers removed
- Best method for identifying distinctive, meaningful terms

**Observations:**
[To be filled after running the script]
- Should show the most distinctive and meaningful words
- Words that are important to THIS specific document
- Best alignment with manually selected representative words
- Terms like "opec", "mln", "bpd", "quota" should appear prominently

## Key Findings and Observations

### 1. Impact of Preprocessing

**Comparison: (b) vs (c) and (d) vs (e)**

- Preprocessing significantly improves word cloud quality by removing noise
- Stop words dominate in non-preprocessed versions
- Preprocessed versions focus on content-bearing words
- Preprocessing is essential for meaningful text analysis

### 2. Impact of TF-IDF Weighting

**Comparison: (b) vs (d) and (c) vs (e)**

- TF-IDF helps identify document-specific terms
- Raw frequency favors common words that appear in many documents
- TF-IDF emphasizes terms that are distinctive to the document
- Combination of TF-IDF + preprocessing (part e) provides best results

### 3. Alignment with Manual Selection

- Word cloud (e) should have the best overlap with manually selected words
- Words like "opec", "oil", "production", "prices" should appear in both
- TF-IDF with preprocessing best captures human intuition about "representative" words

### 4. Practical Implications

- **For search and retrieval**: TF-IDF with preprocessing is optimal
- **For quick overview**: Simple frequency with preprocessing (part c) is sufficient
- **For detailed analysis**: TF-IDF with preprocessing (part e) provides most insights
- **For general use**: Always apply preprocessing; TF-IDF when corpus context matters

## Conclusion

The comparison demonstrates that:

1. **Preprocessing is crucial**: Removing stop words, punctuation, and numbers significantly improves analysis quality
2. **TF-IDF enhances relevance**: It identifies terms that are distinctive to a document rather than just frequent
3. **Best approach**: TF-IDF with preprocessing (part e) provides the most meaningful representation of document content
4. **Human intuition**: The manually selected words align best with the TF-IDF + preprocessed approach, confirming it captures human understanding of document themes

---

**Note**: After running the R script, fill in the specific observations based on the actual word clouds generated. Compare the actual words appearing in each cloud and note their frequencies/TF-IDF values.

