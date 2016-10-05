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

o Z encontrado foi de $$ Z = 23.35878 $$. Para esse valor, o p-valor foi de $$ 1.0 $$, sendo assim se compararmos com o nivel de significância \($$0.05$$\), perceberemos que a hipótese nula é falsa, ou seja, a distribuição das amostras da _feature_ não pertencem a mesma distribuição da população e como o p-valor é positivo, deve ser adotado, pois terá um retorno financeiro maior.

**Os arquivos dos dados, assim como o código utilizado para realizar o teste de hipótese, podem ser encontras nesse ****[link](https://github.com/pedroeusebio/MAB-102/tree/master/trabalho2/exercicio1)****.**

## Clicks do Site

### Enunciado

* Uma métrica comum em sites de e-commerce é o número de clicks que um usuário efetua durante a navegação. Um grupo de marketing quer fazer uma campanha de um novo produto, entretanto não sabe se apresenta ele apenas na página ou como um pop-up, que toma a conta de toda a tela. Visando responder esse problema, dois grupos foram selecionados. Para o primeiro grupo, foi apresentado apenas a tela com o produto. Para o segundo, foi apresentado a tela com o pop-up.
* Utilize técnicas estatísticas para informar se faz diferença utilizar o pop-up ou não.
  * Arquivos:
    * amostra\_A\_click.csv
    * amostra\_B\_click.csv



### Solução

O execício propõe que, dado duas amostras, verifiquemos se ambas são da mesma população. Em outras palavras, se as duas amostras forem da mesma população significa que não existe diferença no número de cliques em relação ao tipo de exibição \(com pop-up ou apenas na página\). Caso não sejam da mesma população significa que existe uma diferença entre as amostras e uma das duas opções é a ideal para ser utilizada\( a que proporcional mais clicks\).

Dessa maneira, para solução do exercício, foi utilizado o teste do Qui-Quadrado para duas amostras. Tem-se como hipótese nula que as amostras são da mesma população e como hipótese alternativa que as amostras não fazem parte da mesma população.

### Método de Solução

Para a utilização do teste do Qui-Quadrado para duas amostras, foi necessário dividir os dados em dois grupos e duas classes :

* Classes:

  * Classe A : [Amostra A](https://github.com/pedroeusebio/MAB-102/blob/master/trabalho2/exercicio2/amostra_A_click.csv)
  * Classe B : [Amostra B](https://github.com/pedroeusebio/MAB-102/blob/master/trabalho2/exercicio2/amostra_B_click.csv)

* Grupos:

  * Grupo 1 : click\_on = "yes"
  * Grupo 2 : click\_on = "no"


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
Com o código acima podemos gerar a tabela abaixo :

|  -      | Classe A | Class B | Total |
|:--------|:--------:|:-------:|:-----:|
| Grupo 1 | X        | Y       | G1    |
| Grupo2  | W        | Z       | G2    |
| Total   | CA       | CB      | T     |


Para gerar a tabela esperada foi utilizado o código abaixo:

```{r}
#Tabela Esperada

X_ <- (G1 * CA) / T;
W_ <- (G2 * CA) / T;
Y_ <- (G1 * CB) / T;
Z_ <- (G2 * CB) / T;
```

Com o código acima, podemos obter a tabela abaixo de valores esperados :

|-        | Classe A | Classe B|
|---------|:--------:|:-------:|
| Grupo 1 | X_       | Y_      |
| Grupo 2 | W_       | Z_      |

Para obter o grau de liberdade, a função `findPhi()` foi utilizada. Passa-se como parametros o número de colunas e linhas que a tabela Observada possui.

```{r}
findPhi <- function(lines, columns) {
  return ((lines - 1) * (columns - 1))
}

```

Tendo esses dados, pode calcular o valor de X<sup>2</sup><sub>n</sub>. Para esse cálculo, foi criado a função abaixo :

```{r}
findXn <- function (o, e) {
  return (
    (o - e) ** 2 / e
  )
}

```
O valor de 'o' é um valor da tabela observada e 'e' é um valor da tabela esperada. Para calcular cada valor, cria-se 2 vetor, um com todos os valores da tabela observada, e outro com todos os valores da tabela observada. Aplica-se um Map em ambos vetores e for fim faz-se um `Reduce` aplicando a soma no vetor retornado pelo `Map()`, como pode ser visto no código abaixo:

```{r}
observedVect <- c(X, W, Y, Z)
expectedVect <- c(X_, W_, Y_, Z_)

Xn <-  Reduce(sum, Map(findXn, observedVect, expectedVect))

```

Com o valor de X<sup>2</sup><sub>n</sub> e do grau de liberdade, calcula-se o p-valor para ser comparado com o nivel de significância :

```{r}
pValue <- 1- pchisq(Xn, phi)
```
Caso seja p-valor maior que alpha ($$\alpha$$) a hipótese nula não deve ser rejeitada, caso ao contrário, a hipótese nula deve ser rejeitada e a hipótese alternativa deve ser levada em consideração. 

De acordo com os cálculos acima, o p-valor deu aproximadamente 13.2939, o grau de liberdade ($$\phi$$) igual a 2, gerando assim o p-valor de 0.0002662709. Como o p-valor é menor que o nível de significância ($$\alpha = 0.05$$), então a hipótese nula foi descartada.

O gráfico abaixo, mostra a diferença entre os clicks produzido pela tela sem pop-up e com pop-up. Dessa maneira, é possível perceber que a amostra A proporcionou o maior numero de clicks.

![](/assets/Plot 6.png)





## Produtor de Cinema

### Enunciado

* Um produtor acredita que deve-se construir um poster para um filme utilizando a maior quantidade de atores possíveis. O fato se deve a uma correlação existente entre a nota no IMDB (imdb_score) e o número de faces existentes nos posters (facenumber_in_poster).

* Verifique a existência dessa correlação e tente ajudar o produtor a conseguir o melhor imdb_score possível.

* Arquivo:
    * movie_metadata.csv

### Solução

O exercício tinha como princípio a utilização da correlação de Pearson para encontrar qual dos atributos dos filmes tem mais relação com a nota no IMDB. Para isso foi utilizada a função nativa `cor()` para calcular a correlação dos dados.

### Método de Solução

Inicialmente, foi necessário realizar um tratamento dos dados, removendo todos as linhas da tabela do .csv que não possuiam algum dado. Para isso, a função `is.na()` foi utilizada para verificar os valores dos dados.

```{r}
getAllNotNull <- function(v) {
  return (!is.na(v))
}

```
A função acima, foi utilizada para tratar os dados. A função `is.na()` retorna `TRUE` para caso o valor seja esteja sendo avaliado seja um `NaN`. Dessa maneira, a função `getAllNotNull` recebe um data.frame dos dados do .csv e retorna um data.frame da mesma dimensão de parametro contendo vetores com valores booleanos, que representam se aquele valor é `NaN` ou não.

Tendo esses dados tratados, a função `getCorrelation()` é utilizada para criar um data.frame contendo duas colunas : 
* Name : que contem o nome do atributo dos filmes
* Correlation :  que contem os valores de correlação de cada atributo.

```{r}
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
```
De maneira bem simples, a função faz uma iteração para cada atributo de filmes, filtrando todos os dados que são numéricos e que não é o imdb_score. Para cada atributo, calcula-se a correlação de Pearson e adiciona esse valor em um vetor `allCor`, além de adicionar em outro vetor `collName` o nome do atributo que foi calculado. 

Após essa etapa, ordena-se os resultados da correlação em ordem decrescente e escolhe o primeiro para retorna como maior correlação entre imbdb_score.





![](/assets/Plot 7.png)

















