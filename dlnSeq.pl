#!/usr/bin/perl

use strict;
use warnings;

my %score1 = do {
    open my $fh1, '<', 'DomainDepScore.txt';
    #open my $fh1, '<', \ "A 20.68\nB 17.5\nC 15.6\nD 20.6\nE 27.6\n";
    map {chomp; split ' ', $_, 2} <$fh1>;
};

my %score2 = do {
    open my $fh1, '<', 'LinkerScore.txt';
    #open my $fh1, '<', \ "A 20.68\nB 17.5\nC 15.6\nD 20.6\nE 27.6\n";
    map {chomp; split ' ', $_, 2} <$fh1>;
};

my $fasta_file=shift;

my $fh;
open($fh, $fasta_file) or die "can't open $fasta_file: $!\n";

my %sequence_data;
while (read_fasta_sequence($fh, \%sequence_data)) {
   my @split = split(/\s+/,$sequence_data{end});
   my @split1 = split(/\s+/,$sequence_data{start});
   my @split2 = split(/\s+/,$sequence_data{domain});
   my @split3 = split(/\s+/,$sequence_data{score});
   my @sorted_index = sort {$split[$a] <=> $split[$b]} 0..$#split;
   my @sorted_start = @split1[@sorted_index];
   my @sorted_end = @split[@sorted_index];
   my @sorted_domain = @split2[@sorted_index];
   my @sorted_score = @split3[@sorted_index];
   print ">$sequence_data{header}\n";
   #print "$sorted_domain[2]\n";
   #print ">$sequence_data{header}\n@sorted_start\n@sorted_end\n@sorted_domain\n@sorted_score\n";
            my (@sd, @sds, @nsd,@ss, @se,@ds, @nss,@nse,@nds);
            my ($i, $j);
             $sd[0] = [$sorted_domain[0]];
             $sds[0] = $sorted_score[0];
            push @{$sd[0]}, $sds[0];
            $ss[0] = [$sorted_start[0]];
            $se[0] = [$sorted_end[0]];
            $ds[0] = [$sorted_score[0]];
            print "@{$sd[0]}&@{$ss[0]}&@{$se[0]}&@{$ds[0]}\n";

            #print "$nsd[0][0]\n";
            #print "@{$sd[0]}\n";
            #my $score = pop $sd[0];
            #print "$sd[0][1]\n";
            my $max_score;
            #print "$#sorted_domain\n";

   foreach   $i (1 .. $#sorted_domain){
            $sd[0] = [$sorted_domain[0]];
            $sds[0] = $sorted_score[0];
            push @{$sd[0]}, $sds[0];
            @{$nsd[0]} = @{$sd[0]};
            $ss[0] = [$sorted_start[0]];
            $se[0] = [$sorted_end[0]];
            $ds[0] = [$sorted_score[0]];
            @{$nss[0]} = @{$ss[0]};
            @{$nse[0]} = @{$se[0]};
            @{$nds[0]} = @{$ds[0]};
      $max_score = 0;
      #my @tmp;
      for (  $j = 0; $j < $i; $j++) {
        #print "haha @{$nsd[$j]}  pre-pre $j\n";
        my $score = pop @{$nsd[$j]};
      #print "nsdj = @{$nsd[$j]} j=$j score = $score\n";
      #print "$sd[$j][1]\n";
      #print "$sorted_domain[$j]\n";
        my $pair = join("&", $sorted_domain[$j], $sorted_domain[$i]);
        #print "$pair\n";
        my $length = $sorted_start[$i] - $sorted_end[$j];
        my $newscore;
        my @score3 = split(/\s+/,$score2{$pair}) if exists $score2{$pair};
        if (exists $score1{$pair}){
          if ($length > 85) {
            $newscore = $score + $score1{$pair} + $score3[0];
        }elsif($length > 34){
            $newscore = $score + $score1{$pair} + $score3[1];
        }elsif($length > 12){
            $newscore = $score + $score1{$pair} + $score3[2];
        }else{
            $newscore = $score + $score1{$pair} + $score3[3];
        }
         #$newscore = $score + $score1{$pair} ;
        }
        else{
         $newscore = $score;
        }
         #print "@{$sd[$j]} $score pre $j\n";
        #print "$newscore\n";
       if ($sorted_end[$j] < $sorted_start[$i] && $newscore > $max_score) {
         $max_score = $newscore;
        # print "@{$nsd[$j]} before $j\n";
         @{$sd[$j]} = @{$nsd[$j]};
         @{$ss[$j]} = @{$nss[$j]};
         @{$se[$j]} = @{$nse[$j]};
         @{$ds[$j]} = @{$nds[$j]};
         my $nnscore = $sorted_score[$i]+$max_score;
          #pop @{$sd[$i]};
          #print "@{$sd[$j]}, haha \n";
         push @{$sd[$j]}, $sorted_domain[$i];
         push @{$sd[$j]}, $nnscore;
         push @{$ss[$j]}, $sorted_start[$i];
         push @{$se[$j]}, $sorted_end[$i];
         push @{$ds[$j]}, $sorted_score[$i];
         #print "&&&&&&&&&&&&&&&&  snp = @{$sd[$j]} j= $j i = $i &&&&&&&&&&&&&&&&&&&&&&\n";
         @{$sd[$i]} = @{$sd[$j]};
         @{$ss[$i]} = @{$ss[$j]};
         @{$se[$i]} = @{$se[$j]};
         @{$ds[$i]} = @{$ds[$j]};
         }
       
      
       #else{
         #$sd[$i] = [$sorted_domain[$i]];
         #push @{$sd[$i]}, $sorted_score[$i];
      #print "@{$nsd[$j]}, pop j = $j score = $score\n";
        push @{$nsd[$j]}, $score;

       #print "@{$nsd[$j]}, pop j = $j\n";
       #print "@{$nsd[0]}000000000000000000\n";
      }
        
         
         #@{$sd[$i]} = @tmp;
         
         #print "@{$sd[$i]}, haha \n";
         
      unless (exists $sd[$i]){
        $sd[$i] = [$sorted_domain[$i]];
        push @{$sd[$i]}, $sorted_score[$i];
        $ss[$i] = [$sorted_start[$i]];
        $se[$i] = [$sorted_end[$i]];
        $ds[$i] = [$sorted_score[$i]];
      }
      
       @{$nsd[$i]} = @{$sd[$i]};
        @{$nss[$i]} = @{$ss[$i]};
       @{$nse[$i]} = @{$se[$i]};
       @{$nds[$i]} = @{$ds[$i]};
       print "@{$sd[$i]}&@{$ss[$i]}&@{$se[$i]}&@{$ds[$i]}\n";
        #print "*******************s0 = @{$nsd[0]}, s1 = @{$nsd[1]}, s2 = @{$nsd[2]}, s3 = @{$nsd[3]} ********************\n";
   }
               #$nsd[$i] = $sd[$i];
               #print "lastnsd = $nsd[$i] i = $i \n";
 
 
}

sub read_fasta_sequence {
   my ($fh, $seq_info) = @_;

   $seq_info->{start}=$seq_info->{end}=$seq_info->{domain} = $seq_info->{evalue} =$seq_info->{score} = undef; # clear out previous sequence

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
      $seq_info->{header} = $seq_info->{start}=$seq_info->{end}=$seq_info->{domain} = $seq_info->{evalue} = $seq_info->{score}= $seq_info->{next_header} = undef;

      return;   
   }    
}
