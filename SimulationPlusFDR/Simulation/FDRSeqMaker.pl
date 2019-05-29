use List::Util qw(shuffle);
my $fasta_file=shift;

my $fh;
open($fh, $fasta_file) or die "can't open $fasta_file: $!\n";

my %sequence = do {
    open my $fh1, '<', 'EcoliSeqHash.txt';
    #open my $fh1, '<', \ "A 20.68\nB 17.5\nC 15.6\nD 20.6\nE 27.6\n";
    map {chomp; split ' ', $_, 2} <$fh1>;
};


my %sequence_data;
while (read_fasta_sequence($fh, \%sequence_data) ) {
   my @split1 = split(/\s+/,$sequence_data{start});
   my @split2 = split(/\s+/,$sequence_data{end});
   my @split3 = split(/\s+/,$sequence_data{domain});
   my @split6 = split(/\s+/,$sequence_data{header});
   #my $length = $split1[1]-$split2[0];
  
   #next if $length < 66;
   #print ">$sequence_data{header}\n$split1[0]\t$split2[0]\t$split3[0]\t$split4[0]\t$split5[0]\n$split1[1]\t$split2[1]\t$split3[1]\t$split4[1]\t$split5[1]\n";
   #next if ! defined $sequence_data{domain};
   next if $#split3 < 1;
   #my $newseq = $sequence{$sequence_data{header}}  
   #print ">$sequence_data{header}\n$sequence{$split6[0]}\n";
  foreach my $i (0 .. $#split3){
   my $oldSeq = $sequence{$split6[0]};
   my @name = split (/\|/, $split6[0]);
   my @domain1;
   
   if ($i eq 0) {
      $domain = substr($sequence{$split6[0]}, 0, $split1[$i+1]);
       @domain1 =  split //, $domain;
         
    for ($j=0 ; $j <20 ; ++$j)
  {
    @permut = shuffle @domain1;
   my $perm = join ('', @permut);
   #print "$mutant\n";
   #print WRITE "$mutant\n";
   substr($oldSeq , 0, $split1[$i+1],$perm);
   my $k = $i + 1;
   my $l = $j + 1;
   #my @display_name = split /|/,$split6[0];
   print ">$name[1]-$k-$l\n$oldSeq\n";
   #print ">$i\n";
   #print "$seq\n";
  #print WRITE "$seq\n";
  }
   }
    elsif ($i eq $#split3){
      $domain = substr($sequence{$split6[0]}, $split2[$i-1], $split6[1]-$split2[$i-1]);
      @domain1 =  split //, $domain;  
     
 for ($j=0 ; $j <20 ; ++$j)
  {
    @permut = shuffle @domain1;
   my $perm = join ('', @permut);
   #print "$mutant\n";
   #print WRITE "$mutant\n";
   substr($oldSeq , $split2[$i-1], $split6[1]-$split2[$i-1],$perm);
   my $k = $i + 1;
   my $l = $j + 1;
  #my @display_name = split /|/,$split6[0];
   print ">$name[1]-$k-$l\n$oldSeq\n";
   #print ">$i\n";
   #print "$seq\n";
  #print WRITE "$seq\n";
  }
   }   
   else{
    $domain = substr($sequence{$split6[0]}, $split2[$i-1], $split1[$i+1]-$split2[$i-1]);
    @domain1 =  split //, $domain;
      
 for ($j=0 ; $j <20 ; ++$j)
  {
    @permut = shuffle @domain1;
   my $perm = join ('', @permut);
   #print "$mutant\n";
   #print WRITE "$mutant\n";
   substr($oldSeq , $split2[$i-1], $split1[$i+1]-$split2[$i-1],$perm);
   my $k = $i + 1;
   my $l = $j + 1;
   #my @display_name = split /|/,$split6[0];
   print ">$name[1]-$k-$l\n$oldSeq\n";
   #print ">$i\n";
   #print "$seq\n";
  #print WRITE "$seq\n";
  }
   }
  
  
   }
   }



#$seq_obj = $catchseq_seqio_obj->next_seq;     #   return a sequence
#$display_name = $seq_obj->display_name;      #  the name of sequence
#$desc = $seq_obj->desc;                                #   the description of sequence
#$seq = $seq_obj->seq;                                   #   the sequence
#$seq_type = $seq_obj->alphabet;                    #   determining the type of sequences (DNA or protein)
#$seq_length = $seq_obj->length;                    #   the length of sequence
#print "$seq\n";
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