# Workshop: Reconstrução filogenética
### Instrutor: Rafael E. Iwama
### Monitora: Isabelle Cristine Santos da Silva

Bem-vindo ao workshop de Inferência Filogenética do Curso de Férias em Genética e Evolução (2025). Este será o repositório deste workshop e ficará disponível neste mesmo link, mesmo após o workshop acabar. O conteúdo deste workshop está dividido em:
1. [Introdução teórica](https://github.com/rafaeliwama/GenEvol_filogenetica/blob/main/0-teoria.md)
2. [Inferência filogenética por Parcimônia](https://github.com/rafaeliwama/GenEvol_filogenetica/blob/main/1-Parcimonia.md).
3. [Inferência filogenética por Máxima Verossimilhança](https://github.com/rafaeliwama/GenEvol_filogenetica/blob/main/2-Verossimilhanca.md)
4. [Inferência filogenética Bayesiana](https://github.com/rafaeliwama/GenEvol_filogenetica/blob/main/3-Bayesian.md)


Antes de começar, nós precisamos entender um pouco sobre a plataforma GitHub e sobre o terminal.

### O GitHub
O GitHub é um website e um serviço de nuvem que ajuda desenvolvedores a armazenar e desenvolver códigos de forma colaborativa. Nós utilizaremos o GitHub como um protocolo, em que os alunos do curso podem consultar as linhas de comando que serão executadas no terminal, ou as intruções para a realização de uma determinada atividade.

Acima, você verá uma série de arquivos. Os arquivos terminados em ".md", indicados pelas setas na figura abaixo, são os tutoriais para cada uma das atividades propostas.


![image](https://github.com/user-attachments/assets/6c4616ea-bba3-4a0e-8f69-bf384a49e19f)



Além destes arquivos, você pode observar que, dentro das pastas de cada conteúdo, também estão presentes arquivos ".fasta", ".txt" e outros formatos. O sufixo de um arquivo, normalmente, indica o tipo de arquivo. O sufixo ".md" indica que este arquivo é um arquivo readme do GitHub, que é este arquivo que você está lendo agora. Arquivos ".txt" são chamados de plain text, que são compostos apenas por texto. Arquivos ".fasta" são arquivos ".txt", que estão formatados para armazenar sequências de DNA ou proteína e informações associadas a estas sequências.

Ao longo deste tutorial, você ficará mais familiarizado com estes arquivos.


### O terminal

Durante este workshop, nós utilizaremos linhas de comando através do terminal. Apesar de assustador no início, esta é uma prática que fica mais fácil com o tempo. Erros simples, como erros de digitação, são comuns e chatos. A maior parte dos códigos presetes nos tutoriais desse curso devem funcionar sem maiores problemas. Porém, caso você tenha alguma dificuldade, não hesite em nos chamar.

Para que você se familiarize com os comandos principais do terminal, aqui vão alguns exemplos e exercícios:

**1. Abra o terminal e baixe os arquivos deste repositório**
Clique em inicar no windows e procure por _Ubunto_. Um janela como a figura abaixo deve se abrir. A seta indica o prompt e é por ele que você digitará os comandos necessários para completar os tutoriais.
![image](https://github.com/user-attachments/assets/c4fb260b-0e57-4428-8dc0-9676fa23dc0c)

O primeiro passo é utilizar o programa `git` para baixar os arquivos e pastas para o workshop de hoje.

digite:

```
git clone https://github.com/rafaeliwama/GenEvol_filogenetica.git

```
Observe que o terminal indica (printa) que arquivos e pastas estão sendo baixados.

Nós utilizaremos poucos comandos, porém é preciso que vocês estejam bem familiarizados com alguns deles. O primeiro deles é o `ls`

Digite no terminal:

```
ls
```

Você verá que uma série de nomes de arquivos e diretórios (pastas). Na figura abaixo, diretórios e arquivos estão indicados pela cor azul.

![image](https://github.com/user-attachments/assets/74cc6a33-ecc7-40f5-ab42-8e59437d6ce0)

Note que a pasta GenEvol_filogenetica foi criada. Esta pasta contém todos os arquivos necessários para você completar os tutoriais de hoje.

**2. Mudando de diretório de trabalho**

_Comando pwd_

O diretório de trabalho é o diretório em que todas as ações serão executadas e os arquivos eventualmente gerados serão gravados neste diretório. O comando _pwd_ printa o seu diretório atual:

``` 
pwd
```

Note que o caminho do diretório foi printado no terminal. Como na figura abaixo:
![image](https://github.com/user-attachments/assets/f72445e3-1516-47c9-acd5-381caff57117)

Este cominho indica que o diretório de trabalho atual é o `Rafael`, e que o diretório `Rafael` está dentro do diretório `home`.

Como nós utilizaremos o diretório do curso, mude o diretório atual para o GenEvol_filogenetica com o comando `cd`.
```
cd GenEvol_filogenetica
```

Observe que após o comando `cd`, nós acrecentamos o nome da pasta.

utilize o comando `pwd` para checar o diretório de trabalho atual.

Para retornar a pasta parental (acima), digite:

```
cd ..
```

Utilize o comando `pwd` para checar a pasta atual. E o comando `ls` para lisar os arquivos e diretórios desta pasta. Note que vc está de volta ao diretório inicial.

Contudo, nós precisamos que você esteja dentro da pasta do curso. digite os seguintes comandos para mudar de diretório e verificar que está no `GenEvol_filogenetica`:

```
cd GenEvol_filogenetica
pwd
```

**3. Utilizando scripts em python**


Durante o workshop de hoje, nós precisaremos utilizar alguns scripts em python, que contém comandos para serem executados em série para efetuar uma tarefa. Note que o _script_ 'Hello.py' está presente neste diretório. Este _script_ possui uma única opção, que é o seu nome. Para executa-lo, digite:

```
python3 <nomedoscript> <seunome>

```

> [!TIP]
> Lembre de substituir `<nomedoscript>` pelo nome do _script_ e `<seunome>` pelo seu nome.



Agora, você já conhece todos os comandos necessários para o workshop de hoje. Contudo, se precisar de ajuda, chame um de nós.


Se tiver alguma dúvida após o curso, manda um e-mail para: eiji.iwama@usp.br


**Bom trabalho!**
