library(wordcloud2) 

xlsx_exa <- read_excel("words.xlsx",sheet=1)#,range ="" "d19:d44")
d <- data.frame(
  word = xlsx_exa$Name,
  freq = xlsx_exa$Freq
)

# Change the shape:
wordcloud2(d, size = 0.4, shape = 'star')



library("tm")
library("SnowballC")
library("wordcloud")
library(wordcloud2)
library("RColorBrewer")
filePath <- "http://www.sthda.com/sthda/RDoc/example-files/martin-luther-king-i-have-a-dream-speech.txt"
text <- readLines("text.rtf")
docs <- Corpus(VectorSource(text))
inspect(docs)
docs <- tm_map(docs, content_transformer(tolower))
docs <- tm_map(docs, removeNumbers)
docs <- tm_map(docs, removeWords, stopwords("english"))
docs <- tm_map(docs, removeWords, c("ffcr","sich","die","mehr","das","grfcnen", "und","der","von","wird","ist","grfcnen","werden","als","eine","einer","man")) 
docs <- tm_map(docs, removePunctuation)
docs <- tm_map(docs, stripWhitespace)

dtm <- TermDocumentMatrix(docs)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
head(d, 10)
set.seed(1234)

letterCloud( d, word = "R", color='random-light' , backgroundColor="black")
wordcloud2(d, size = .5, shape = 'pentagon')
wordcloud(words = d$word, freq = d$freq, min.freq = 1,
          max.words=200, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))
