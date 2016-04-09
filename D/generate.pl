#!/usr/bin/env perl 

#PODNAME: cenas.pl

use strict; use warnings;
use Data::Dump qw/dump/;
use feature qw/say/;


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
