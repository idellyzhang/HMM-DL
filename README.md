# HMM-DL
Using Hidden Markov Model to improve domain discovery based on domain dependency and linker length

## Running HMMER3 to get domain candidates (with lower threshold) (using E.coli as example)
``` HMMER3
hmmscan --F1 0.1 --F2 0.1 --F3 0.0001 -Z 1 --domZ 1 -E 0.001 --domE 0.001 -o /dev/null --domtblout ECE001.txt Pfam-A.hmm 0625_83333EC.fasta
```
## Usage
```perl
sh runMain.sh ECE001.txt
```
## Output
```
ECE001.dloutput.txt
```

#SimulationPlusFDR
Shuffling the residules on domains and computing false positves

## Usage
```
sh runMain.sh  ECFDRE001.txt 
```

## Output
```
20 (the number of false postives)
```
