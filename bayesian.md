# Análise filogenética por métodos de máxima verossimilhança
### Intrutor: Rafael E. Iwama
### Monitora: Isabelle Cristine Santos da Silva



## Introdução aos métodos de reconstrução filogenética bayesiana

Assim como métodos de verossimilhança, métodos de reconstrução filogenética baseados em estatistica bayesiana também incorporam modelos durante o processos de inferência. Contudo métodos bayesianos têm uma diferença fundamental em relação a métodos de verossimilhança. Enquanto o primeiro calcula a probabilidade de se obter os dados (alinhamento), dado um certo modelo (topologia, comprimento dos ramos, e matriz de substituição) [P(D|T)], o segundo tem o objetivo de calcular a probabilidade de um modelo evolutivo dado que um certo alinhamento [P(T|D). Esta abordagem muda a cenário de reconstrução filogenética por métodos baseados em modelos, pois calcula diretamente a probabilidade de aspecpectos relativos a topologia e comprimento dos ramos, ao invés de inferir a probabilidade do matriz.

Com o próprio nome nos diz, métodos de reconstrução filogenética bayesiana são baseados no teorema de Bayes que pode ser representado pela equação abaixo:

![image](https://github.com/user-attachments/assets/20d7dbe5-4b13-4f86-baa3-ae0c1aba8f8f)

Onde:
1. P(T|D): a probabilidade posterior
2. P(T): é a probabilidade à priori que é estabecida baseada nas expectivas que a análise possui
3. P(D|T): é o valor de verossimilhança que nós já aprendemos a calcular na aula teórica
4. P(D): é a probabilidade marginal.

A P(D) pode ser definida como o cálculo da probabilidade de se obter os dados, segundo qualquer modelo evolutivo. O cálculo da P(D) é extremamente dificil de ser computado empiricamente, mas nós podemos utilizar o algorítmo chamado Markov Chain Monte Carlo (MCMC) para amostrar um grupo de  distribuições de probabilidade.

Vários softwares utilizam o MCMC para a rescontrução filogenética. Hoje nós utilizaremos o _MrBayes_.


## O formato NEXUS de árquivos

Um dos formatos de arquivos mais populares na bioinformática é o formato NEXUS. Este tipo de arquivo pode conter vários tipos de informação, como por exemplo: sequências, alinhamentos, árvores, códigos genéticos, distâncias filogenéticas, modelos, e até comandos para determinados programas. Um característica particular do formato nexus é o seu potencial para armazenar diversos tipos de informação em um único arquivo. Isso só é possível graças a organização em blocos. Cada arquivo NEXUS pode conter múltiplo blocos que podem armazenar sets de informações diferentes, do mesmo tipo ou de tipos diferentes.

Este é o caso do arquivo de input para o _MrBayes_ que nós utilizaremos.


### 1º passo: obtendo um alinhamento em formato NEXUS
Lembre que até o momento, nós apenas utilizamos alinhamentos no formato Hennig86 (para o _TNT_) e o formato fasta para o _IQTREE_. Desta forma, nosso primeiro passo é converter um dos alinhamentos para o formato NEXUS. Nós utilizaremos o alinhamento em formato fasta para isso.


