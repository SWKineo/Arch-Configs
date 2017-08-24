use strict;
use warnings;

my @indices;

while (<>) {
    for (my $i = 0; $i < length $_; $i++) {
        my $char = substr($_, $i, 1);
        $indices[$i]->{$char}++ unless $char eq "\n";
    }
}

print "Your error corrected message is ";

for my $freq (@indices) {
    my @sortedKeys = sort { $freq->{$a} <=> $freq->{$b} } keys %$freq;
    print $sortedKeys[0];
}

print "\n";
