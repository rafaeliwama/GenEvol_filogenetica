#!/usr/bin/python3

import sys
import os

try:
    from Bio import SeqIO

except:
    print('Biopython not installed. Trying to install with pip.')
    os.system('pip install biopython')
    from Bio import SeqIO


al = SeqIO.parse(sys.argv[1], 'fasta')

list_len = []

for s in al:
    list_len.append(len(s.seq))

if len(set(list_len)) == 1:
    print('Alignment lentgh: ' + str(list(set(list_len))[0]))

else:
    print('ERROR: This is not an valid alignment. Check the length of each aligned sequence.')