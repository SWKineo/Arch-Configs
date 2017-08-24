use strict;
use warnings;
use Text::Trim;

my $triangleCount = 0;
my $notTriangleCount = 0;

local $/ = undef;

my $lines = <>;
my @sides = split(/\s+/, $lines);

print "'".$sides[3]."', '".$sides[4]."'\n";

for (my $i = 1; $i < scalar @sides; $i += 9) {
    for (my $j = 0; $j < 3; $j++) {
        $triangleCount++ if &CheckSides($sides[$i + $j], $sides[$i + $j + 3], $sides[$i + $j + 6]);
    }
}

print "Triangle Count: ".$triangleCount."\n";


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
