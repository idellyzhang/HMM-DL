use strict;
use warnings;
use Data::Dumper;
$Data::Dumper::Sortkeys=1;

open (FILE,$ARGV[0]) or die "Can't open '$ARGV[0]': $!";

my %data;
my $total_domain;
#my ($total_E, $total_L, $total_M, $total_S);

while (<FILE>) {
    ++$total_domain;
    #code
}
print "$total_domain\n";

#for my $k (sort keys %data) {

  #printf "%s  %s\n", $k, join ' ', $data{$k};
#}

close(FILE);

