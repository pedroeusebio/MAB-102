getAllNotNull <- function(v) {
  return (!is.na(v))
}

getCorrelation <- function(imdb_score, data, dataNotNull) {
  name <- names(data)
  allCor <- c()
  collName <- c()
  for(row in 1:length(data)){
    if(is.numeric(data[[row]][dataNotNull[[row]]][1]) & name[row] != 'imdb_score') {
      collName <- c(collName, name[row])
      allCor <- c(allCor, cor(imdb_score[dataNotNull[[row]]], data[[row]][dataNotNull[[row]]], use = "everything", method = "pearson"))
    }
  }
  return( data.frame( "name" = collName, "correlation" = allCor))
}

# getting data
data <- read.csv("movie_metadata.csv", header = TRUE, sep = ",")
# getting all not null data)
dataNotNull <- Map(getAllNotNull, data)
# returning all correletion from all numeric columns
result <- getCorrelation(data$imdb_score, data, dataNotNull)

# get higher value
sortedCor <- sort(result$correlation, index.return = TRUE, decreasing = TRUE)
sortedName <- result$name[sortedCor$ix]

 cat(" The higher correlation is ", sortedCor$x[1], ", the column is ", toString(sortedName[[1]]))

