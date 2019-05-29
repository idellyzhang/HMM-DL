#!/usr/bin/perl -w
use strict;

# To use this script you need to have run HMMSEARCH or 
# HMMSCAN with this option
# --domtblout domains.out
# hmmsearch-3.0b3 --domtblout domains.out HMMFILE PROTEINFILE > PROTEIN-vs-HMMFILE.hmmsearch3
#
# hmmsearch-3.0b3 --domtblout Sugar_tr.crypto.domains.out Sugar_tr.hmm Cryptoproteins.pep > Cryptoproteins-vs-Sugar_tr.hmmsearch3

# the domtblout file is what you provide to this script!
# to run this you do
# perl hmmer3_extract_domains -i Sugar_tr.crypto.domains.out -db Cryptoproteins.pep 
# when it is done you will have a file called Sugar_tr.domains.out.Sugar_tr.domains.fa

#use Getopt::Long;
#use Bio::SeqIO;
#use Bio::Seq;

my ($tablefile,$dir,$database);

open (FILE,$ARGV[0]) or die "Can't open '$ARGV[0]': $!";
my %seen;
while(<FILE>) {
    next if (/^\#/);
    chomp;
    my ($target,$tacc,$tlen,
        $query,$qacc,$qlen,
        $evalue,$score,$bias,
        $n, $total, $cevalue,$ievalue,
        $domscore,$dombias,
        $hmmstart, $hmmend,
        $targetstart,$targetend,
        $envstart,$envend,
        $acc, $description) = split(/\s+/,$_,23);
    push @{$seen{$query}}, "$targetstart\t$targetend\t$target\t$ievalue\t$domscore";
#print "$query\n";
}


for my $q ( keys %seen ) {
    print ">$q\n";
foreach my $i(0..$#{$seen{$q}}){
print "$seen{$q}[$i]\n";}
}

close(FILE);
	

