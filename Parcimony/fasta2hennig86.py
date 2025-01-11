#!/usr/bin/python3
import sys
import os

try:
    from Bio import SeqIO

except:
    print('Biopython not installed. Trying to install it with pip')
    os.system('pip install biopython')
    from Bio import SeqIO


str_to_write = 'xread \'TNT dataset\'\n'


fasta = list(SeqIO.parse(sys.argv[1], 'fasta'))

len_write = []
for s in fasta:
    len_write.append(len(s.seq))

str_to_write +=  str(list(set(len_write))[0]) + ' ' + str(len(fasta)) + '\n'

for s in fasta:
    str_to_write += str(s.description) + ' ' + str(s.seq) + '\n'

str_to_write += ';'


with open("matrix.tnt", "w") as text_file:
    text_file.write(str_to_write)