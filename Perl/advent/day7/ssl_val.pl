use strict;
use warnings;

my $supported_count = 0;

while (<>) {
    my $ip = $_;
    print "### $ip";
    
    my $hypernet = "";
    my @aba_codes;
    # Strip hypernet sequences
    $ip =~ s/(\[\w*?\])/$hypernet .= $1;""/eg;
    
    # Check for ABA in supernet
    if ($ip =~ s/(\w)(?=(\w)\g1)/push @aba_codes, [ $1 , $2 ]/eg) {
        foreach (@aba_codes) {
            my $char1 = $_->[0];
            my $char2 = $_->[1];
            print "$char2$char1$char2\n";
            # Check for corresponding BAB in hypernets
            if ($hypernet =~ /$char2$char1$char2/) {
                $supported_count++;
                last;
            } else { print "none\n"; }
        }
    }
}

print "Supported IPs: $supported_count\n";
