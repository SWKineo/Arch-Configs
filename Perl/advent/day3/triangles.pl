use strict;
use warnings;
use Text::Trim;

my $sides = undef;

open($sides, '<input.txt');

my $triangleCount = 0;
my $notTriangleCount = 0;

for my $line (<$sides>) {
	if (&CheckTriangle($line)) {
		$triangleCount++;
		#print $triangleCount."\n";
	} else {
		$notTriangleCount++;
	}
}


print "Triangle Count: ".$triangleCount."\n";
print "Not Triangle Count: ".$notTriangleCount."\n";

sub CheckTriangle {
	my $line = trim shift @_;
	my @sides = split(/\s+/, $line);

	return &CheckSides(@sides);	
}

sub CheckSides {
	my @sides = @_;

	## Sum the three sides. If any side makes up more than half of that
	## amount, the sides can't make a triangle.
	
	my $sum = 0;
	
	for my $side (@sides) {
		$sum += $side;
	}

	$sum /= 2;
	
	for my $side (@sides) {
		if ($side >= $sum) {
			#print "Not a triangle! Side ".$side." is bigger than ".$sum."!\n";
			return 0;
		}
	}
	
	#print "'".$line."'\n";	
	#print "That's a triangle!\n";
	return 1;
}
