# CytcApaf1-sequence-covariation

This is the second half of this project to determine if there is any sequence vairation within cytochrome c and Apaf-1 between Metazoan species. By determining if there is any sequence covariation of cytochrome c and Apaf-1 between different species we can gain more insight as to why mouse and human cytochrome c have different rates of in vitro caspase activity. 

To retrieve UniProt KB Metazoan proteomes and upload them onto the University of Otago Biochemistry server the script below was used: Jack Hmmer v3.3.2 was already intalled. 

All script is written and ran using Perl v5.30.0 x86 Linux

Script for establishing a reference proteome of the University of Otago Biochemistry server

[fetch-proteomes.txt](https://github.com/mouch930/CytcApaf1-sequence-covariation/files/10574664/fetch-proteomes.txt)

Text file containing script used to edit the reference proteome by removing Tunicates, Arthropods, and Nematodes, search against the reference proteome for two iterations, multiple sequence alignments and sorting results. 

[reference-proteome.txt](https://github.com/mouch930/CytcApaf1-sequence-covariation/files/10574668/reference-proteome.txt)

Text file containing script to join and concatenate cyotchrome c and Apaf-1 multiple sequence alignments

[joinSeqs.txt](https://github.com/mouch930/CytcApaf1-sequence-covariation/files/10575237/joinSeqs.txt)

Using the human Apaf-1 as a query the Jack Hmmer homology search was done and iterated twice. The second iteration files are avaible in FASTA, aligned FASTA and tab-delimited files:

Apaf-1-second-iteration.fa

Apaf-1-second-iteration.afa

Apaf-1-second-iteration.domtblout

The same process was continued for cytochrome c. FASTA and aligned FASTA outputs were produced. 

Cyc-second-iteration.fa

Cys-second iteration.afa


