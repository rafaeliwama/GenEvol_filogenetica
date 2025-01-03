# Análise filogenética por métodos de máxima parcimônia
### Intrutor: Rafael E. Iwama
### Monitora: Isabelle Cristine Santos da Silva

### Uma breve introdução aos métodos de máxima parsimônia

Os métodos de parcimônia utilizam como critério de otimalidade, o princípio da navalha de Ockham. Este princípio considera que a melhor explicação para um fenômeno é a mais simples, ou seja, aquela que requer um menor número de pressupostos. Willi Hennig (1913-1976) formalizou o método baseado em parcimônia para reconstruções filogenéticas através da utilização de uma matriz numérica, já utilizada pelos feneticistas. Este método assume que mudanças são raras, e portanto que a hipótese mais provavel é aquela com o menor número de mudanças.


Computacionalmente, vários softwares estão disponíveis para este tipo de análise. Estes softwares variam, principalmente, no processo de *tree search*. O *tree search*, basicamente é a busca heurística pela melhor árvore, de acordo com um critério. Neste caso, nosso critério de otimalidade é a máxima parsimônia. Esta busca heurística é utilizada porque computacionalmente, é impossível de se avaliar todas as árvores possíveis para um determinado *dataset*.

A figura abaixo representa o número de árvores possíveis para um dataset *n* terminais. Para um dataset de apenas 6 terminais, há quase 92 mil árvores possíveis. 
![image](https://github.com/user-attachments/assets/10fc6507-9bd6-4e1d-ae06-5011a81b816d)


Existem vários softwares para reconstrução filogenética utilizando o critério de parcimônia. O TNT (_Tree Analysis using New Technology_) é um software bastante robusto para este tipo de análise, pois implementa algorítmos poderos de busca heurística. Durante este tutorial, nós utilizaremos o TNT para a reconstrução filogenética do dataset de _Helobdella_.

Abra baixe e abra o arquivo 'helobdella_COI_GenEvol.fasta' em editor de text. Você pode utilizar o notepad, por exemplo. Contudo, outros editores de texto estão disponíveis.

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
