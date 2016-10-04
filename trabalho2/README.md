# MAB-102

# Trabalho 2

## Nova Feature para um Site

### Enunciado

Um portal de notícias implementou um play automático de vídeos em suas páginas, visando manter seus usuários por mais tempo no site.

Analise os dados históricos contendo os acessos do último mês, e mostre se houve um aumento significativo de tempo de navegação após a implementação da feature.

Arquivos:

* Populacao\_tempo.csv
* Amostra\_tempo.csv

Sabendo que o custo por visualização desse play é de 0.005 centavos, e que cada minuto adicional de navegação gera em média 5 centavos de lucro, defina se essa nova feature deve ser mantida ou não.

### Solução

Para demonstrar que o play automático de vídeos realmente aumentou os usuários por mais tempo no site, é necessário comparar os dados posteriores a implementação\([Amostra\_tempo.csv](https://github.com/pedroeusebio/MAB-102/blob/master/trabalho2/exercicio1/amostra_tempo.csv)\) com os dados da população \([Populacao\_tempo.csv](https://github.com/pedroeusebio/MAB-102/blob/master/trabalho2/exercicio1/populacao_tempo.csv)\) e verificar se as amostras pertencem ou não a mesma distrubuição da população. Dessa maneira, caso sejam da mesma distribuição, prova-se que não diferença entre os dados, logo, a _feature_ não fez diferença no tempo de acesso dos usuários. Caso ao contrário, prova-se que as amostras não se encaixam na mesma distribuição, podendo-se constatar que a _feature_ aumentou o tempo de visualização dos usuários no site.

Para isso, foi feito o teste de hipótese, sendo a hipótese nula as amostras pertencem a mesma distribuição e a hipótese H1 as amostras não pertencem a mesma distribuição.

### Método de Solução

para obter os dados de cada .csv foi realizado o seguinte código:

```{r}
sample <- read.csv("amostra_tempo.csv", header = TRUE, sep = ";")
population <- read.csv("populacao_tempo.csv", header = TRUE, sep = ";")
```

Para o cálculo das médias, foi utilizado as funções da própria linguagem. A função `mean()` faz o cálculo da média de um vetor, já a função `sd()` faz o cálculo do desvio padrão de um vetor e a função `length()` retorna o tamanho do vetor passado como parametros, como pode ser visto abaixo :

```r
# media e desvio padrao populacional
mp <- mean(population$tempo)
sdp <- sd(population$tempo)
N <- length(population$tempo)
```
Esses mesmos cálculos foram realizados para as amostras, afim de obter o cálculo da estatística Z. Para isso, foi utilizado a função `findZ()` que recebe 4 parametros : 
* mp: média populacional
* ms: média amostral
* sdp: desvio padrão populacional
* n: tamanho da amostra

```{r}
findZ <- function(mp, ms, sdp, n) {
  return (
    (ms - mp) / (sdp * sqrt(n))
  )
}
``` 
Após o calculo da estatistica Z, o resultado foi utilizado para calcular o p-valor que será comparado para verificar a hipotese nula.

Para o cálculo do p-valor, pode-se utilizar a função `pnorm()` que retornará o p-valor de acordo com Z.

o Z encontrado foi de $$ Z = 23.35878 $$. Para esse valor, o p-valor foi de $$ 1.0 $$, sendo assim se compararmos com o nivel de significância ($$0.05$$), perceberemos que a hipótese nula é falsa, ou seja, a distribuição das amostras da *feature* não pertencem a mesma distribuição da população e como o p-valor é positivo, deve ser adotado, pois terá um retorno financeiro maior.

**Os arquivos dos dados, assim como o código utilizado para realizar o teste de hipótese, podem ser encontras nesse [link](https://github.com/pedroeusebio/MAB-102/tree/master/trabalho2/exercicio1).**

## Clicks do Site

### Enunciado

* Uma métrica comum em sites de e-commerce é o número de clicks que um usuário efetua durante a navegação. Um grupo de marketing quer fazer uma campanha de um novo produto, entretanto não sabe se apresenta ele apenas na página ou como um pop-up, que toma a conta de toda a tela. Visando responder esse problema, dois grupos foram selecionados. Para o primeiro grupo, foi apresentado apenas a tela com o produto. Para o segundo, foi apresentado a tela com o pop-up.
* Utilize técnicas estatísticas para informar se faz diferença utilizar o pop-up ou não.
    * Arquivos:
        * amostra_A_click.csv
        * amostra_B_click.csv


### Solução

O execício propõe que, dado duas amostras, verifiquemos se ambas são da mesma população. Em outras palavras, se as duas amostras forem da mesma população significa que não existe diferença no número de cliques em relação ao tipo de exibição (com pop-up ou apenas na página). Caso não sejam da mesma população significa que existe uma diferença entre as amostras e uma das duas opções é a ideal para ser utilizada( a que proporcional mais clicks).

Dessa maneira, para solução do exercício, foi utilizado o teste do Qui-Quadrado para duas amostras. Tem-se como hipótese nula que as amostras são da mesma população e como hipótese alternativa que as amostras não fazem parte da mesma população.

### Método de Solução

Para a utilização do teste do Qui-Quadrado para duas amostras, foi necessário dividir os dados em dois grupos e duas classes :
* Classes:
    * Classe A : [Amostra A](https://github.com/pedroeusebio/MAB-102/blob/master/trabalho2/exercicio2/amostra_A_click.csv)
    * Classe B : [Amostra B](https://github.com/pedroeusebio/MAB-102/blob/master/trabalho2/exercicio2/amostra_B_click.csv)
* Grupos:
    * Grupo 1 : click_on = "yes"
    * Grupo 2 : click_on = "no"

Em código :

```{r}
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
```

























