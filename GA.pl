use strict;
use warnings;
use autodie;

my %score1 = do {
    open my $fh1, '<', 'GAdomain.txt';
    #open my $fh1, '<', \ "A 20.68\nB 17.5\nC 15.6\nD 20.6\nE 27.6\n";
    map {chomp; split ' ', $_, 2} <$fh1>;
};


open (FILE,$ARGV[0]) or die "Can't open '$ARGV[0]': $!";
#open my $fh2, '<', '9nn.xdom';
#open my $fh2, '<', \ "C   16.7\nX   2.9\nE   7.0\nA   15.2";

while (<FILE>) {
    chomp;
    if (/^>/) {
        print "$_\n";#code
    }
    else{
    my ($start,$end, $key, $evalue, $score) = split ' ';
    printf "%s %s %s %s %s\n", $start,$end, $key,$evalue, $score - $score1{$key} if exists $score1{$key};
    }
}

close(FILE);