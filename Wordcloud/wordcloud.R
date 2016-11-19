library(tm)
library(cluster)
library(SnowballC)
library(RColorBrewer)
library(wordcloud)


setwd("C:/Users/Vishak/Documents/Code/R")

# Reaading the data from the text file
data <- read.csv("Big1.csv",header = T,stringsAsFactors = F)

# Converting data to utf-8 encoding
data <- iconv(data,"latin1", "ASCII", sub="")
# Creating a corpus where each line is taken as a document
corpus <- Corpus(VectorSource(data))

# Removing punctuation marks in the corpus
corpus <- tm_map(corpus,removePunctuation)

for(j in seq(corpus))
{
  corpus[[j]] <- gsub("/", " ", corpus[[j]])
  corpus[[j]] <- gsub("@", " ", corpus[[j]])
  corpus[[j]] <- gsub("\\|", " ", corpus[[j]])
  corpus[[j]] <- gsub("http+", "", corpus[[j]],ignore.case = T, perl = T)
  
}
corpus <- tm_map(corpus,removeNumbers)

# Changing the case of each letter in the corpus to lower case
corpus <- tm_map(corpus,tolower)

# creating a vector of the stop words to be removed
sw <- c("rt",stopwords("english"))

# Removing the stop words
corpus <- tm_map(corpus,removeWords,sw)

# Stemming the document
corpus <- tm_map(corpus,stemDocument)

# Removing white spaces in the corpus
corpus <- tm_map(corpus,stripWhitespace)
corpus <- tm_map(corpus,PlainTextDocument)
dtm <- TermDocumentMatrix(corpus)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
head(d, 10)

set.seed(1000)
wordcloud(words = d$word, freq = d$freq, min.freq = 50, max.words=200, random.order=FALSE, rot.per=0.35, colors=brewer.pal(8, "Dark2"))


