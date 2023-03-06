
#SERVER: 
ssh -X paulgardner@biochemcompute.uod.otago.ac.nz
mkdir /Volumes/scratch/gardnerlab/chloe
cd /Volumes/scratch/gardnerlab/chloe

#PAUL'S LAPTOP
scp  reference_proteomes_QfO_Eukaryota.html   paulgardner@biochemcompute.uod.otago.ac.nz:/Volumes/scratch/gardnerlab/chloe/

#SERVER: 

#TEST FETCH:
wget https://ftp.ebi.ac.uk/pub/databases/reference_proteomes/QfO/Eukaryota/UP000000437_7955.fasta.gz




#FETCH LOTS OF METAZOAN PROTEOMES:
https://www.uniprot.org/proteomes/?query=taxonomy%3A%22Eukaryota+%5B2759%5D%22+redundant%3Ano
https://www.uniprot.org/proteomes/UP000503349/uniprot-proteome_UP000503349.fasta
wget https://www.uniprot.org/uniprot/?query=proteome:UP000503349&format=fasta 


#Fetch metazoan proteomes:
#cd /home/paulgardner/people/chloe-mountain/data
cd /home/paulgardner/biochem-storage/Lab_Groups/gardnerlab/chloe/metazoa-proteomes/
#####################################################FETCH HERE:
~/people/chloe-mountain/fetch-proteomes.pl 33208
####################################################
watch -n 5 'ls ~/biochem-storage/Lab_Groups/gardnerlab/chloe/UP*gz*'

ls -1 *gz | awk '{print "gunzip "$1}'  | sh
#move 4 broken files sideways "error/" dir. 
head -n 1  *fasta  | perl -lane 'if (/^==> (\S+)/){$protID=$1}elsif(/^>.*(OS=.*OX=\d+)/){print "$protID\t$1\t$_"}' > summary.txt

#FILTER OUT UNDESIRABLE PROTEOMES (arthropoda, nematode & tunicate)
#List uniprot IDs, fetch taxonomy strings: 
cat summary.txt  | perl -lane 'if(/>..\|(\S+)\|/){print $1}' > uniprot-ids.txt

https://www.uniprot.org/uploadlists/
#Saved Kingdom, Phylum & Class info for each seq+p[roteome: 
uniprot-taxonomic-info.tab.gz

#FORMAT:
less uniprot-taxonomic-info.tab | head -n 1 | tr "\t" "\n" | nl
    #  1	Entry
    #  2	Entry name
    #  3	Status
    #  4	Protein names
    #  5	Gene names
    #  6	Organism
    #  7	Taxonomic lineage (ALL)
    #  8	Taxonomic lineage IDs
    #  9	Taxonomic lineage (CLASS)
    # 10	Taxonomic lineage (PHYLUM)
    # 11	Taxonomic lineage (SUBPHYLUM)
    # 12	Taxonomic lineage (SUBCLASS)
    # 13	Taxonomic lineage (KINGDOM)
    # 14	Taxonomic lineage (SUPERPHYLUM)
    # 15	Taxonomic lineage (SUPERKINGDOM)
    # 16	Taxonomic lineage (SUPERCLASS)
    # 17	Taxonomic lineage (SUBKINGDOM)
    # 18	Proteomes

mkdir moved-sideways
egrep 'Arthropoda|Nematoda|Tunicata' uniprot-taxonomic-info.tab | perl -lane '@F=split(/\t/, $_); if($F[17] =~ /(UPF\d+)/){ print "mv $1* moved-sideways/"  } '

#AGGGGGGHHHHHH!  FIX WRONG/MULTI-PROTEOME ISSUES:
egrep 'UP000030764|UP000054805|UP000050787|UP000069940|UP000050601|UP000036680|UP000038042|UP000050793|UP000004810|UP000077448|UP000050760|UP000038043|UP000038041|UP000038040|UP000046394|UP000050602' uniprot-taxonomic-info.tab  | cut -f 1 | tr "\n" "|"
egrep 'A0A085MMP2|A0A0V1JF76|A0A183GY72|A0A182GDS3|A0A0R3PVB5|A0A0M3KCV4|A0A0N4WWR4|A0A183IKM4|J9B388|A0A182E469|A0A183E943|A0A0N4YC50|A0A0N4V2Z3|A0A158Q4R4|A0A0N5D9F1|A0A0R3QRR5' summary.txt | perl -lane 'print "mv $F[0] moved-sideways/"'


######################################################################
#Big data move from biochem-storage to /Volumes/scratch/gardnerlab/chloe/ on biochemcompute1.uod.otago.ac.nz
cd ~/biochem-storage/Lab_Groups/gardnerlab/chloe/
scp  -r ./   biochemcompute1.uod.otago.ac.nz:/Volumes/scratch/gardnerlab/chloe/



######################################################################
#QUERIES:

Cytc – WD40 realignment – edited sequences with only the cyt c and WD40 domain concatenated 
CLUSTAL alignment file – raw data of concatenated sequences. 
D12F4748-C346-11EB-9529-D1A153F04F9B.3 – Jack Hmmer cyt c results 
F8B28AA0-C346-11EB-9D42-2449E976C163.3 – Jack Hmmer Apaf-1 results
 
 
>sp|O14727|APAF_HUMAN Apoptotic protease-activating factor 1 OS=Homo sapiens OX=9606 GN=APAF1 PE=1 SV=2
MDAKARNCLLQHREALEKDIKTSYIMDHMISDGFLTISEEEKVRNEPTQQQRAAMLIKMI
LKKDNDSYVSFYNALLHEGYKDLAALLHDGIPVVSSSSGKDSVSGITSYVRTVLCEGGVP
QRPVVFVTRKKLVNAIQQKLSKLKGEPGWVTIHGMAGCGKSVLAAEAVRDHSLLEGCFPG
GVHWVSVGKQDKSGLLMKLQNLCTRLDQDESFSQRLPLNIEEAKDRLRILMLRKHPRSLL
ILDDVWDSWVLKAFDSQCQILLTTRDKSVTDSVMGPKYVVPVESSLGKEKGLEILSLFVN
MKKADLPEQAHSIIKECKGSPLVVSLIGALLRDFPNRWEYYLKQLQNKQFKRIRKSSSYD
YEALDEAMSISVEMLREDIKDYYTDLSILQKDVKVPTKVLCILWDMETEEVEDILQEFVN
KSLLFCDRNGKSFRYYLHDLQVDFLTEKNCSQLQDLHKKIITQFQRYHQPHTLSPDQEDC
MYWYNFLAYHMASAKMHKELCALMFSLDWIKAKTELVGPAHLIHEFVEYRHILDEKDCAV
SENFQEFLSLNGHLLGRQPFPNIVQLGLCEPETSEVYQQAKLQAKQEVDNGMLYLEWINK
KNITNLSRLVVRPHTDAVYHACFSEDGQRIASCGADKTLQVFKAETGEKLLEIKAHEDEV
LCCAFSTDDRFIATCSVDKKVKIWNSMTGELVHTYDEHSEQVNCCHFTNSSHHLLLATGS
SDCFLKLWDLNQKECRNTMFGHTNSVNHCRFSPDDKLLASCSADGTLKLWDATSANERKS
INVKQFFLNLEDPQEDMEVIVKCCSWSADGARIMVAAKNKIFLFDIHTSGLLGEIHTGHH
STIQYCDFSPQNHLAVVALSQYCVELWNTDSRSKVADCRGHLSWVHGVMFSPDGSSFLTS
SDDQTIRLWETKKVCKNSAVMLKQEVDVVFQENEVMVLAVDHIRRLQLINGRTGQIDYLT
EAQVSCCCLSPHLQYIAFGDENGAIEILELVNNRIFQSRFQHKKTVWHIQFTADEKTLIS
SSDDAEIQVWNWQLDKCIFLRGHQETVKDFRLLKNSRLLSWSFDGTVKVWNIITGNKEKD
FVCHQGTVLSCDISHDATKFSSTSADKTAKIWSFDLLLPLHELRGHNGCVRCSAFSVDST
LLATGDDNGEIRIWNVSNGELLHLCAPLSEEGAATHGGWVTDLCFSPDGKMLISAGGYIK
WWNVVTGESSQTFYTNGTNLKKIHVSPDFKTYVTVDNLGILYILQTLE
 

>sp|P99999|CYC_HUMAN Cytochrome c OS=Homo sapiens OX=9606 GN=CYCS PE=1 SV=2
MGDVEKGKKIFIMKCSQCHTVEKGGKHKTGPNLHGLFGRKTGQAPGYSYTAANKNKGIIW
GEDTLMEYLENPKKYIPGTKMIFVGIKKKEERADLIAYLKKATNE
######################################################################

cd /Volumes/scratch/gardnerlab/chloe/

#gENERATE QUERY:
cd queries 
sfetch -d APAF_HUMAN.fasta    -f 90 -t 605 'sp|O14727|APAF_HUMAN' > APAF_HUMAN-NOcard-NOwd40.fasta
hmmbuild APAF_HUMAN-NOcard-NOwd40.hmm APAF_HUMAN-NOcard-NOwd40.fasta 
hmmpress  APAF_HUMAN-NOcard-NOwd40.hmm 

hmmbuild CYC_HUMAN.hmm CYC_HUMAN.fasta 
hmmpress  CYC_HUMAN.hmm 


#Run searches on the biochem server:
#TEST:
#~/inst/hmmer-3.3.2/src/hmmsearch -E 0.001  --tblout APAF_HUMAN-NOcard-NOwd.40UP000537747.tblout --domtblout  APAF_HUMAN-NOcard-NOwd40.hmm  ../metazoa-proteomes/UP000537747.fasta  > /dev/null &


ls -1 ../metazoa-proteomes/*fasta | perl -lane 'if(/\/(UP\S+)\.fasta/){print "~/inst/hmmer-3.3.2/src/hmmsearch -E 0.001  --tblout APAF_HUMAN-NOcard-NOwd40.$1.tblout --domtblout APAF_HUMAN-NOcard-NOwd40.$1.domtblout  APAF_HUMAN-NOcard-NOwd40.hmm  ../metazoa-proteomes/$1.fasta  > /dev/null &"}' | sh &

ls -1 ../metazoa-proteomes/*fasta | perl -lane 'if(/\/(UP\S+)\.fasta/){print "~/inst/hmmer-3.3.2/src/hmmsearch -E 0.001  --tblout first-iteration-hmmer-results/CYC_HUMAN.$1.tblout --domtblout first-iteration-hmmer-results/CYC_HUMAN.$1.domtblout  CYC_HUMAN.hmm  ../metazoa-proteomes/$1.fasta  > /dev/null &"}' | sh &



#FETCH SEQUENCES:
cat first-iteration-hmmer-results/APAF1_HUMAN.*.domtblout | perl -lane 'if(/# target name/){$cnt++; }elsif( $_ !~ /^#/ && not defined($seen{$cnt }) ){ $seq = $F[0];  $seen{$cnt}=1; }elsif(/# Target file:\s+(\S+)/){$protFile = $1; if(defined($seen{$cnt})){ print "sfetch -d $protFile \42$seq\42"; } }' | sh > first-iteration.fasta

cat first-iteration-hmmer-results/CYC_HUMAN.*.domtblout | perl -lane 'if(/# target name/){$cnt++; }elsif( $_ !~ /^#/ && not defined($seen{$cnt }) && $_ !~ /testis-specific/  ){ $seq = $F[0];  $seen{$cnt}=1; }elsif(/# Target file:\s+(\S+)/){$protFile = $1; if(defined($seen{$cnt})){ print "sfetch -d $protFile \42$seq\42"; } }' | sh > first-iteration-cyc.fasta




mkdir first-iteration-hmmer-results 
mv *tblout first-iteration-hmmer-results/

#make alignment:
clustalo -i first-iteration.fasta  -o first-iteration.aln

mafft CYC-first-iteration.fasta > CYC-first-iteration.afa




#SECOND ITERATION 

hmmbuild first-iteration-apaf1.hmm first-iteration.aln
hmmpress  first-iteration-apaf1.hmm

hmmbuild first-iteration-cyc.hmm first-iteration-cyc.afa
hmmpress  first-iteration-cyc.hmm


#Run searches on the biochem server:
ls -1 ../metazoa-proteomes/*fasta | perl -lane 'if(/\/(UP\S+)\.fasta/){print "~/inst/hmmer-3.3.2/src/hmmsearch -E 0.001  --tblout second-iteration-apaf1.$1.tblout --domtblout second-iteration-apaf1.$1.domtblout  first-iteration-apaf1.hmm  ../metazoa-proteomes/$1.fasta  > /dev/null &"}' | sh &

ls -1 ../metazoa-proteomes/*fasta | perl -lane 'if(/\/(UP\S+)\.fasta/){print "~/inst/hmmer-3.3.2/src/hmmsearch -E 0.001  --tblout second-iteration-hmmer-results/second-iteration-cyc.$1.tblout --domtblout second-iteration-hmmer-results/second-iteration-cyc.$1.domtblout  first-iteration-cyc.hmm  ../metazoa-proteomes/$1.fasta  > /dev/null &"}' | sh &



#FETCH SEQUENCES (BITSCORES>100 AND ONLY THE TOP HIT FOR EACH PROTEOME):
cat !!!!!!EDIT HERE!!!!!
*.domtblout | perl -lane 'if(/# target name/){$cnt++; }elsif( $_ !~ /^#/ && $F[7] > 500  &&  not defined($seen{$cnt }) ){ $seq = $F[0]; $score = $F[7]; $seen{$cnt}=1; }elsif(/# Target file:\s+(\S+)/){$protFile = $1; if(defined($seen{$cnt})){print "sfetch -d $protFile \42$seq\42"; } }' | sh > second-iteration.fasta


cat second-iteration-hmmer-results/second-iteration-cyc.*.domtblout | perl -lane 'if(/# target name/){$cnt++; }elsif( $_ !~ /^#/ && $F[7] > 150  &&  not defined($seen{$cnt }) ){ $seq = $F[0]; $score = $F[7];  $seen{$cnt}=1; }elsif(/# Target file:\s+(\S+)/){$protFile = $1; if(defined($seen{$cnt})){ print "sfetch -d $protFile \42$seq\42"; } }' | sh > second-iteration-cyc.fasta



head -n 3 second-iteration-apaf1.UP000053537.domtblout  > second-iteration.domtblout.tsv
cat *.domtblout | perl -lane 'if(/# target name/){$cnt++; }elsif( $_ !~ /^#/ && $F[7] > 500  &&  not defined($seen{$cnt }) ){ $seq = $F[0]; $outline = $_;  $seen{$cnt}=1; }elsif(/# Target file:\s+(\S+)/){$protFile = $1; if(defined($seen{$cnt})){ print $outline; } }' | sort -k8nr  >> second-iteration.domtblout.tsv


mafft second-iteration.fasta > second-iteration.afa

mafft second-iteration-cyc.fasta > second-iteration-cyc.afa


