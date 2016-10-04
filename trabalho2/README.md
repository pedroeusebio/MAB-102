# MAB-102

# Trabalho 2

## Nova Feature para um Site

### Enunciado

Um portal de notícias implementou um play automático de vídeos em suas páginas, visando manter seus usuários por mais tempo no site.

Analise os dados históricos contendo os acessos do último mês, e mostre se houve um aumento significativo de tempo de navegação após a implementação da feature.

Arquivos:
* Populacao_tempo.csv
* Amostra_tempo.csv

Sabendo que o custo por visualização desse play é de 0.005 centavos, e que cada minuto adicional de navegação gera em média 5 centavos de lucro, defina se essa nova feature deve ser mantida ou não.

### Solução

Para demonstrar que o play automático de vídeos realmente aumentou os usuários por mais tempo no site, é necessário comparar os dados posteriores a implementação([Amostra_tempo.csv](https://github.com/pedroeusebio/MAB-102/blob/master/trabalho2/exercicio1/amostra_tempo.csv)) com os dados da população ([Populacao_tempo.csv](https://github.com/pedroeusebio/MAB-102/blob/master/trabalho2/exercicio1/populacao_tempo.csv)) e verificar se as amostras pertencem ou não a mesma distrubuição da população. Dessa maneira, caso sejam da mesma distribuição, prova-se que não diferença entre os dados, logo, a *feature* não fez diferença no tempo de acesso dos usuários. Caso ao contrário, prova-se que as amostras não se encaixam na mesma distribuição, podendo-se constatar que a *feature* aumentou o tempo de visualização dos usuários no site.

Para isso, foi feito o teste de hipótese, sendo a hipótese nula as amostras pertencem a mesma distribuição e a hipótese H1 as amostras não pertencem a mesma distribuição.


