customer_key <- "XFqbN7chVAA8nur8afEr0aTlc"
customer_secret <- "VdKllwLXjNx9dvZBKogsSXFSWbFUwDEfnM6QqfahUu8wnm8naw"
access_token <- "2204794716-HIk9Z249w2kAZjvaEcW7RfnxUJtqs9knya7J8Uu"
access_secret <- "d5bNbgve8rQfx0LhOftlFpVihEez4ixnUvSoGidHlTMEO"
setup_twitter_oauth(customer_key,customer_secret,access_token,access_secret)


tweets <- searchTwitter('#csgo', n=5)

df <- twListToDF(tweets)


https://cran.r-project.org/doc/manuals/r-devel/R-data.html


sink("1234.txt") # redirect console output to a file
sink() # restore output to the screen

pdf("mygraph.pdf") # subsequent graphical output will go to a PDF
png("mygraph.png") # subsequent graphical output will go to a PNG
jpeg("mygraph.jpeg") # subsequent graphical output will go to a JPEG
bmp("mygraph.bmp") # subsequent graphical output will go to a BMP
postscript("mygraph.ps") # subsequent graphical output will go to a PostScript file
dev.off() # back to the screen

setwd("c:/myfiles") # use / or \\ to separate directories under Windows (\\ becomes \ once processed through the escape character mechanism)
dir() # list the contents of the current directory

source("myfile.R") # load and execute a script of R commands



library(tm)


docs <- Corpus(DirSource(cname))

setwd("c:/myfiles")

sink("1234.txt")
tweets
sink()

cname <- file.path("C:/Users/Vishak/Documents/Code/R", "1234.txt")   
