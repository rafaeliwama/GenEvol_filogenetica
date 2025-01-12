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


**1º passo:** obtendo um alinhamento em formato NEXUS
Lembre que até o momento, nós apenas utilizamos alinhamentos no formato Hennig86 (para o _TNT_) e o formato fasta para o _IQTREE_. Desta forma, nosso primeiro passo é converter um dos alinhamentos para o formato NEXUS. Nós utilizaremos o alinhamento em formato fasta para isso.

Utilize o script ```fasta2nexus.py``` para converter o alinhamento:

```
python3 fasta2nexus.py helobdella_GenEvol_dataset_aligned.fasta

```

Este comando deve criar o arquivo ```helobdella_GenEvol_dataset_aligned.nex```. Este será o arquivo de input para o MrBayes. Contudo, apenas o bloco do alinhamento está contido neste arquivo. 


**2º passo:** Criando o bloco MrBayes no arquivo NEXUS

Diferente do que nós fizemos no _TNT_ e no _IQTREE_, todos os comandos utilizados pelo MrBayes serão especificados em um bloco específico do arquivo NEXUS. Nós chamaremos este bloco de _MrBayes block_. Para isso, siga as instruções à seguir:

1. Abra o arquivo ```helobdella_GenEvol_dataset_aligned.nex``` no seu editor de texto.
2. Ao final do arquivo, após o comando ```END;```, digite: ```begin MRBAYES``` em uma nova linha. Este comando inicia um _MrBayes block_
3. Em uma nova linha, digite o comando ```log start filename=helobdella_COI_log.txt;```. Este comando faz com que o _MrBayes_ escreva um arquivo log, que é importante para consulta após o término da análise.

Perceba uma característica importante em um arquivo NEXUS. Comandos terminam em ```;```!!!

**3º passo:** Particionando a matriz.

Assim como no _IQTREE_, é possível selecionar modelos diferentes para blocos diferentes. Nós particionaremos a matriz da mesma forma que nós particionamos os dados no _IQTREE_, ou seja, por posição do nucleotídio em um códon.

1. Em uma nova linha do arquivo NEXUS, digite:
   
```
charset coi1 = 1-674\3;
charset coi2 = 2-674\3;
charset coi3 = 3-674\3;
```
2. Após indicar para _MrBayes_ quais são as particições, nós precisamos carregar estas partições na memória do programa. Para copie os comandos no arquivo NEXUS:
   
```
partition bestScheme = 3: coi1, coi2, coi3;
set partition = bestScheme;
```
Estes comandos nomeiam um conjunto de partições (bestScheme) formado por três partições como 'coi1', 'coi2' e 'coi3'.


**4º passo:**
Diferente do _IQTREE_, o MrBayes não seleciona o melhor modelo para as partições definidas. Ou seja, é preciso fazer esta seleção prévia em um outro programa. Para nossa sorte, o _IQTREE_ realiza esta seleção e nós podemos utilizar o mesmo esquema de partições.

O arquivo terminado em ```.best_scheme.nexus``` contem a seleção do melhor modelo para cada partição. as linhas após ```charpartition mymodels =``` descrevem os modelos.

Contudo, o _MrBayes_ não é possível indicar os modelos de substituição para cada partição pelo seu nome ou sigla. É preciso indicar cada parametro do modelo separadamente.

Dois comandos são utilizados para indicar os parâmetros do modelo de substitição: ```lset``` e ```prset```. Enquanto o primeiro é utilizado para descrever as taxas de substituição do modelo de substituição, o segundo é utilizado para descrever os priors, inclusive os priors do modelo de substituição.

Vamos começar pela análise dos modelos selecionados. Você pode achar informações sobre estes modelos pesquisado no Google. Há vários websites que podem te dar as informações necessárias sobre cada parâmetro. Eu gosto bastante do manual do IQTREE: http://www.iqtree.org/doc/Substitution-Models

**Partição coi1:** O modelo selecionado foi o GTR+F+I+G4. Este modelo 





