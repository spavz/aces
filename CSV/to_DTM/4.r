
library(tm)
library(cluster)

# Reaading the data from the text file
data <- read.csv("data4.csv",header = T,stringsAsFactors = F)

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
write.csv(d,"dtm4.csv",row.names = F)
