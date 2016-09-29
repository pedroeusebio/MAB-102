sampleA <- read.csv("amostra_A_click.csv", header = TRUE, sep = ";")
sampleB <- read.csv("amostra_B_click.csv", header = TRUE, sep = ";")

sampleAG1 <- sampleA$click_on[sampleA$click_on == "yes"];
sampleAG2 <- sampleA$click_on[sampleA$click_on == "no"];

sampleBG1 <- sampleB$click_on[sampleB$click_on == "yes"];
sampleBG2 <- sampleB$click_on[sampleB$click_on == "no"];

X <- length(sampleAG1);
W <- length(sampleAG2);
Y <- length(sampleBG1);
Z <- length(sampleBG2);
G1 <- sum(X, Y);
G2 <- sum(W, Z);
CA <- sum(X, W);
CB <- sum(Y, Z);
T <- sum(X, W, Y, Z);

print(X);
print(W);
print(Y);
print(Z);
