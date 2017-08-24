#! /usr/bin/perl

@dir = `ls ~/`;
print @dir;

$string = "This t \n should be on a new line\n";
chomp $string;
print $string . "\n";
