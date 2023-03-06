#!/usr/bin/perl

#take Chloe's spreadsheets of protein accessions and sequences.
# 1. generate a fasta for cytc & apaf1 
# 2. generate mafft alignments
# 3. join alignments based on organism (add WWWWWW in between) 


#  -- create new accessions
#  -- data cleanup: remove duplicates 


use strict;
use warnings;

my $cytcHash  = csv2alnfasta("cytc_iteration2_sequence_retrieval.csv", "cytc_iteration2_sequence_retrieval.afa"); 
my $apaf1Hash = csv2alnfasta("apaf_iteration2_batch_retrieval.csv",    "apaf_iteration2_batch_retrieval.afa"); 

my  $cytcAlnseq2org = alnfasta2hash($cytcHash, "cytc_iteration2_sequence_retrieval.afa");
my $apaf1Alnseq2org = alnfasta2hash($apaf1Hash, "apaf_iteration2_batch_retrieval.afa");

joinAligns( $apaf1Alnseq2org, $cytcAlnseq2org ); 

print "END!!!!\n";

sub joinAligns{
    
    my ($aln1,$aln2) = @_;     
    my %aln1 = %{$aln1};
    my %aln2 = %{$aln2};

    open(UT, "> joinedAlignments-reversed.afa");
    
    my %seenAln2; 
    foreach my $org (sort keys %aln1 ){

	if(defined( $aln2{$org} )){
	    print UT ">$org\n$aln1{$org}\nWWWWWWWWWWWWWWWWW\n$aln2{$org}\n";
	    $seenAln2{$org}=1; 
	}
	else {
	    print "ERROR: No match for [$org] in alignment 2!!!\n"; 	    
	}		
    }

    foreach my $org (sort keys %aln2 ){
	if (not defined($seenAln2{$org})){
	    print "ERROR: No match for [$org] in alignment 1!!!\n"; 	    	    
	}
    }
    close(UT);
    return 0; 
}

#take a hash with ID & organism, and an aligned fasta,
#return a hash with organism as key & aln seq 
sub alnfasta2hash{
    
    my ($inHash, $afa) = @_;
    
    #parse align
    
    open(AIN, "< $afa");
    my ($id,$org)=('','');
    my %seqs; 
    while(my $ain = <AIN>){
	chomp($ain); 
	if($ain =~ /^>\s*(\S+)/){
	    $id = $1;
	    $org=$inHash->{$id}; 
	}
	else{
	    $seqs{$org} .= $ain; 
	}	
    }
    close(AIN);

    return \%seqs;     
}


#take a filename as input, generate a fasta & align 
sub csv2alnfasta {
    my ($inFile, $outFile) = @_; 
    open(IN, "< $inFile");
    open(UT, "> $outFile" . ".fasta");
    my %entry2org;
    while(my $in = <IN>){
	next if $in =~ /^From/; 
    #  1	From
    #  2	Entry
    #  3	Reviewed
    #  4	Entry Name
    #  5	Protein names
    #  6	Gene Names
    #  7	Organism
    #  8	Length
    #  9	Sequence
    # 10	Taxonomic lineage

	my @in = split(/\t/, $in);
	print UT ">$in[1]\n$in[8]\n";
	
	$entry2org{$in[1]} = $in[6];
	
    }
    close(IN); 
    close(UT);
    
    system("mafft $outFile" . ".fasta > $outFile");
    
    return \%entry2org; 
    
    
}





# ERROR: No match for [Acanthisitta chloris (rifleman)] in alignment 2!
# ERROR: No match for [Adineta ricciae (Rotifer)] in alignment 2!
# ERROR: No match for [Adineta steineri] in alignment 2!
# ERROR: No match for [Aegithalos caudatus (Long-tailed tit) (Acredula caudata)] in alignment 2!
# ERROR: No match for [Alectura lathami (Australian brush turkey)] in alignment 2!
# ERROR: No match for [Amazona guildingii] in alignment 2!
# ERROR: No match for [Anabarilius grahami (Kanglang fish) (Barilius grahami)] in alignment 2!
# ERROR: No match for [Anhinga rufa (African darter)] in alignment 2!
# ERROR: No match for [Antrostomus carolinensis (Chuck-will's-widow) (Caprimulgus carolinensis)] in alignment 2!
# ERROR: No match for [Aptenodytes forsteri (Emperor penguin)] in alignment 2!
# ERROR: No match for [Balaeniceps rex (Shoebill)] in alignment 2!
# ERROR: No match for [Brachionus calyciflorus] in alignment 2!
# ERROR: No match for [Brachionus plicatilis (Marine rotifer) (Brachionus muelleri)] in alignment 2!
# ERROR: No match for [Brachypteracias leptosomus (short-legged ground-roller)] in alignment 2!
# ERROR: No match for [Buceros rhinoceros silvestris] in alignment 2!
# ERROR: No match for [Buphagus erythrorhynchus (red-billed oxpecker)] in alignment 2!
# ERROR: No match for [Calonectris borealis (Cory's shearwater)] in alignment 2!
# ERROR: No match for [Calyptomena viridis (Lesser green broadbill)] in alignment 2!
# ERROR: No match for [Capitella teleta (Polychaete worm)] in alignment 2!
# ERROR: No match for [Cathartes aura (Turkey vulture) (Vultur aura)] in alignment 2!
# ERROR: No match for [Cervus hanglu yarkandensis (Yarkand deer)] in alignment 2!
# ERROR: No match for [Ceyx cyanopectus (Indigo-banded kingfisher)] in alignment 2!
# ERROR: No match for [Chaetops frenatus (Rufous rock-jumper)] in alignment 2!
# ERROR: No match for [Chloropsis cyanopogon] in alignment 2!
# ERROR: No match for [Colius striatus (Speckled mousebird)] in alignment 2!
# ERROR: No match for [Corythaeola cristata (Great blue turaco)] in alignment 2!
# ERROR: No match for [Crassostrea gigas (Pacific oyster) (Crassostrea angulata)] in alignment 2!
# ERROR: No match for [Dibothriocephalus latus (Fish tapeworm) (Diphyllobothrium latum)] in alignment 2!
# ERROR: No match for [Didymodactylos carnosus] in alignment 2!
# ERROR: No match for [Dimorphilus gyrociliatus] in alignment 2!
# ERROR: No match for [Drymodes brunneopygia] in alignment 2!
# ERROR: No match for [Dryoscopus gambensis] in alignment 2!
# ERROR: No match for [Electrophorus electricus (Electric eel) (Gymnotus electricus)] in alignment 2!
# ERROR: No match for [Elysia chlorotica (Eastern emerald elysia) (Sea slug)] in alignment 2!
# ERROR: No match for [Eubucco bourcierii (red-headed barbet)] in alignment 2!
# ERROR: No match for [Fregata magnificens (Magnificent frigatebird)] in alignment 2!
# ERROR: No match for [Fregetta grallaria (White-bellied storm-petrel) (Procellaria grallaria)] in alignment 2!
# ERROR: No match for [Grus americana (Whooping crane)] in alignment 2!
# ERROR: No match for [Helobdella robusta (Californian leech)] in alignment 2!
# ERROR: No match for [Hydatigena taeniaeformis (Feline tapeworm) (Taenia taeniaeformis)] in alignment 2!
# ERROR: No match for [Hymenolepis diminuta (Rat tapeworm)] in alignment 2!
# ERROR: No match for [Hypocryptadius cinnamomeus] in alignment 2!
# ERROR: No match for [Hypsibius dujardini (Water bear) (Macrobiotus dujardini)] in alignment 2!
# ERROR: No match for [Indicator maculatus (spotted honeyguide)] in alignment 2!
# ERROR: No match for [Intoshia linei] in alignment 2!
# ERROR: No match for [Jacana jacana (Wattled jacana)] in alignment 2!
# ERROR: No match for [Larimichthys crocea (Large yellow croaker) (Pseudosciaena crocea)] in alignment 2!
# ERROR: No match for [Lingula unguis] in alignment 2!
# ERROR: No match for [Malurus elegans (Red-winged fairywren)] in alignment 2!
# ERROR: No match for [Mystacornis crossleyi] in alignment 2!
# ERROR: No match for [Neodrepanis coruscans (wattled asity)] in alignment 2!
# ERROR: No match for [Neopipo cinnamomea] in alignment 2!
# ERROR: No match for [Octopus bimaculoides (California two-spotted octopus)] in alignment 2!
# ERROR: No match for [Octopus vulgaris (Common octopus)] in alignment 2!
# ERROR: No match for [Oxylabes madagascariensis (white-throated Oxylabes)] in alignment 2!
# ERROR: No match for [Pandion haliaetus (Osprey) (Falco haliaetus)] in alignment 2!
# ERROR: No match for [Panurus biarmicus (Bearded tit)] in alignment 2!
# ERROR: No match for [Passerina amoena (Lazuli bunting)] in alignment 2!
# ERROR: No match for [Peucedramus taeniatus (Olive warbler)] in alignment 2!
# ERROR: No match for [Phaethon lepturus (White-tailed tropicbird)] in alignment 2!
# ERROR: No match for [Phalacrocorax carbo (Great cormorant) (Pelecanus carbo)] in alignment 2!
# ERROR: No match for [Podargus strigoides (Tawny frogmouth) (Caprimulgus strigoides)] in alignment 2!
# ERROR: No match for [Pomacea canaliculata (Golden apple snail)] in alignment 2!
# ERROR: No match for [Probosciger aterrimus (Palm cockatoo)] in alignment 2!
# ERROR: No match for [Pterocles gutturalis (yellow-throated sandgrouse)] in alignment 2!
# ERROR: No match for [Ramazzottius varieornatus (Water bear) (Tardigrade)] in alignment 2!
# ERROR: No match for [Rhodinocichla rosea] in alignment 2!
# ERROR: No match for [Rodentolepis nana (Dwarf tapeworm) (Hymenolepis nana)] in alignment 2!
# ERROR: No match for [Rotaria magnacalcarata] in alignment 2!
# ERROR: No match for [Rotaria socialis] in alignment 2!
# ERROR: No match for [Rotaria sordida] in alignment 2!
# ERROR: No match for [Rotaria sp. Silwood1] in alignment 2!
# ERROR: No match for [Rotaria sp. Silwood2] in alignment 2!
# ERROR: No match for [Rynchops niger (Black skimmer)] in alignment 2!
# ERROR: No match for [Sagittarius serpentarius (Secretary bird)] in alignment 2!
# ERROR: No match for [Sapayoa aenigma (broad-billed sapayoa)] in alignment 2!
# ERROR: No match for [Schistosoma curassoni] in alignment 2!
# ERROR: No match for [Schistosoma mattheei] in alignment 2!
# ERROR: No match for [Scopus umbretta (Hammerkop)] in alignment 2!
# ERROR: No match for [Semnornis frantzii] in alignment 2!
# ERROR: No match for [Sousa chinensis (Indo-pacific humpbacked dolphin) (Steno chinensis)] in alignment 2!
# ERROR: No match for [Spizaetus tyrannus (black hawk-eagle)] in alignment 2!
# ERROR: No match for [Spizella passerina (Chipping sparrow)] in alignment 2!
# ERROR: No match for [Syrrhaptes paradoxus (Pallas's sandgrouse)] in alignment 2!
# ERROR: No match for [Thalassarche chlororhynchos (Atlantic yellow-nosed albatross) (Diomedea chlororhynchos)] in alignment 2!
# ERROR: No match for [Tichodroma muraria] in alignment 2!
# ERROR: No match for [Todus mexicanus (Puerto Rican tody)] in alignment 2!
# ERROR: No match for [Trichobilharzia regenti (Nasal bird schistosome)] in alignment 2!
# ERROR: No match for [Trogon melanurus (Black-tailed trogon)] in alignment 2!
# ERROR: No match for [Vidua macroura (Pin-tailed whydah)] in alignment 2!
# ERROR: No match for [Apaloderma vittatum (Bar-tailed trogon)] in alignment 1!
# ERROR: No match for [Balaenoptera physalus (Fin whale) (Balaena physalus)] in alignment 1!
# ERROR: No match for [Cariama cristata (Red-legged seriema)] in alignment 1!
# ERROR: No match for [Cervus elaphus hippelaphus (European red deer)] in alignment 1!
# ERROR: No match for [Chlamydotis macqueenii (Macqueen's bustard)] in alignment 1!
# ERROR: No match for [Diceros bicornis minor (South-central black rhinoceros)] in alignment 1!
# ERROR: No match for [Fulmarus glacialis (Northern fulmar)] in alignment 1!
# ERROR: No match for [Mesitornis unicolor (brown roatelo)] in alignment 1!
# ERROR: No match for [Pelecanus crispus (Dalmatian pelican)] in alignment 1!
# ERROR: No match for [Phoenicopterus ruber ruber] in alignment 1!
# ERROR: No match for [Schistosoma margrebowiei] in alignment 1!
# ERROR: No match for [Sparganum proliferum] in alignment 1!
# ERROR: No match for [Taeniopygia guttata (Zebra finch) (Poephila guttata)] in alignment 1!
# END!
# !


    
