use strict;
use warnings;
use Time::HiRes qw(usleep);


my $sector_id_sum = 0;
my $vf = undef;
open($vf, "+>valid_codes");

while (<>) {
    $sector_id_sum += &check_name($_);
    usleep(1000);
}

print "\n\n\nThe sum of the valid sector IDs is " . $sector_id_sum . "\n\n\n\n";



sub check_name {
    my $encrypted_code = shift @_;
    
    # Split the code into three chunks
    $encrypted_code =~ /([a-zA-Z-]+)(\d+)\[(\w+)\]/;

    my $name = $1;
    my $id = $2;
    my $checksum = $3;
    my %char;
   

    # Count characters into a hash of occurences
    $name =~ s/([a-z])/$char{$1}++;$1/eg;
    
    my $expected_sum = "";
    
    # Sort keys alphabetically, then by occurences
    my @sorted_hash_keys = sort { $char{$b} <=> $char{$a} } sort keys %char;

    for (my $i = 0; $i < 5; $i++) {
        $expected_sum .= $sorted_hash_keys[$i];
    }

    if ($expected_sum eq $checksum) {
        print $name . " :: " . $id . " :: " . $checksum;
        my $d_name = &decrypt_name($name . $id);
        print "\n^~~~> " . $d_name . " \n";
        print $vf $name . $id . "\n";
        print $vf "^~~~> " . $d_name . "\n";
        return $id;
    }
    
    return 0;
}

sub decrypt_name {
    my $name = shift @_;
 
    # Strip code
    $name =~ s/(\d+)//;
    my $code = $1;
 
    # Replace dashes with spaces
    $name =~ s/\-/ /g;

    # Rotate letters

    $name =~ s/(\w)/&rotate_letter($1, $code)/eg;
   
    return $name;
}

sub rotate_letter {
    my ($letter, $code) = @_;

    my $rotated_ord = (ord($letter) - 97 + $code) % 26 + 97;

    return chr($rotated_ord);
}
