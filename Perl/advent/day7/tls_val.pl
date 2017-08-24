use strict;
use warnings;

my $supported_count = 0;

while (<>) {
    my $ip = $_;
    print "### $ip";
    
    # Strip the hypertext sequences
    # Disqualify ip if ABBA is inside brackets
    unless ($ip =~ /\[(?=\w*?(?=(\w)(?!\g1)(\w)\g2\g1)\w*?\])/) {
        print "*** Passed hypernet check ";
        if ($ip =~ /(\w)(?!\g1)(\w)\g2\g1/) {
            print "::: Passed ABBA check ***\n";
            $supported_count++;
        } else { print "***\n"; }
    }
}

print "Supported IPs: $supported_count\n";
