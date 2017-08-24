use strict;
use warnings;
use Digest::MD5 qw(md5_hex);

print "Enter the door ID: ";
my $door_id = <STDIN>;
chomp $door_id;

print "\nThe password is " . &door_pass($door_id) . "\n";


sub door_pass {
    my $id = shift @_;
   
    my $password = "";
    my $p_counter = 0;
    my $index = 0;

    while ($p_counter < 8) {
        my $hash = md5_hex($id, $index);
        if ($hash =~ /^00000([1-9a-f])/) {
            print "Match found at " . $id . $index . "! $hash\n";
            $password .= $1;
            print "New password is $password\n";
            $p_counter++;
        }

        $index++;
    }

    return $password;
}

