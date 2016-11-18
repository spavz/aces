library(twitteR)
library(RCurl)

customer_key <- "XFqbN7chVAA8nur8afEr0aTlc"
customer_secret <- "VdKllwLXjNx9dvZBKogsSXFSWbFUwDEfnM6QqfahUu8wnm8naw"
access_token <- "2204794716-HIk9Z249w2kAZjvaEcW7RfnxUJtqs9knya7J8Uu"
access_secret <- "d5bNbgve8rQfx0LhOftlFpVihEez4ixnUvSoGidHlTMEO"
setup_twitter_oauth(customer_key,customer_secret,access_token,access_secret)



setwd("C:/Users/Vishak/Documents/Code/R")

n <- c(1,2,3,4,5)



tweets <- searchTwitter('#git', n=10)
tweets <- twListToDF(tweets)


write.csv(tweets$text,"data.csv",row.names = F)


library(tm)
library(cluster)

# Reaading the data from the text file
data <- read.csv("data.csv",header = T,stringsAsFactors = F)
data <- readLines("tweets.txt")

# Converting data to utf-8 encoding
data <- iconv(data,to = "utf-8")

# Creating a corpus where each line is taken as a document
corpus <- Corpus(VectorSource(data))

# Removing punctuation marks in the corpus
corpus <- tm_map(corpus,removePunctuation)

# Replacing the '/','@' characters that occur in links by space
corpus <- tm_map(corpus,toSpace,'/')
corpus <- tm_map(corpus,toSpace,'@')
corpus <- tm_map(corpus,toSpace,'\\|')

# Removing Numbers from the corpus
corpus <- tm_map(corpus,removeNumbers)

# Changing the case of each letter in the corpus to lower case
corpus <- tm_map(corpus,tolower)

# creating a vector of the stop words to be removed
sw <- c("rt",stopwords("english"),stopwords("spanish"))

# Removing the stop words
corpus <- tm_map(corpus,removeWords,sw)

# Stemming the document
corpus <- tm_map(corpus,stemDocument)

# Removing white spaces in the corpus
corpus <- tm_map(corpus,stripWhitespace)

# converting the corpus into plaintextdocument
corpus <- tm_map(corpus,PlainTextDocument)

# Generating the document term matrix
dtm <- DocumentTermMatrix(corpus)

# checking out the matrix 
inspect(dtm)

# As we have taken the corpus from a text file the rownames are stored as character(0)
# We have to change it to the tweet_id or tweet_number
rownames(dtm) <- c(1:nrow(dtm))

# Generating the matrix form of dtm
m <- as.matrix(dtm)

# Sorting the matrix in Descending order
v <- sort(colSums(m),decreasing=TRUE)

# Converting 'v' into a data frame and storing it in the variable 'd'
d <- data.frame(word = names(v),freq=v)

# Here the row names will be same as the words,so setting the row names to NULL
rownames(d)<-NULL

# Finding the frequent terms with minimum number of occurences as 50
freq_terms <- findFreqTerms(dtm,lowfreq = 50)

# Writing the data frame 'd' into 'dtm.csv' for further use
write.csv(d,"dtm1.csv",row.names = F)


# Finding the associations of these frequent words with the corlimit as 0.25
associations<-c()
for(c in freq_terms){
  associations<-c(associations,findAssocs(dtm,as.character(c),corlimit = 0.5))
}

sink("associations.txt")
associations
sink()

  
# Clustering using k-means

# creating a sparse matrix with the percentage of sparsity as 90%
dtms <- removeSparseTerms(dtm,0.9)
head(inspect(dtms))

# k-means clustering using euclidian as a measurement method
d <- dist(t(dtms), method="euclidian")
# Finding k-means
kfit <- kmeans(d, 4)
sink("cluster_centers.txt")
kfit$centers
sink()

# graph of the clusters
clusplot(as.matrix(d), kfit$cluster, color=T, shade=T, labels=2, lines=0,main = "Clusters")