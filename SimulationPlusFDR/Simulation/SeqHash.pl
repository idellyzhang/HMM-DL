# This script can be used to Mutate a protein sequence.
# This script randomly mutates the protein sequence with non-multiple hits
# While executing this script it asks for the file name of the protein sequence

use Bio::SeqIO;
use  Bio::Seq; 
use File::Path;

use List::Util qw(shuffle);

# Open a file of protein sequences
my $proteinfile = $ARGV[0];

$catchseq_seqio_obj = Bio::SeqIO->new(-file=>"$proteinfile", -format=>'fasta');   #  Open a file in fasta format?
while (my $seq_obj = $catchseq_seqio_obj->next_seq) {
  my  $display_name = $seq_obj->display_name;
 my $seq = $seq_obj->seq;
 my $seq_length = $seq_obj->length;

 print "$display_name\t$seq\n";
}

#$seq_obj = $catchseq_seqio_obj->next_seq;     #   return a sequence
#$display_name = $seq_obj->display_name;      #  the name of sequence
#$desc = $seq_obj->desc;                                #   the description of sequence
#$seq = $seq_obj->seq;                                   #   the sequence
#$seq_type = $seq_obj->alphabet;                    #   determining the type of sequences (DNA or protein)
#$seq_length = $seq_obj->length;                    #   the length of sequence
#print "$seq\n";
exit;