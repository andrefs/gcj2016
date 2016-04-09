#!/usr/bin/env perl 

#PODNAME: cenas.pl

use strict; use warnings;
use Data::Dump qw/dump/;
use feature qw/say/;


my $T = <>;


for(my $t=1; $t<=$T; $t++){
    my $n = <>;
    case($t, $n);
}

sub case {
    my ($t, $n) = @_;
    my $digits = [qw/0 1 2 3 4 5 6 7 8 9/];

    if($n == 0){
        say "Case #$t: INSOMNIA";
        return;
    }


    my $left = '0123456789';
    my $i = 0;
    my $number;

    while($left ne 'xxxxxxxxxx'){
        $i++;
        $number = $i*$n;

        foreach my $d (@$digits){
            $left =~ s/$d/x/
                if $number =~ /$d/;
        }
    }

    say "Case #$t: $number";
}

sub replace {
    my ($number, $left) = @_;

}
