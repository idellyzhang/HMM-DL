my %score1 = do {
    open my $fh1, '<', 'GAseq.txt';
    #open my $fh1, '<', \ "A 20.68\nB 17.5\nC 15.6\nD 20.6\nE 27.6\n";
    map {chomp; split ' ', $_, 2} <$fh1>;
};

my $fasta_file=shift;

my $fh;

open($fh, $fasta_file) or die "can't open $fasta_file: $!\n";

my %sequence_data;
while (read_fasta_sequence($fh, \%sequence_data)) {
   my @split1 = split(/\s+/,$sequence_data{start});
   my @split2 = split(/\s+/,$sequence_data{end});
   my @split3 = split(/\s+/,$sequence_data{domain});
   my @split4 = split(/\s+/,$sequence_data{evalue});
   my @split5 = split(/\s+/,$sequence_data{score});
   #next if $length < 66;
   #print ">$sequence_data{header}\n$split1[0]\t$split2[0]\t$split3[0]\t$split4[0]\t$split5[0]\n$split1[1]\t$split2[1]\t$split3[1]\t$split4[1]\t$split5[1]\n";
   #next if ! defined $sequence_data{domain};
   print ">$sequence_data{header}\n";
   my %hash;
foreach my $i (0..$#split3) {
   push @{$hash{$split3[$i]}}, $split5[$i];
   
}


foreach my $i (0..$#split3){
   #print "**$x\n";
   my $sum = eval join '+', @{$hash{$split3[$i]}};
 print "$split1[$i]\t$split2[$i]\t$split3[$i]\n" if $sum > $score1{$split3[$i]};
   #print "$x:@{$hash{$x}}\n";

#next if $j == 1;
}

  }
 


sub read_fasta_sequence {
   my ($fh, $seq_info) = @_;

   $seq_info->{start}=$seq_info->{end}=$seq_info->{domain} =$seq_info->{evalue}=$seq_info->{score} = undef; # clear out previous sequence

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
      $seq_info->{header} = $seq_info->{start}=$seq_info->{end}=$seq_info->{domain} =$seq_info->{evalue}=$seq_info->{score}= $seq_info->{next_header} = undef;

      return;   
   }    
}