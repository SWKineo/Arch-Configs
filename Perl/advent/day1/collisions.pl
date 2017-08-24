use strict;
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
my @previous = ("0.0");
my @firstCollision;

foreach my $dist (@directions)
{
	print $dist." - ";
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
	print "Facing ".$curDir.":\n";
	$dist =~ s/[LR]//;
	# print "Adj Distance: ".$dist."\n";

	if ($curDir == 0) {
		&move(1, 1, $dist);
	} elsif ($curDir == 1) {
		&move(0, 1, $dist);
	} elsif ($curDir == 2) {
		&move(1, -1, $dist);
	} elsif ($curDir == 3) {
		&move(0, -1, $dist);
	}
}

print "(".$coords[0].", ".$coords[1].")\n";
print "Distance to Easter Bunny Headquarters is ".((abs $coords[0]) + (abs $coords[1]))."\n";

## Use
# $axis 0: x
# $axis 1: y
# $direction = 1: positive
# $direction = -1: negative
# $dist is always positive
sub move {
	my($axis, $direction, $dist) = @_;
	for my $i (0..$dist - 1) {
		$coords[$axis] += $direction;
		my $coordConverted = $coords[0].".".$coords[1];
		print $coordConverted."\n";
		if ($coordConverted ~~ @previous) {
			print "Collision found at (".$coords[0].", ".$coords[1].")!\n";
			print "Distance from start is ".((abs $coords[0]) + (abs $coords[1]))."\n";
			exit 0;
		}
		
		push(@previous, $coordConverted);
	}
}	
