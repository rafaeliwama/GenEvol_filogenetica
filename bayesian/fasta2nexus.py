#!/usr/bin/python3

import sys
import os
import re

try:
    from Bio import SeqIO

except:
    print('Biopython not installed. Trying to install with pip.')
    os.system('pip install biopython')
    from Bio import SeqIO



SeqIO.convert(sys.argv[1], 'fasta', re.sub('\.fasta$', '.nexus', sys.argv[1]), 'nexus', molecule_type='DNA')