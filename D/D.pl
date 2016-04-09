#!/usr/bin/env perl 

#PODNAME: cenas.pl

use strict; use warnings;
use Data::Dump qw/dump/;
use feature qw/say/;
use POSIX;


my $T = <>;


for(my $t=1; $t<=$T; $t++){
    my ($k, $c, $s) = split /\s+/,<>;
    #say "Case #$t: ".case($k, $c, $s);
    case($t, $k, $c, $s);
}

sub case {
    my ($t, $k, $c, $s) = @_;
    my $needed = ceil($k/$c);

    print "Case #$t:";

    if($needed > $s){
        say " IMPOSSIBLE";
        return;
    }

    my $nums = [0..($k-1)];

    while(@$nums){
        my $iterNums = [];
        my $iterSize = (scalar @$nums, $c)[scalar @$nums > $c]; #min
        #dump(['nums, c, iterSize ',scalar @$nums, $c, $iterSize]);
        for(my $i=0; $i<$iterSize; $i++){
            push @$iterNums, shift @$nums;
        }


        my $res = 1;
        for(my $i=0; $i<@$iterNums; $i++){
            my $j = @$iterNums-$i-1;
            $res += ($iterNums->[$j])*$k**$i;

            #say "(n[$j])*k^$i\t".($iterNums->[$j])."*$k^$i";
        }
        print " $res";
    }

    print "\n";
}

__END__

my $k = shift @ARGV;
my $nums = [];
push @$nums, $_ foreach @ARGV;

my $res = 1;

dump($nums);
for(my $i=0; $i<@$nums; $i++){
    my $j = @$nums-$i-1;
    $res += ($nums->[$j]-1)*$k**$i;

    say "(n[$j]-1)*k^$i\t".($nums->[$j]-1)."*$k^$i";
}
say $res;



__END__

my ($k, $c) = @ARGV;
my $res = genSeqs($k, $c);
printSeqs($res->{seqs},$res->{complex});
printGcolumns($res->{complex}, $k);


sub genSeqs {
    my ($k, $c) = @_;
    my $baseSeq = '_' x $k;
    my $seqs = [];
    for(my $i=0; $i<$k;$i++){
        my $seq = $baseSeq;
        $seq =~ s/^(.{$i})./$1G/;
        push @$seqs, $seq;
    }
    my $complex = [map { genComplex($_, $c-1); } @$seqs];
    return {seqs => $seqs, complex => $complex};
}

sub genComplex {
    my ($seq, $c) = @_;
    my $originalSeq = $seq;
    my $Gs = 'G' x length($originalSeq);
    for(my $i=0; $i<$c; $i++){
        my $newSeq = '';
        my $seqArray = [split //, $seq];
        foreach my $char (@$seqArray){
            $newSeq .= $char eq '_' ? $originalSeq : $Gs;
        }
        $seq = $newSeq;
    }
    return $seq;
}

sub printSeqs {
    my ($seqs, $complex) = @_;
    for my $seq (@$seqs){
        say map { formatStr($_) } (split //, $seq); 
    }
    say "";
    say map { formatStr($_) } (1..length($complex->[0]));
    say "";
    for my $c (@$complex){
        say map { formatStr($_) } (split //, $c); 
    }
}

sub printGcolumns {
    my ($complex, $numGs) = @_;
    my $seqLen = length($complex->[0]);
    my $complexArray = [];
    foreach(@$complex){
        push @$complexArray, [(split //, $_)];
    }
    for(my $i=0; $i<$seqLen; $i++){
        my $allGs = 1;
        foreach my $c (@$complexArray){
            $allGs = 0 if $c->[$i] ne 'G';
        }
        if($allGs){
            print (($i+1)," ");
        }
    }
    print "\n";
}

sub formatStr {
    my ($str) = @_;
    return sprintf("%-2s|", $str);
}
