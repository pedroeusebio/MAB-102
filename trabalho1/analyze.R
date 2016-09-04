library(functional)

getType <- function(data) {
  vect <- c()
  for(v in data){
    vect <- if(!v %in% vect) c(vect, v) else vect
  }
  return (vect)
}

getmode <- function(v) {
  uniqv <-  unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}

getSizeType <- function(types, data) {
  size <- length(data$Name)
  lst <- list()
  for( v in types){
    element <- data$HP[data$Type.1 %in% v]
    vect <- c(mean(element), median(element), getmode(element), max(element), min(element))
    lst[[v]] <- vect
  }
  return(lst)
}

getStatsType <- function (types.1, types.2, data) {
  nameVect <- c()
  meanVect <- c()
  medianVect <- c()
  modeVect <- c()
  maxVect <- c()
  minVect <- c()
  lengthVect <- c()
  sizeVect <- c()
  size <- 0
  for(t1 in types.1) {
    for(t2 in types.2) {
      type <- paste(t1, t2, sep='-')
      element <- data$HP[data$Type.1 %in% t1 & data$Type.2 %in% t2]
      if(!is.nan(mean(element))){
        nameVect <- c(nameVect, type)
        meanVect <-  c(meanVect, mean(element, trim = 0.3))
        medianVect <- c(medianVect, median(element))
        modeVect <- c(modeVect, getmode(element))
        maxVect <- c(maxVect, max(element))
        minVect <- c(minVect, min(element))
        size <- sum(size, length(element))
        lengthVect <- c(lengthVect, size)
        sizeVect <- c(sizeVect, length(element))
      }
    }
  }
  return_df <- data.frame(nameVect, meanVect, medianVect, modeVect, maxVect, minVect, lengthVect, sizeVect)
  return(return_df)
}


data <- read.csv("Pokemon.csv")
types.1 <- getType(data$Type.1)
types.2 <- getType(data$Type.2)
number <- getSizeType(types.1, data)
stats <- getStatsType(types.1, types.2, data)
orderByMean <- order(stats$meanVect)
orderByLength <- order(stats$lengthVect)
write.csv(stats[orderByMean,], "output-mean.csv", row.names = FALSE)
write.csv(stats[orderByLength,], "output-length.csv", row.names = FALSE)
write.csv(stats[order(stats$sizeVect),], "output-size.csv", row.names = FALSE)
