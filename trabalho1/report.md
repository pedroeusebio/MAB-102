# Relatório de análise do Dataset de Pokemon

### Ideia: Qual a média de HP de cada tipo de Pokemon ?

### *Dataset*: [https://www.kaggle.com/abcsds/pokemon/downloads/Pokemon.csv](https://www.kaggle.com/abcsds/pokemon/downloads/Pokemon.csv)

## Ferramentas

Foram utilizados para realização da analise do *dataset*, a linguagem de programação [R](https://www.r-project.org/).
Para gerar os gráficos, foi utilizando planilha do Google Drive apenas por praticidade.

## Análise

O objetivo da análise era obter a média, de cata tipo de pokemon. Para isso, fez se necessário obter cada tipo e subtipo de todos os Pokemons. Para tal, utiliza-se a função `getType` abaixo: 

```r
getType <- function(data) {
  vect <- c()
  for(v in data){
    vect <- if(!v %in% vect) c(vect, v) else vect
  }
  return (vect)
}
```
De forma bem simples, a função recebe como dado o vetor de tipos de todos os pokemons e adiciona em outro caso não exista previamente.

Após obter todos os tipos e subtipos dos Pokemon, os dados do *dataset* serão processos na função `getStatsType` abaixo:

```r
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
  return_df <- data.frame(
  		nameVect, meanVect,
  		medianVect, modeVect, maxVect,
		minVect,lengthVect, sizeVect)
  return(return_df)
}
```
A função realiza uma busca por todos os Pokemons que pertencem ao mesmo tipo(e subtipo), agregando todos em um mesmo vetor(linha 14). Depois disso, é feito os calculos de :
* Média
* Mediana
* Moda
* Máximo
* Mínimo
* Número de Pokemons do mesmo tipo
* Soma do Total de Pokemons
Todos esses dados são adicionados nos respectivos vetores e no final são adicionados em um *Data Frame* para serem exportados para um arquivo .csv.

## Gráficos

![](https://i.imgur.com/5FvtIfK.png)

O gráfico acima avalia a média de HP para cada tipo de Pokemon, além de conter a informação da quantidade que cada tipo representa no total de Pokemons no *dataset*.

![](https://i.imgur.com/biRp11w.png)

O segundo gráfico é a representação das médias de HP de cada tipo de Pokemon, porém com valores adicionais de máximo e mínimo de HP.

![](https://i.imgur.com/QnjOTO5.png)

O último gráfico é uma comparação de da quantidade de Pokemons de cada tipo, com a média de HP. É possível perceber que existe uma proporção na distribuição do HP, existe uma parcela grande de pokemon que tem o HP intermediário, e poucos com HP maiores ou menores que a média.
