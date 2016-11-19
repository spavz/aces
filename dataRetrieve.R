setwd("E:/")
df <- head(getTrends(2367105),5)
print(head(df))
p <- df[1:5,c('name')]
i = 0
for(v in p){
  i = i+1
  #print(v)
  searchString <- v
  tweets <- searchTwitter(searchString,n=1000,lang = 'en')
  tweets <- twListToDF(tweets)
  filename <- paste("data",i,".csv",sep="")
  write.csv(tweets$text,toString(filename),row.names = F)
}

