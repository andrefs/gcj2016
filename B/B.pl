#!/usr/bin/env perl

#PODNAME: cenas.pl

use strict; use warnings;
use Data::Dump qw/dump/;
use feature qw/say/;

my $T = <>;
my $counter;

for(my $t=1; $t<=$T; $t++){
    my $str = <>;
    chomp $str;
    my $pancakes = [split //, $str];
    case($t, $pancakes);
}

sub case {
    my ($t, $pancakes) = @_;
    $counter=0;
    print "Case #$t: ";
    my $finished = 0;
    #printPancakes($pancakes);
    while(not $finished){
        my $last_wrong = -1;
        for(my $i=0; $i<@$pancakes; $i++){
            if($pancakes->[$i] eq '-'){
                $last_wrong = $i;
            }
        }
        if($last_wrong == -1){
            $finished = 1;
        }
        else {
            flip($pancakes, $last_wrong);
        }
    }
    say $counter;
}

sub flip {
    my ($pancakes, $n) = @_;
    for(my $i=0; $i<=$n; $i++){
        $pancakes->[$i] = $pancakes->[$i] eq '-' ? '+' : '-';
    }
    $counter++;
    #print "flipped: ";
    #printPancakes($pancakes);
}

sub printPancakes {
    my ($pancakes) = @_;
    say join '', @$pancakes;
}
