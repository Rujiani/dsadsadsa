# Text Analysis Assignment Solutions

This directory contains solutions for the text analysis assignment questions 4.8-4.12.

## Files

1. **theoretical_answers.md** - Answers to questions 4.8-4.11 (theoretical/conceptual questions)
2. **text_analysis_4.12.R** - R script for question 4.12 (practical analysis)
3. **comparison_4.12f.md** - Template for comparison and observations (question 4.12f)
4. **stop.txt** - Snowball English stop word list (used for question 4.11)

## Running the R Script (Question 4.12)

### Prerequisites

Make sure you have R installed and the required packages:

```r
install.packages("tm")
install.packages("wordcloud")
```

### Execution

1. Open R or RStudio
2. Set your working directory to this folder:
   ```r
   setwd("/home/romank/studDir/DS_R/text")
   ```
3. Run the script:
   ```r
   source("text_analysis_4.12.R")
   ```

### Output

The script will generate 4 PNG files with word clouds:
- `wordcloud_b_freq_only.png` - Part (b): 20 most frequent words (no preprocessing)
- `wordcloud_c_freq_preprocessed.png` - Part (c): 20 most frequent words (preprocessed)
- `wordcloud_d_tfidf_only.png` - Part (d): 20 words with highest TF-IDF (no preprocessing)
- `wordcloud_e_tfidf_preprocessed.png` - Part (e): 20 words with highest TF-IDF (preprocessed)

The script will also print summary statistics to the console.

### Part (a) - Manual Work Required

For part (a), you need to read the article (the 2nd document in the crude corpus) and manually identify 10 representative words. The article text is provided in the problem statement. You can also view it in R:

```r
library("tm")
data("crude")
inspect(crude[2])  # View the 2nd article
```

### Part (f) - Comparison

After running the script and viewing the word clouds:
1. Compare the 4 word clouds visually
2. Review the word lists printed to the console
3. Compare them with your manually selected words from part (a)
4. Fill in the observations in `comparison_4.12f.md` or create your own report

## Question Overview

- **4.8**: TF-IDF and search relevance (theoretical)
- **4.9**: Dimension reduction in text analysis (theoretical)
- **4.10**: Yoyodyne Bank text analysis case study (theoretical + practical approach)
- **4.11**: Bag of words and stemming exercise (practical)
- **4.12**: Word cloud analysis using R (practical programming)

## Notes

- The R script uses the `crude` dataset from the `tm` package, which contains 20 news articles about crude oil
- The script analyzes the 2nd document in this corpus
- All word clouds show the top 20 words as specified
- Different color schemes are used for each word cloud to help distinguish them


