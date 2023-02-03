# CytcApaf1-sequence-covariation

#This is the second half of this project to determine if there is any sequence vairation within cytochrome c and Apaf-1 between Metazoan species. By determining if there is any sequence covariation of cytochrome c and Apaf-1 between different species we can gain more insight as to why mouse and human cytochrome c have different rates of in vitro caspase activity. 

#To retrieve UniProt KB Metazoan proteomes and upload them onto the University of Otago Biochemistry server the script below was used: Jack Hmmer v3.3.2 was already intalled. 

#All script is written and ran on Perl v5.30.0 x86 Linux

#Script for establishing a reference proteome of the University of Otago Biochemistry server

fetch-proteome.txt

#Text file containing script used to edit the reference proteome by removing Tunicates, Arthropods, and Nematodes, search against the reference proteome for two iterations, multiple sequence alignments and sorting results. It also contains the code for concatenating and joining sequence alignments. 

reference-proteome.txt
