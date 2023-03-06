# CytcApaf1-sequence-covariation

This is the second half of this project to determine if there is any sequence vairation within cytochrome c and Apaf-1 between Metazoan species. By determining if there is any sequence covariation of cytochrome c and Apaf-1 between different species we can gain more insight as to why mouse and human cytochrome c have different rates of in vitro caspase activity. 

To retrieve UniProt KB Metazoan proteomes and upload them onto the University of Otago Biochemistry server the script below was used: Jack Hmmer v3.3.2 was already intalled. 

All script is written and ran using Perl v5.30.0 x86 Linux

Script for establishing a reference proteome of the University of Otago Biochemistry server

fetch-proteomes.pl

Text file containing script used to edit the reference proteome by removing Tunicates, Arthropods, and Nematodes, search against the reference proteome for two iterations, multiple sequence alignments and sorting results. 

reference-proteome.pl

Text file containing script to join and concatenate cyotchrome c and Apaf-1 multiple sequence alignments

joinSeqs.pl

To filter out the Tunicates, Arthropods, and Nematodes from the reference proteome used UniProt taxonomic information to assign the correct information to seach Apaf-1 and cytochrome c paralogs found through jackhmmer searches. File containing all the taxonomic information:

uniprot-taxonomic-info.csv

Using the human Apaf-1 as a query the Jack Hmmer homology search was done and iterated twice. The second iteration files are avaible in FASTA, aligned FASTA and tab-delimited files:

Apaf-1-second-iteration.fa

Apaf-1-second-iteration.afa

Apaf-1-second-iteration.domtblout

The same process was continued for cytochrome c. FASTA and aligned FASTA outputs were produced. 

Cyc-second-iteration.fa

Cyc-second iteration.afa

The cytc and apaf-1 alignments were concatenated based on the species they were originated from. The raw alignment is:

joinedAlignments.fa

The joinedAlignment file was edited as listed below. The joinedAlignment file is added after each step. 

STEP 1: the extra sequence/space before the beginning of the cytc seqeunce and after the apaf1 sequence were removed. (use the human sequences to determine where the end/begining of the alignment sequences are)

joinedAlignments1.fa

STEP 2: Starting at the beginning of the alignment were the cyt c sequence is and remove all the sequences which are causing gaps in the cyt c sequence of the joined alignment. These sequences will have insertions and will either result in a protein that is not cytc. Cytc is too conserved to have large insertions/deletions.

joinedAlignments2.fa

STEP 3: Remove all sequences which are unsually long/short. The human concatenated sequence length is 1370 amino acids in length and should not vary huge amounts between species. Sequences that are above 1600 amino acids and below 1100 amino acids in length remove from the alignment. It doesn't matter if some short/long sequences are missed, they will likely have extra sequence causing or missing Apaf1 domains

joinedAlignments3.fa

STEP 4: Locate the human sequence and all the sequence/gaps that exist before the CARD domain of apaf-1 delete until you reach the string of W's which indicate separating the cytc sequence from Apaf-1. The part of the card domain of apaf1 sequence at amino acid 1. all other sequences and domains are found on UniProt. Remove sequences that are causing gaps in the alignment. Some of the sequences will have inserts and will cause spaces and there are usually only 1 or 2 sequences responsible for large gaps it is safe to assume the proteins encoding these sequences are not Apaf-1/are not functional Apaf1

joinedAlignments4.fa

STEP5: Annotate the human concatenated sequence according to the apaf1 domains on Uniprot and then remove other sequence which have gaps that align with these domians. If Apaf-1 is missing domains, this will not be a fully functional Apaf1/not a quality apaf1 sequence to accurately measure covariance with. If there are domains that are missing in Apaf-1 as then will not result in a functional Apaf1 protein either and these sequences should also be removed from the alignment. This is the alignment before I truncate it to only contain the apaf1 WD40 and cytc.

joinedAlignments5.fa

STEP 6: Using the human concatenated sequence, truncate the NB-ARC, CARD and unannotated sequence so that only the WD40 domains are present in the alignment. Cytc only interacts with the apaf1 WD40 domain, so if there is any sequence covariance between cytc and apaf1 it will be within these 2 domains 

joinedAlignments6.fa


