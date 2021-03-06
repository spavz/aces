library(tm)
library(cluster)
library(factoextra)

setwd("C:/Users/Vishak/Documents/Code/R")

data <- read.csv("Big1.csv",header = T,stringsAsFactors = F)

data <- iconv(data,"latin1", "ASCII", sub="")

# Creating a corpus where each line is taken as a document
corp <- Corpus(VectorSource(data))

corp<- tm_map(corp,removePunctuation)

corp<- tm_map(corp,removeNumbers)

corp <- tm_map(corp,tolower)
for(j in seq(corpus))
{
  corpus[[j]] <- gsub("/", " ", corpus[[j]])
  corpus[[j]] <- gsub("@", " ", corpus[[j]])
  corpus[[j]] <- gsub("\\|", " ", corpus[[j]])
  corpus[[j]] <- gsub("http+", "", corpus[[j]],ignore.case = T, perl = T)
  
}
st <- c("rt",stopwords("english"))

corp <- tm_map(corp,removeWords,st)

corp <- tm_map(corp,stemDocument)

corp<- tm_map(corp,stripWhitespace)

corp <- tm_map(corp,PlainTextDocument)

dtm <- DocumentTermMatrix(corp)

rownames(dtm) <- c(1:nrow(dtm))

m <- as.matrix(dtm)

# Sorting the matrix in Descending order
v <- sort(colSums(m),decreasing=TRUE)

# Converting 'v' into a data frame and storing it in the variable 'd'
d <- data.frame(word = names(v),freq=v)

#using this for plotting
da<-d

#head(da,10)
rownames(d)<-NULL

# Finding the frequent terms with minimum number of occurences as 50
freq_terms <- findFreqTerms(dtm,lowfreq = 50)



# creating a sparse matrix with the percentage of sparsity as 90%
dtms <- removeSparseTerms(dtm,0.9)

# k-means clustering using euclidian as a measurement method
d <- dist(t(dtms), method="euclidian")
# Finding k-means
kfit <- kmeans(d, 4)

pam.res <- pam(da, 4)
# Visualize
fviz_cluster(pam.res)