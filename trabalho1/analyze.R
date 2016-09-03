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

comparator <- function( a, b) {
  vect <- c()
  for(i in 1:length(a)){
    element <- a[i] && b[i]
    vect <- c(vect, element)
  }
  return(vect)
}

getStatsType <- function (types.1, types.2, data) {
  size <- length(data$Name)
  lst <- list()
  for(t1 in types.1) {
    for(t2 in types.2) {
      type <- paste(t1, t2, sep='-')
      element.1 <- data$Type.1 %in% t1 
      element.2 <- data$Type.2 %in% t2
      element <- comparator(element.1, element.2)
      element <- data$HP[element]
      if(!is.nan(mean(element))){
        vect <- c(mean(element, trim = 0.3), median(element), getmode(element), max(element), min(element), length(element)) 
        print(vect)
        lst[[type]] <- vect
      }
    }
  }
  return(lst)
}


data <- read.csv("Pokemon.csv")
types.1 <- getType(data$Type.1)
types.2 <- getType(data$Type.2)
number <- getSizeType(types.1, data)
stats <- getStatsType(types.1, types.2, data)
write.csv(stats, "output.csv", row.names = FALSE)
