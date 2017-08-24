use strict;
use warnings;
use Digest::MD5 qw(md5_hex);

print "Enter the door ID: ";
my $door_id = <STDIN>;
chomp $door_id;

print "\nThe password is " . &door_pass($door_id) . "\n";


sub door_pass {
    my $id = shift @_;
   
    my @password = qw(_ _ _ _ _ _ _ _);
    my $p_counter = 0;
    my $index = 0;

    while ($p_counter < 8) {
        my $hash = md5_hex($id, $index);
        if ($hash =~ /^00000([0-7])([0-9a-f])/) {
            print "Match found at " . $id . $index . "! $hash\n";
            if ($password[$1] eq '_') {
                $password[$1] = $2;
                print "New password is " . join('', @password) . "\n";
                $p_counter++;
            }
        }

        $index++;
    }

    return join('', @password);
}

