#!/usr/bin/perl

use strict;
use warnings;


my $fasta_file=shift;

my $fh;
open($fh, $fasta_file) or die "can't open $fasta_file: $!\n";

my %sequence_data;
while (read_fasta_sequence($fh, \%sequence_data)) {
   my @split = split(/\s+/,$sequence_data{end});
   my @split1 = split(/\s+/,$sequence_data{start});
   my @split2 = split(/\s+/,$sequence_data{domain});
   my @split3 = split(/\s+/,$sequence_data{score});
   my @split4 = split(/\s+/,$sequence_data{evalue});
   my @sorted_index = sort {$split1[$a] <=> $split1[$b]} 0..$#split;
   my @sorted_start = @split1[@sorted_index];
   my @sorted_end = @split[@sorted_index];
   my @sorted_domain = @split2[@sorted_index];
   my @sorted_score = @split3[@sorted_index];
   my @sorted_evalue = @split4[@sorted_index];
   print ">$sequence_data{header}\n";
   foreach my $i (0..$#sorted_domain){
   print "$sorted_start[$i]\t$sorted_end[$i]\t$sorted_domain[$i]\t$sorted_evalue[$i]\t$sorted_score[$i]\n";
}
 
}

sub read_fasta_sequence {
   my ($fh, $seq_info) = @_;

   $seq_info->{start}=$seq_info->{end}=$seq_info->{domain} =$seq_info->{evalue}  =$seq_info->{score} = undef; # clear out previous sequence

   # put the header into place
   $seq_info->{header} = $seq_info->{next_header} if $seq_info->{next_header};

   my $file_not_empty = 0; 
   while (<$fh>) {
      $file_not_empty = 1;
      next if /^\s*$/;  # skip blank lines
      chomp;    

      if (/^>/) { # fasta header line
         my $h = $_;    
         $h =~ s/^>//;  
         if ($seq_info->{header}) {
            $seq_info->{next_header} = $h;
            return $seq_info;   
         }              
         else { # first time through only
            $seq_info->{header} = $h;
         }              
      }         
      else {    
         #s/\s+//;  # remove any white space
         my @split = split(/\s+/,$_);
         $seq_info->{start} .= $split[0]. " ";
         $seq_info->{end} .= $split[1]. " ";
         $seq_info->{domain} .= $split[2]. " ";
         $seq_info->{evalue} .= $split[3]. " ";
         $seq_info->{score} .= $split[4]. " ";
      }         
   }    

   if ($file_not_empty) {
      return $seq_info;
   }    
   else {
      # clean everything up
      $seq_info->{header} = $seq_info->{start}=$seq_info->{end}=$seq_info->{domain} = $seq_info->{evalue}  = $seq_info->{score}= $seq_info->{next_header} = undef;

      return;   
   }    
}
