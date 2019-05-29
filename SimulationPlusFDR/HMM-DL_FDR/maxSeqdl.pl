use strict;
use warnings;
use autodie;

my %score1 = do {
    open my $fh1, '<', 'GAdomain.txt';
    #open my $fh1, '<', \ "A 20.68\nB 17.5\nC 15.6\nD 20.6\nE 27.6\n";
    map {chomp; split ' ', $_, 2} <$fh1>;
};

my %score2 = do {
    open my $fh1, '<', 'DomainDepScore.txt';
    #open my $fh1, '<', \ "A 20.68\nB 17.5\nC 15.6\nD 20.6\nE 27.6\n";
    map {chomp; split ' ', $_, 2} <$fh1>;
};

my %score3 = do {
    open my $fh1, '<', 'LinkerScore.txt';
    #open my $fh1, '<', \ "A 20.68\nB 17.5\nC 15.6\nD 20.6\nE 27.6\n";
    map {chomp; split ' ', $_, 2} <$fh1>;
};

open (FILE,$ARGV[0]) or die "Can't open '$ARGV[0]': $!";



my ($max_score, $max_combination,$max_start, $max_end,$max_dscore,@split, @split1, @split2,@split3, $split4);
while (<FILE>) {
    if (/^>/) {
        if ($max_combination && $max_start && $max_end && $max_dscore && $max_score>0) {
           @split = split(/\s+/,$max_combination);
            @split1 = split(/\s+/,$max_start);
            @split2 = split(/\s+/,$max_end);
            @split3 = split(/\s+/,$max_dscore);
            #@split4 = split(/\s+/,$max_score);
            #my $sum = eval join '+', @split3;
            #my $diff = ($max_score-$sum)/($#split+1);
            if ($#split>0) {
            foreach my $i (0..$#split){
            my ($pair,$pair1,$newscore,$length,$length1);
            #my $length = $split1[$i] - $split2[$i-1];
            if ($i==0) {
                $pair = join("&", $split[0], $split[1]);
                $length = $split1[1] - $split2[0];
                my @score4 = split(/\s+/,$score3{$pair}) if exists $score3{$pair};
                if (exists $score2{$pair}){
                              if ($length > 85) {
            $newscore = $split3[0] + $score1{$split[0]} + $score2{$pair}/2 + $score4[0]/2;
        }elsif($length > 34){
            $newscore = $split3[0] + $score1{$split[0]} + $score2{$pair}/2 + $score4[1]/2;
        }elsif($length > 12){
           $newscore = $split3[0] + $score1{$split[0]} + $score2{$pair}/2 + $score4[2]/2;
        }else{
            $newscore = $split3[0] + $score1{$split[0]} + $score2{$pair}/2 + $score4[3]/2;
        }
                #$newscore = $split3[0] + $score1{$split[0]} + $score2{$pair}/2;
                }#if exists $score1{$split[0]} && $score2{$pair};
                else{$newscore = $split3[0] + $score1{$split[0]};}
                print "$split1[0]\t$split2[0]\t$split[0]\t$split3[0]\t$newscore\n";
                }
            
            elsif(0 < $i && $i < $#split){
                $pair = join("&", $split[$i-1], $split[$i]);
                $pair1 = join("&", $split[$i], $split[$i+1]);
                $length = $split1[$i] - $split2[$i-1];
                my @score4 = split(/\s+/,$score3{$pair}) if exists $score3{$pair};
                my @score5 = split(/\s+/,$score3{$pair1}) if exists $score3{$pair1};
                $length1 = $split1[$i+1] - $split2[$i];
                if (exists $score2{$pair} && $score2{$pair1} ) {
                    if ($length > 85) {
                        if ($length1 > 85) {
            $newscore = $split3[$i] + $score1{$split[$i]} + $score2{$pair}/2 + $score2{$pair1}/2 + $score4[0]/2 + $score5[0]/2;
        }elsif($length1 > 34){
            $newscore = $split3[$i] + $score1{$split[$i]} + $score2{$pair}/2 + $score2{$pair1}/2 + $score4[0]/2 + $score5[1]/2;
        }elsif($length1 > 12){
           $newscore = $split3[$i] + $score1{$split[$i]} + $score2{$pair}/2 + $score2{$pair1}/2 + $score4[0]/2 + $score5[2]/2;
        }else{
            $newscore = $split3[$i] + $score1{$split[$i]} + $score2{$pair}/2 + $score2{$pair1}/2 + $score4[0]/2 + $score5[3]/2;
        }
            #$newscore = $split3[0] + $score1{$split[0]} + $score2{$pair}/2 + $score4[0]/2;
        }elsif($length > 34){
                                  if ($length1 > 85) {
            $newscore = $split3[$i] + $score1{$split[$i]} + $score2{$pair}/2 + $score2{$pair1}/2 + $score4[1]/2 + $score5[0]/2;
        }elsif($length1 > 34){
            $newscore = $split3[$i] + $score1{$split[$i]} + $score2{$pair}/2 + $score2{$pair1}/2 + $score4[1]/2 + $score5[1]/2;
        }elsif($length1 > 12){
           $newscore = $split3[$i] + $score1{$split[$i]} + $score2{$pair}/2 + $score2{$pair1}/2 + $score4[1]/2 + $score5[2]/2;
        }else{
            $newscore = $split3[$i] + $score1{$split[$i]} + $score2{$pair}/2 + $score2{$pair1}/2 + $score4[1]/2 + $score5[3]/2;
        }
            #$newscore = $split3[0] + $score1{$split[0]} + $score2{$pair}/2 + $score4[1]/2;
        }elsif($length > 12){
        if ($length1 > 85) {
            $newscore = $split3[$i] + $score1{$split[$i]} + $score2{$pair}/2 + $score2{$pair1}/2 + $score4[2]/2 + $score5[0]/2;
        }elsif($length1 > 34){
            $newscore = $split3[$i] + $score1{$split[$i]} + $score2{$pair}/2 + $score2{$pair1}/2 + $score4[2]/2 + $score5[1]/2;
        }elsif($length1 > 12){
           $newscore = $split3[$i] + $score1{$split[$i]} + $score2{$pair}/2 + $score2{$pair1}/2 + $score4[2]/2 + $score5[2]/2;
        }else{
            $newscore = $split3[$i] + $score1{$split[$i]} + $score2{$pair}/2 + $score2{$pair1}/2 + $score4[2]/2 + $score5[3]/2;
        }
           #$newscore = $split3[0] + $score1{$split[0]} + $score2{$pair}/2 + $score4[2]/2;
        }else{
            if ($length1 > 85) {
            $newscore = $split3[$i] + $score1{$split[$i]} + $score2{$pair}/2 + $score2{$pair1}/2 + $score4[3]/2 + $score5[0]/2;
        }elsif($length1 > 34){
            $newscore = $split3[$i] + $score1{$split[$i]} + $score2{$pair}/2 + $score2{$pair1}/2 + $score4[3]/2 + $score5[1]/2;
        }elsif($length1 > 12){
           $newscore = $split3[$i] + $score1{$split[$i]} + $score2{$pair}/2 + $score2{$pair1}/2 + $score4[3]/2 + $score5[2]/2;
        }else{
            $newscore = $split3[$i] + $score1{$split[$i]} + $score2{$pair}/2 + $score2{$pair1}/2 + $score4[3]/2 + $score5[3]/2;
        }
            #$newscore = $split3[0] + $score1{$split[0]} + $score2{$pair}/2 + $score4[3]/2;
        }
                    #$newscore = $split3[$i] + $score1{$split[$i]} + $score2{$pair}/2 + $score2{$pair1}/2;
                }
                elsif(exists $score2{$pair} && ! exists $score2{$pair1}){
                    if ($length > 85) {
            $newscore = $split3[$i] + $score1{$split[$i]} + $score2{$pair}/2 + $score4[3]/2 ;
        }elsif($length > 34){
            $newscore = $split3[$i] + $score1{$split[$i]} + $score2{$pair}/2 + $score4[3]/2 ;
        }elsif($length > 12){
           $newscore = $split3[$i] + $score1{$split[$i]} + $score2{$pair}/2 + $score4[3]/2 ;
        }else{
            $newscore = $split3[$i] + $score1{$split[$i]} + $score2{$pair}/2 + $score4[3]/2;
        }
                    #$newscore = $split3[$i] + $score1{$split[$i]} + $score2{$pair}/2;
                }
                elsif(! exists $score2{$pair} && exists $score2{$pair1}){
                    if ($length1 > 85) {
            $newscore = $split3[$i] + $score1{$split[$i]} + $score2{$pair1}/2  + $score5[0]/2;
        }elsif($length1 > 34){
            $newscore = $split3[$i] + $score1{$split[$i]} + $score2{$pair1}/2  + $score5[1]/2;
        }elsif($length1 > 12){
           $newscore = $split3[$i] + $score1{$split[$i]} + $score2{$pair1}/2  + $score5[2]/2;
        }else{
            $newscore = $split3[$i] + $score1{$split[$i]} + $score2{$pair1}/2  + $score5[3]/2;
        }
                    #$newscore = $split3[$i] + $score1{$split[$i]} + $score2{$pair1}/2;
                }
                else{$newscore = $split3[$i] + $score1{$split[$i]};}
                
                 #if exists $score1{$split[$i]} && $score2{$pair} && $score2{$pair1};
                print "$split1[$i]\t$split2[$i]\t$split[$i]\t$split3[$i]\t$newscore\n";
            }
            else{
                $pair = join("&", $split[$#split-1], $split[$#split]);
                $length = $split1[$#split] - $split2[$#split-1];
                my @score4 = split(/\s+/,$score3{$pair}) if exists $score3{$pair};
                if (exists $score2{$pair}){
                              if ($length > 85) {
            $newscore = $split3[$#split] + $score1{$split[$#split]} + $score2{$pair}/2 + $score4[0]/2;
        }elsif($length > 34){
            $newscore = $split3[$#split] + $score1{$split[$#split]} + $score2{$pair}/2 + $score4[1]/2;
        }elsif($length > 12){
           $newscore = $split3[$#split] + $score1{$split[$#split]} + $score2{$pair}/2 + $score4[2]/2;
        }else{
            $newscore = $split3[$#split] + $score1{$split[$#split]} + $score2{$pair}/2 + $score4[3]/2;
        }
                #$newscore = $split3[$#split] + $score1{$split[$#split]} + $score2{$pair}/2;
                }#if exists $score1{$split[0]} && $score2{$pair};
                else{$newscore = $split3[$#split] + $score1{$split[$#split]};}
                print "$split1[$#split]\t$split2[$#split]\t$split[$#split]\t$split3[$#split]\t$newscore\n";
            }
            
        } 
            }
            else{
                my $newscore;
                $newscore = $split3[0] + $score1{$split[0]};
                print "$split1[0]\t$split2[0]\t$split[0]\t$split3[0]\t$newscore\n";
                }
            
            
  
            
            
            
            #my $newscore = $split3[$i] + $score1{$split[$i]} + $diff if exists $score1{$split[$i]};
    #print "$split1[$i]\t$split2[$i]\t$split[$i]\t$split3[$i]\t$newscore\n"}
    #print "$max_combination\t$max_score\t$max_start\t$max_end\n";
        }

        print;
        
        $max_score = 0;

    } elsif (my ($combination, $score, $start,$end,$dscore) = /(.*)\s+([0-9.]+)\&(.*)\&(.*)\&(.*)/) {
        if ($score > $max_score) {
            $max_score = $score;
            $max_combination = $combination;
            $max_start = $start;
            $max_end = $end;
            $max_dscore = $dscore;
            @split = split(/\s+/,$combination);
            @split1 = split(/\s+/,$start);
            @split2 = split(/\s+/,$end);
            @split3 = split(/\s+/,$dscore);
            $split4 = $score;
        }
    }
    
}
    

#print "$max_score\n";
  #my $sum1 = eval join '+', @split3;
  #my $diff1 = ($split4-$sum1)/($#split+1);
      if ($#split>0) {
            foreach my $i (0..$#split){
            my ($pair,$pair1,$newscore,$length,$length1);
            #my $length = $split1[$i] - $split2[$i-1];
            if ($i==0) {
                $pair = join("&", $split[0], $split[1]);
                $length = $split1[1] - $split2[0];
                my @score4 = split(/\s+/,$score3{$pair}) if exists $score3{$pair};
                if (exists $score2{$pair}){
                              if ($length > 85) {
            $newscore = $split3[0] + $score1{$split[0]} + $score2{$pair}/2 + $score4[0]/2;
        }elsif($length > 34){
            $newscore = $split3[0] + $score1{$split[0]} + $score2{$pair}/2 + $score4[1]/2;
        }elsif($length > 12){
           $newscore = $split3[0] + $score1{$split[0]} + $score2{$pair}/2 + $score4[2]/2;
        }else{
            $newscore = $split3[0] + $score1{$split[0]} + $score2{$pair}/2 + $score4[3]/2;
        }
                #$newscore = $split3[0] + $score1{$split[0]} + $score2{$pair}/2;
                }#if exists $score1{$split[0]} && $score2{$pair};
                else{$newscore = $split3[0] + $score1{$split[0]};}
                print "$split1[0]\t$split2[0]\t$split[0]\t$split3[0]\t$newscore\n";
                }
            
            elsif(0 < $i && $i < $#split){
                $pair = join("&", $split[$i-1], $split[$i]);
                $pair1 = join("&", $split[$i], $split[$i+1]);
                $length = $split1[$i] - $split2[$i-1];
                my @score4 = split(/\s+/,$score3{$pair}) if exists $score3{$pair};
                my @score5 = split(/\s+/,$score3{$pair1}) if exists $score3{$pair1};
                $length1 = $split1[$i+1] - $split2[$i];
                if (exists $score2{$pair} && $score2{$pair1} ) {
                    if ($length > 85) {
                        if ($length1 > 85) {
            $newscore = $split3[$i] + $score1{$split[$i]} + $score2{$pair}/2 + $score2{$pair1}/2 + $score4[0]/2 + $score5[0]/2;
        }elsif($length1 > 34){
            $newscore = $split3[$i] + $score1{$split[$i]} + $score2{$pair}/2 + $score2{$pair1}/2 + $score4[0]/2 + $score5[1]/2;
        }elsif($length1 > 12){
           $newscore = $split3[$i] + $score1{$split[$i]} + $score2{$pair}/2 + $score2{$pair1}/2 + $score4[0]/2 + $score5[2]/2;
        }else{
            $newscore = $split3[$i] + $score1{$split[$i]} + $score2{$pair}/2 + $score2{$pair1}/2 + $score4[0]/2 + $score5[3]/2;
        }
            #$newscore = $split3[0] + $score1{$split[0]} + $score2{$pair}/2 + $score4[0]/2;
        }elsif($length > 34){
                                  if ($length1 > 85) {
            $newscore = $split3[$i] + $score1{$split[$i]} + $score2{$pair}/2 + $score2{$pair1}/2 + $score4[1]/2 + $score5[0]/2;
        }elsif($length1 > 34){
            $newscore = $split3[$i] + $score1{$split[$i]} + $score2{$pair}/2 + $score2{$pair1}/2 + $score4[1]/2 + $score5[1]/2;
        }elsif($length1 > 12){
           $newscore = $split3[$i] + $score1{$split[$i]} + $score2{$pair}/2 + $score2{$pair1}/2 + $score4[1]/2 + $score5[2]/2;
        }else{
            $newscore = $split3[$i] + $score1{$split[$i]} + $score2{$pair}/2 + $score2{$pair1}/2 + $score4[1]/2 + $score5[3]/2;
        }
            #$newscore = $split3[0] + $score1{$split[0]} + $score2{$pair}/2 + $score4[1]/2;
        }elsif($length > 12){
        if ($length1 > 85) {
            $newscore = $split3[$i] + $score1{$split[$i]} + $score2{$pair}/2 + $score2{$pair1}/2 + $score4[2]/2 + $score5[0]/2;
        }elsif($length1 > 34){
            $newscore = $split3[$i] + $score1{$split[$i]} + $score2{$pair}/2 + $score2{$pair1}/2 + $score4[2]/2 + $score5[1]/2;
        }elsif($length1 > 12){
           $newscore = $split3[$i] + $score1{$split[$i]} + $score2{$pair}/2 + $score2{$pair1}/2 + $score4[2]/2 + $score5[2]/2;
        }else{
            $newscore = $split3[$i] + $score1{$split[$i]} + $score2{$pair}/2 + $score2{$pair1}/2 + $score4[2]/2 + $score5[3]/2;
        }
           #$newscore = $split3[0] + $score1{$split[0]} + $score2{$pair}/2 + $score4[2]/2;
        }else{
            if ($length1 > 85) {
            $newscore = $split3[$i] + $score1{$split[$i]} + $score2{$pair}/2 + $score2{$pair1}/2 + $score4[3]/2 + $score5[0]/2;
        }elsif($length1 > 34){
            $newscore = $split3[$i] + $score1{$split[$i]} + $score2{$pair}/2 + $score2{$pair1}/2 + $score4[3]/2 + $score5[1]/2;
        }elsif($length1 > 12){
           $newscore = $split3[$i] + $score1{$split[$i]} + $score2{$pair}/2 + $score2{$pair1}/2 + $score4[3]/2 + $score5[2]/2;
        }else{
            $newscore = $split3[$i] + $score1{$split[$i]} + $score2{$pair}/2 + $score2{$pair1}/2 + $score4[3]/2 + $score5[3]/2;
        }
            #$newscore = $split3[0] + $score1{$split[0]} + $score2{$pair}/2 + $score4[3]/2;
        }
                    #$newscore = $split3[$i] + $score1{$split[$i]} + $score2{$pair}/2 + $score2{$pair1}/2;
                }
                elsif(exists $score2{$pair} && ! exists $score2{$pair1}){
                    if ($length > 85) {
            $newscore = $split3[$i] + $score1{$split[$i]} + $score2{$pair}/2 + $score4[3]/2 ;
        }elsif($length > 34){
            $newscore = $split3[$i] + $score1{$split[$i]} + $score2{$pair}/2 + $score4[3]/2 ;
        }elsif($length > 12){
           $newscore = $split3[$i] + $score1{$split[$i]} + $score2{$pair}/2 + $score4[3]/2 ;
        }else{
            $newscore = $split3[$i] + $score1{$split[$i]} + $score2{$pair}/2 + $score4[3]/2;
        }
                    #$newscore = $split3[$i] + $score1{$split[$i]} + $score2{$pair}/2;
                }
                elsif(! exists $score2{$pair} && exists $score2{$pair1}){
                    if ($length1 > 85) {
            $newscore = $split3[$i] + $score1{$split[$i]} + $score2{$pair1}/2  + $score5[0]/2;
        }elsif($length1 > 34){
            $newscore = $split3[$i] + $score1{$split[$i]} + $score2{$pair1}/2  + $score5[1]/2;
        }elsif($length1 > 12){
           $newscore = $split3[$i] + $score1{$split[$i]} + $score2{$pair1}/2  + $score5[2]/2;
        }else{
            $newscore = $split3[$i] + $score1{$split[$i]} + $score2{$pair1}/2  + $score5[3]/2;
        }
                    #$newscore = $split3[$i] + $score1{$split[$i]} + $score2{$pair1}/2;
                }
                else{$newscore = $split3[$i] + $score1{$split[$i]};}
                
                 #if exists $score1{$split[$i]} && $score2{$pair} && $score2{$pair1};
                print "$split1[$i]\t$split2[$i]\t$split[$i]\t$split3[$i]\t$newscore\n";
            }
            else{
                $pair = join("&", $split[$#split-1], $split[$#split]);
                $length = $split1[$#split] - $split2[$#split-1];
                my @score4 = split(/\s+/,$score3{$pair}) if exists $score3{$pair};
                if (exists $score2{$pair}){
                              if ($length > 85) {
            $newscore = $split3[$#split] + $score1{$split[$#split]} + $score2{$pair}/2 + $score4[0]/2;
        }elsif($length > 34){
            $newscore = $split3[$#split] + $score1{$split[$#split]} + $score2{$pair}/2 + $score4[1]/2;
        }elsif($length > 12){
           $newscore = $split3[$#split] + $score1{$split[$#split]} + $score2{$pair}/2 + $score4[2]/2;
        }else{
            $newscore = $split3[$#split] + $score1{$split[$#split]} + $score2{$pair}/2 + $score4[3]/2;
        }
                #$newscore = $split3[$#split] + $score1{$split[$#split]} + $score2{$pair}/2;
                }#if exists $score1{$split[0]} && $score2{$pair};
                else{$newscore = $split3[$#split] + $score1{$split[$#split]};}
                print "$split1[$#split]\t$split2[$#split]\t$split[$#split]\t$split3[$#split]\t$newscore\n";
            }
            
        } 
            }
            else{
                my $newscore;
                $newscore = $split3[0] + $score1{$split[0]};
                print "$split1[0]\t$split2[0]\t$split[0]\t$split3[0]\t$newscore\n";
                }
            
    
    #print "$max_combination\t$max_score\t$max_start\t$max_end\n";

#print "$max_combination $max_score\n";

close(FILE);
