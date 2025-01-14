# Análise filogenética por métodos de máxima parcimônia
### Intrutor: Rafael E. Iwama
### Monitora: Isabelle Cristine Santos da Silva

### Uma breve introdução aos métodos de máxima parsimônia

Os métodos de parcimônia utilizam como critério de otimalidade, o princípio da navalha de Ockham. Este princípio considera que a melhor explicação para um fenômeno é a mais simples, ou seja, aquela que requer um menor número de pressupostos. Willi Hennig (1913-1976) formalizou o método baseado em parcimônia para reconstruções filogenéticas através da utilização de uma matriz numérica, já utilizada pelos feneticistas. Este método assume que mudanças são raras, e portanto que a hipótese mais provavel é aquela com o menor número de mudanças.


Computacionalmente, vários softwares estão disponíveis para este tipo de análise. Estes softwares variam, principalmente, no processo de *tree search*. O *tree search*, basicamente é a busca heurística pela melhor árvore, de acordo com um critério. Neste caso, nosso critério de otimalidade é a máxima parsimônia. Esta busca heurística é utilizada porque computacionalmente, é impossível de se avaliar todas as árvores possíveis para um determinado *dataset*.

A figura abaixo representa o número de árvores possíveis para um dataset *n* terminais. Para um dataset de apenas 6 terminais, há quase 92 mil árvores possíveis. 
![image](https://github.com/user-attachments/assets/10fc6507-9bd6-4e1d-ae06-5011a81b816d)


Existem vários softwares para reconstrução filogenética utilizando o critério de parcimônia. O TNT (_Tree Analysis using New Technology_) é um software bastante robusto para este tipo de análise, pois implementa algorítmos poderos de busca heurística. Durante este tutorial, nós utilizaremos o TNT para a reconstrução filogenética do dataset de _Helobdella_.

Antes de tudo, mude o diretório de trabalho atual para `Parcimony`:

```
cd Parcimony
```

Abra baixe e abra o arquivo 'helobdella_COI_GenEvol.fasta' em editor de text. Você pode utilizar o notepad, por exemplo. Contudo, outros editores de texto estão disponíveis.

> [!IMPORTANT]
> Esta etapa deve ser feita pela interface gráfica!

Note que o arquivo possui uma estrutura específica. Esta é a estrutura:

```
>nome da sequencia
ATCGATCATCATCATCATCATCATCATCATCATCATCATCA

```

O caractere '>' determina o início do identificador de uma sequência de DNA, RNA ou proteína. O nome da sequência pode conter qualquer descrição que seja relevante, como o nome da espécie que a sequência é proveniente, o nome do gene e qualquer outra descrição necessária. Por fim, a sequência em si pode estar formatada em um número variável de linhas, pois o que determina o fim da sequência é o '>' de início da próxima sequência contido no arquivo.
 
O dataset de _Helobdella_ contém um total de 148 sequências em formato fasta. Repare também que, apesar de todas as sequências serem provenientes de COI, o tamanho das sequências é variável. Algumas são mais longas e outras são mais curtas. Esta diferença de tamanho é comum em dados provenientes de sequenciamento. Há dois motivos, um deles é uma possível deleção ou inserção de nucleotídeos nas sequências. Porém, o motivo mais comum é de natureza metodológica.


### Alinhamento e construção da matriz

Para utilizar estes dados em análises filogenéticas, nós precisamos contruir uma matriz em que os nucleotídeos homólogos estão nas mesma posição na sequência. Isso permite que o softwares façam a comparação destes sítios.

Nós utilizaremos o software _MAFFT_ para este fim. O _MAFFT_ é um programa para realizar um processo chamado de alinhamento. Neste processo, sítios homólogos são identificados. Além disso, são adicionados _Gaps_ em sítios onde não há informação sobre qual nucleotídeo compõe um determinado sítio ou onde houve um _indel_ (INserção/DELeção).

**1º passo:**
O _MAFFT_ pode ser utilizado através de uma interface gráfica através de um website. Acesse o site: https://mafft.cbrc.jp/alignment/server/index.html

**2º passo:**
Copie e cole todas as sequências contidas no arquivo no campo demostrado na figura abaixo:

![image](https://github.com/user-attachments/assets/9f023a58-e481-49f8-a59d-4da74454ea96)

**3º passo:**
Nós utilizaremos os parâmetros padrão para o alinhamento destes dados. Porém é importante ter em mente que cada _dataset_ exige parâmetros específicos, dependendo da natureza dos genes sendo alinhados.

Vá até o fim da página e clique em _Submit_.

Em alguns segundos, você poderá observar os resultados. Perceba que foram adicionados diversos caracteres '-'. Estes caracteres '-' representam os _Gaps_ inseridos pelo _MAFFT_ para construir o alinhamento. Lembrando que eles representam sítios onde não há informação sobre o nucleotídeo ou eventos de indel.

> [!NOTE]
> Não é possível através de um alinhamento como este diferenciar a falta de informação sobre um sítio de um indel. Por este motivo, nas análises filogenéticas é comum considerar _Gaps_ como falta de informação e esses dados não são considerados nas análises.

**4º passo:**
Copie o texto formatado em _fasta_, como demonstra a figura abaixo:

![image](https://github.com/user-attachments/assets/b0bcab5c-3d6e-4dc1-96ca-cce63b0f0faf)

Utilize o nano para salvar o alinhamento em formato fasta.
```
nano
```

Siga as instruções do programa para salvar o arquivo com o nome ```helobdella_GenEvol_dataset_aligned.fasta```.


**5º passo:**
Infelizmente, o _TNT_ não aceita o formato _fasta__ como _input_. Desta forma, nós teremos que converter a nossa matriz, para o formado _Hennig86_ que é o formato aceito pelo _TNT_.


> [!NOTE]
> **O formato Hinnig86 para sequências pode ser conferido abaixo:**
>
> 
> xread ‘optional title, starting and ending with quotes (ASCII 39)’
> 
>nchar ntax
> 
>Taxon0 0000000000
> 
>Taxon1 0010111000
> 
>Taxon2 1011110000
> 
>Taxon3 1111111000
> 
>…..
> 
>TaxonN 1111111000
> 
>; ‘<- Note the semicolon (and the way you add comments)!’
>

O _script_ 'fasta2hennig86.py' faz esta conversão automaticamente. Para executar este _script_ na matriz. Digite o comando abaixo: 


```
python3 fasta2hennig86.py helobdella_GenEvol_dataset_aligned.fasta
```

O arquivo matrix.tnt deverá ser criado, caso o _script_ tenha corrido perfeitamente.

## Reconstrução filogenética por parsimônia usando o _TNT_

Agora que nós já temos o a matriz, nós utilizaremos o _TNT_ para realizar busca heurística da árvore mais parsimoniosa.

**1º passo:**
Mude o seu diretório de trabalho para a pasta contendo o aquivo executável do _TNT_ (TNT-bin). E execute o arquivo _TNT_: 

```
cd TNT-bin
./TNT
```

Caso seja a primeira vez que você executou o _TNT_, você precisará aceitar os termos de uso. Siga as instruções do programa.

Após executar o _TNT_, você deverá observar a seguinte tela:

![image](https://github.com/user-attachments/assets/344d096c-177b-416b-8e8f-980b6f99fbff)

Observe que o prompt do terminal foi substituido pelo prompt do _TNT_, indicado pela seta.


**2º passo:**
Apesar do _TNT_ ser bastante eficiente na busca heirística, ele apresenta diversos problemas. O primeiro deles é a falta de um manual oficial. Desta forma, nós precisamos utilizar fontes diversas quando precisamos resolver problemas, ou procurar por comandos do programa. A tabela abaixo fornece uma lista dos comando do TNT, mas para saber o que eles fazem, você precisará utilizar o comando 'help'.

![image](https://github.com/user-attachments/assets/7ea14c6b-61d5-4b73-8d4d-4646d6fde6a4)

Para exibir instruções para um comando, tente ```help <nomedocomando>```. Tente:


```
help mxram
```

Antes de começar a análise, nós precisamos alocar memória RAM do computador utilizado para esta análise. Este procedimento é feito com o comando 'mxram'. Aloque 5 gb de memória RAM com o comando:

```
mxram 5000;
```

O comando 'nstates' especifica qual será o tipo de matriz utilizada na análise. No nosso caso, nós utilzaremos sequências de DNA, portanto teremos que especificar para o TNT utilizando seguinte linha de comando:


```
nstates DNA;
```

Agora, indique a matriz que será utilizada para a análise:

```
procedure matrix.tnt;
```

Perceba que o TNT indica as dimensões e quantos estados de caracteres estão presentes na análise.

**3º passo: configurando os parâmetros de busca**

Antes de começar a busca heurística, nós precisamos especificar alguns parâmetros. São eles:

```
rseed *;
taxname =;
hold 100000;
tsave helobdella.mpts.tnttre;
xmult: replic 1000 ratchet 5 nodrift fuse 5 hits 10;
```

Onde: 

```rseed *;``` - Seleciona uma árvore aleatória para começar a busca

```taxname =;``` - Extrai o nome dos terminais da própria matriz

```hold 100000;``` - Armazena 100000 árvores na memória

```tsave helobdella.mpts.tnttre;``` - Salva a árvore no arquivo especificado

```xmult: replic 1000 ratchet 5 nodrift fuse 5 hits 10;``` - Especifica os algorítmos utilizados na busca heurística. Serão: 1000 répicas, 5 rodadas de ratched, não será aplicado drift, 5 rodadas de fuse e a busca terminará quando a árvore atingir 10 hits.


**4º passo: Busca heurística**

Inicie a busca heurística:


```
xmult;
```

Note que o _TNT_ exige o número de réplicas realizadas, o _best score__ da réplica atual, e o número de rearranjos investigados.


> [!NOTE]
> **Qual o _best score_ geral da busca e quantas árvores foram encontradas com este _score_?**

Estas árvores representam hipóteses igualmente prováveis segundo o critério de parsimônia.

Salve os resultados da busca:

```
save;
tsave/;
```

Para visualizar estas árvores de uma maneira significativa, nós podemos utilizar o consenso. Existem vários tipos de consenso, mas nós utilizaremos o consenso de Nelsen, em que os ramos conflituosos forma politomias. Assim, utilize os seguintes comandos para gerar uma árvore de consenso:

```
nelsen *;
tchoose /;
```

**5º passo: Comprimento de ramos e suporte de nós**

Esta árvore de consenso, ainda não possui valores comprimento de ramos e de suporte de nós associados.

Para gerar valores de comprimento de ramos:
```
ttags =;
blength *0;
tsave *consensus_bootstraps.tnttre;
```

Nós iremos gerar valores de suporte _Bootstrap_:

```
resample boot replic 1000;
```


**6º passo: Salvando dados finais**

Por fim, salve os resultados finais e feche todos os arquivos abertos pelo _TNT_:

```
save*;
tsave/;
ttags -;
log/;
proc/;
```


**6º passo: Visualização da árvore**
O árquivo gerado é uma árvore com comprimento de ramos e valores de suporte. Contudo, o TNT escreve o arquivo de árvore em um formato ... Peculiar. Para visualizar corretamente a árvore nos utilizaremos o script 'tnt_tree_clean.sh'.


Execute o script:
```
./tnt_tree_clean.sh
```

O script converte todas as árvores para o formato Newick. A árvore consensus_bootstraps.tnttre.tre contém a árvore final gerada pelo _TNT_. Esta árvore pode ser visualizada com o software iTol online:
https://itol.embl.de/

Clique em _upload_:
![image](https://github.com/user-attachments/assets/3e763b0e-c8f0-427d-8cbe-d137d1d1eeb2)



Em seguida faça o upload do arquivo ou copie e cole o conteúdo do arquivo no campo '_Tree text:_'.

Após o _upload_, clique na aba _advanced_ do painel de controle e ative a visualização do _bootstrap_.


**6º passo: retornando ao diretório do curso**
Antes de terminar este tutorial, volte para o diretório inicial do curso. Digite:

```
cd ..
```

Utilize o `pwd` para verificar se seu diretório atual é o `GenEvol_filogenetica`.





