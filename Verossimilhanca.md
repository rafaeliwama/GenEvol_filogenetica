# Análise filogenética por métodos de máxima verossimilhança
### Intrutor: Rafael E. Iwama
### Monitora: Isabelle Cristine Santos da Silva



## Introdução aos métodos de máxima verossimilhança

O segundo critério de otimalidade que nós vamos estudar hoje é o critério da máxima verossimilhança. Este critério é baseado na verossimilhança de Fisher e é uma medida do quanto um modelo explica os o que se é observado. A máxima verossimilhança então (na filogenética), é o critério que visa a seleção de árvore que possuí o maior valor em um função de verossimilhança. A figura abaixo mostra equação utilizada para o cálculo da verossimilhança e exemplifica a seleção da árvore como o maior valor de verossimilhança em um função:

![image](https://github.com/user-attachments/assets/a92e96e8-c5f2-4ad6-9db8-83e7943ca926)


A principal diferença entre o critéro de máxima parsimônia e o critério da máxima verossimilhança é a necessidade de um modelo evolutivo. Técnicamente, o modelo evolutivo é composto por três componentes: (1) a topologia, (2) comprimento dos ramos e (3) matriz de substituição de caracteres (nucleotídeos ou aminoácidos). Contudo, em muitos casos, nós utilizamos coloquialmente a palavra modelo para se referir à matriz de substituição.

Para realizarmos reconstruções utilizando o critério de maxima verossimilhança, nós utilizaremos o _IQTREE_. Diferente do _TNT_, o _IQTREE_ é um programa com um manual exemplar e que contém diversos tutoriais explicando cada uma de suas funcionalidades. O manual do programa pode ser acessado no site: http://www.iqtree.org/doc/

O conteúdo para esta parte do tutorial está disponível na pasta Part2IQTREE do github.

```
para baixar a pasta
```

Mude o diretório de trabalho para a pasta 'Part2IQTREE':
```
cd Part2IQTREE
```

Esta pasta contém todos os arquivos necessário para rodar o IQTREE:

```iqtree2``` - arquivo executável do iqtree

```helobdella_GenEvol_dataset_aligned.fasta``` - arquivo em formato fasta contendo o alinhamento do dataset de _Helobdella_.

```AlignmentLengthChecker.py``` - script em python para verificar o tamanho do alinhamento.


## Definindo partições

Como mencionado anteriormente, métodos de máxima verossimilhança são dependentes de uma matriz de substituição que descreve as probabilidades de determinados tipos de eventos de substituição de nucleotídeos. No exemplo da aula teórica, nós utilizamos um único modelo para todos os sítios da nossa matriz. Contudo, diferentes sítios podem evoluir de maneiras diferentes. Por exemplo, genes diferentes podem estar sob diferentes pressões evolutivas e apresentar taxas diferenciada. Outro exemplo é a posição do nucleotídeo no códon de genes codificates. Como você pode observar na figura abaixo, mudanças no terceiro códon são sinônimas e, portanto, apresentam maiores taxas de substituição.

![f5de6355003ee322782b26404ef0733a1d1a61b0](https://github.com/user-attachments/assets/7852f52c-417e-4fb2-ab62-182036d8c70b)

Nós podemos incorporar estas diferenças, adotando modelos diferentes para diferentes sítios. Para indicar que os programas podem selecionar diferentes modelos, nós precisamos separar a nossa matriz em diferentes partições. Ou seja, blocos de dados em que um modelo será aplicado.

Para indicar as partições da matriz, nós criaremos um aquivo texto contendo o nome da partição, o tipo de dado, as coordenadas da partição e os blocos de dados dentro de cada partição que serão considerados. 


**1º Passo: Definindo o comprimento do alinhamento**
Antes de criarmos o arquivo com a descrição das partições, nós precisamos ter conhecimento do comprimento da nossa matrix, para que nós possamos inserir as coordenadas corretas do das nossas partições. Execute o script ```AlignmentLengthChecker.py``` como na linha abaixo:

```
python3 AlignmentLengthChecker.py helobdella_GenEvol_dataset_aligned.fasta

```

O script deve printar o comprimento do alinhamento.

**2º Passo: Criar arquivo de particições**
Em seguida, nós podemos criar um arquivo de texto, utilizando um o nano. Digite ```Nano``` e digite o texto abaixo, substituindo <comprimento> pelo comprimento do alinhamento:


```
DNA, COI1 = 1-<comprimento>\3
DNA, COI2 = 2-<comprimento>\3
DNA, COI3 = 3-<comprimento>\3

```

Perceba que nós particionamos a matriz em três blocos de dados. O primeiro, 1 em cada 3 nucleotídeos começando pelo primeiro sítio do alinhamento. O segundo, 1 a cada 3 començando pelo segundo sítio do alinhamento e o terceiro, 1 a cada 3 começando pelo terceiro sítio. Desta forma, nós conseguimos atribuir taxas diferentes para cada sítio de um códon no gene COI que é codificante.


## Reconstrução filogenética por máxima verossimilhança


**1º Passo: Reconstrução filogenética**
No próximo passo nós utilizaremos o _IQTREE_ para realizar 3 etapas:

1. Seleção de modelo
2. Inferência filogenética
3. _Bootrapping_

O _IQTREE_ é bastante eficiente e faz estas três etapas com apenas uma linha de comando. Digite o seguinte comando e analise as ações que o software realiza:

```
./iqtree2 -s helobdella_COI_GenEvol_aligned.fasta -T 4 -p helobdella_partitions.txt -m TESTMERGE -mset mrbayes -ninit 1000 -B 1000 -wbt
```



Responsa as questões abaixo:
1. Qual o modelo selecionado pelo _IQTREE_?
2. Qual a diferença dos modelos selecionados? Utilize o manual do _IQTREE_ para se informar sobre os modelos de substituição! (http://www.iqtree.org/doc/Substitution-Models#dna-models)
4. Qual o valor de Log Likelihood da árvore selecionada?
5. Como foi a mudança do Log Likelihood durante a busca de árvores?
6. Como o tempo e análise difere da árvore de parsimônia reconstruída com o _TNT_?

**2º Passo: Visualização**

Visualize o arquivo com a terminação ```.contree``` no iTOL. Diferente do _TNT_, esta árvore pode ser visualizada diretamente.

Responda as perguntas abaixo:
1. Você oberva alguma politomia? Como o número de politomias difere do número de politomias da árvore de parsimônia?
2. Como os comprimentos de ramo diferem dos comprimentos de ramo da árvore de parsimônia? Por que você obeserva esta diferença?
