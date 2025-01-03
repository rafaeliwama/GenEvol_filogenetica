# Análise filogenética por métodos de máxima parcimônia
### Intrutor: Rafael E. Iwama
### Monitora: Isabelle Cristine Santos da Silva

### Uma breve introdução aos métodos de máxima parsimônia

Os métodos de parcimônia utilizam como critério de otimalidade, o princípio da navalha de Ockham. Este princípio considera que a melhor explicação para um fenômeno é a mais simples, ou seja, aquela que requer um menor número de pressupostos. Willi Hennig (1913-1976) formalizou o método baseado em parcimônia para reconstruções filogenéticas através da utilização de uma matriz numérica, já utilizada pelos feneticistas. Este método assume que mudanças são raras, e portanto que a hipótese mais provavel é aquela com o menor número de mudanças.


Computacionalmente, vários softwares estão disponíveis para este tipo de análise. Estes softwares variam, principalmente, no processo de *tree search*. O *tree search*, basicamente é a busca heurística pela melhor árvore, de acordo com um critério. Neste caso, nosso critério de otimalidade é a máxima parsimônia. Esta busca heurística é utilizada porque computacionalmente, é impossível de se avaliar todas as árvores possíveis para um determinado *dataset*.

A figura abaixo representa o número de árvores possíveis para um dataset *n* terminais. Para um dataset de apenas 6 terminais, há quase 92 mil árvores possíveis. 
![image](https://github.com/user-attachments/assets/10fc6507-9bd6-4e1d-ae06-5011a81b816d)


Existem vários softwares para reconstrução filogenética utilizando o critério de parcimônia. O TNT (_Tree Analysis using New Technology_) é um software bastante robusto para este tipo de análise, pois implementa algorítmos poderos de busca heurística. Durante este tutorial, nós utilizaremos o TNT para a reconstrução filogenética do dataset de _Helobdella_.



> [!NOTE]
> Useful information that users should know, even when skimming content.
