findZ <- function(mp, ms, sdp, n) {
  return (
    (ms - mp) / (sdp / sqrt(n))
  )
}

findP <- function(z) {
  if(z > 0) return(1 - pnorm(z)) else return( pnorm(z))
}

testH <- function(p, alpha) {
#testando Hipotese nula
  if(p < alpha) {
#Hipotese Nula falsa
    return(FALSE)
  } else {
#Hipotese Nula Verdadeira
    return(TRUE)
  }
}

sample <- read.csv("amostra_tempo.csv", header = TRUE, sep = ";")
population <- read.csv("populacao_tempo.csv", header = TRUE, sep = ";")

# media e desvio padrao populacional
mp <- mean(population$tempo)
sdp <- sd(population$tempo)
N <- length(population$tempo)

# media e desvio padrao amostral
ms <- mean(sample$tempo)
sds <- sd(sample$tempo)
n <- length(sample$tempo)

#teste de Hipotese

alpha <- 0.05

z <- findZ(mp, ms, sdp, n)
print(z)
p <- pnorm(z)
print(p)
#teste hipotese nula

print(testH(p, alpha))


sampleDensities <- dnorm(sort(sample$tempo), mean=ms, sd=sds)
populationDensities <- dnorm(sort(population$tempo), mean=mp, sd=sdp)

plot(sort(population$tempo), populationDensities, col='gold', xlab="", ylab="Density", type="l",lwd=2, cex=2, main="PDF of samples Normal")
lines(sort(sample$tempo), sampleDensities, col='darkgreen')
legend("topright", title="Distributions", c('Population', 'Sample'), col=c('gold', 'darkgreen'), lty= c(1,1))

