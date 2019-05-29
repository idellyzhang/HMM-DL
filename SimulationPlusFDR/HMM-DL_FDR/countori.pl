#!/usr/bin/perl

use strict;
use warnings;


open (FILE,$ARGV[0]) or die "Can't open '$ARGV[0]': $!";
 while (<FILE>) {
     chomp;
      next if /^>/;
      my @split = split(/\s+/,$_);
   my $domain = $split[2];
   print "$domain\n";
 }
 close (FILE);