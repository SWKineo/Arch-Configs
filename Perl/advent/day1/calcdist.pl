#!/bin/perl
#use strict;
use warnings;

open(INPUT, "<input");

my $rawDirections = <INPUT>;
# print "Enter your directions: ";
# my $rawDirections = <STDIN>;
chomp $rawDirections;
print "'$rawDirections'\n";
my @directions = split /\Q, \E/, $rawDirections;

#####################################################################
# Directions:
# 	0: North
# 	1: East
# 	2: South
# 	3: West
#####################################################################

my $curDir = 0;
my @coords = (0, 0);

foreach my $dist (@directions)
{
	# print $dist."\n";
	if ($dist =~ m/L/) {
		$curDir--;
	} else {
		$curDir++;
	}

	# print "Distance: ".$dist."\n";
	# print "Direction: ".$curDir."\n";

	# Bound the direction between 0 and 3
	$curDir = $curDir < 0 ? $curDir + 4 : 
		  $curDir > 3 ? $curDir - 4 :
		  $curDir;
	# print "Adj Direction: ".$curDir."\n";	
	$dist =~ s/[LR]//;
	# print "Adj Distance: ".$dist."\n";

	if ($curDir == 0) {
		$coords[1] += $dist;
	} elsif ($curDir == 1) {
		$coords[0] += $dist;
	} elsif ($curDir == 2) {
		$coords[1] -= $dist;
	} elsif ($curDir == 3) {
		$coords[0] -= $dist;
	}
}

print "(".$coords[0].", ".$coords[1].")\n";
print "Distance to Easter Bunny Headquarters is ".(abs $coords[0] + abs $coords[1])."\n";
