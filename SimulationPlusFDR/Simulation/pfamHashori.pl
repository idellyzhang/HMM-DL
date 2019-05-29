my $fasta_file=shift;

my $fh;
open($fh, $fasta_file) or die "can't open $fasta_file: $!\n";

my %sequence_data;
while (read_fasta_sequence($fh, \%sequence_data)) {
   my @split = split(/\s+/, $sequence_data{header});
   my @split1 = split(/\s+/,$sequence_data{start});
   my @split2 = split(/\s+/,$sequence_data{end});
   my @split3 = split(/\s+/,$sequence_data{domain});
   #my $length = $split1[1]-$split2[0];
   #next if $length < 66;
   my @name = split (/\|/, $split[0]);
   #print ">$sequence_data{header}\n$split1[0]\t$split2[0]\t$split3[0]\t$split4[0]\t$split5[0]\n$split1[1]\t$split2[1]\t$split3[1]\t$split4[1]\t$split5[1]\n";
   #next if ! defined $sequence_data{domain};
   print "$name[1]\t@split1\t@split2\t@split3\n";
   
}

sub read_fasta_sequence {
   my ($fh, $seq_info) = @_;

   $seq_info->{start}=$seq_info->{end}=$seq_info->{domain} = $seq_info->{evalue}  = undef; # clear out previous sequence

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
        
      }         
   }    

   if ($file_not_empty) {
      return $seq_info;
   }    
   else {
      # clean everything up
      $seq_info->{header} = $seq_info->{start}=$seq_info->{end}=$seq_info->{domain} = $seq_info->{evalue} = $seq_info->{next_header} = undef;

      return;   
   }    
}