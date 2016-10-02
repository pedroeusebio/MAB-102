findPhi <- function(lines, columns) {
return ((lines - 1) * (columns - 1))
}



sampleA <- read.csv("amostra_A_click.csv", header = TRUE, sep = ";")
sampleB <- read.csv("amostra_B_click.csv", header = TRUE, sep = ";")

sampleAG1 <- sampleA$click_on[sampleA$click_on == "yes"];
sampleAG2 <- sampleA$click_on[sampleA$click_on == "no"];

sampleBG1 <- sampleB$click_on[sampleB$click_on == "yes"];
sampleBG2 <- sampleB$click_on[sampleB$click_on == "no"];

#Tabela Observada
X <- length(sampleAG1);
W <- length(sampleAG2);
Y <- length(sampleBG1);
Z <- length(sampleBG2);
G1 <- sum(X, Y);
G2 <- sum(W, Z);
CA <- sum(X, W);
CB <- sum(Y, Z);
T <- sum(X, W, Y, Z);

#Tabela Esperada

X_ <- (G1 * CA) / T;
W_ <- (G2 * CA) / T;
Y_ <- (G1 * CB) / T;
Z_ <- (G2 * CB) / T;

#Teste Qui-Quadrado
phi <- findPhi(2, 2);
alpha <- 0.05

#H0: amostras da mesma distribuicao
#H1: amostras de distribuicao mesmo


Print(X);
print(W);
print(Y);
print(Z);
