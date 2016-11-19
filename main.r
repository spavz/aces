library(tm)
library(cluster)

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
  corpus[[j]] <- gsub("\\|", " ",corpus[[j]])
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
da<-d
head(da)
rownames(d)<-NULL

# Finding the frequent terms with minimum number of occurences as 50
freq_terms <- findFreqTerms(dtm,lowfreq = 50)
tail(freq_terms)

# creating a sparse matrix with the percentage of sparsity as 90%
dtms <- removeSparseTerms(dtm,0.9)

# k-means clustering using euclidian as a measurement method
d <- dist(t(dtms), method="euclidian")
# Finding k-means
kfit <- kmeans(d, 4)

pam.res <- pam(da, 4)
# Visualize
fviz_cluster(pam.res)
