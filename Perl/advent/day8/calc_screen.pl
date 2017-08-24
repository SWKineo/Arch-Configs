use strict;
use warnings;

my ($code_file, $screen_w, $screen_h) = @ARGV;

my $strip_codes;

open($strip_codes, '<' . $code_file);

my @screen;
for (1..$screen_h) {
   my @row;
   for (1..$screen_w) {
       push @row, '.';
   }
   push @screen, \@row;
}

while (readline($strip_codes)) {
    print "\n" . $_;
    if (/rect (\d+)x(\d+)/) {
        &rect(\@screen, $1, $2);
    } elsif (/rotate row y=(\d+) by (\d+)/) {
        &row_rot(\@screen, $1, $2);
    } elsif (/rotate column x=(\d+) by (\d+)/) {
        &col_rot(\@screen, $1, $2);
    }
    
    &print_disp(\@screen);
}

print "\nThere are " . &lit_pixels(\@screen) . " lit pixels on the screen.\n";

sub lit_pixels {
    my $screen = shift;
   
    my $lit_pix = 0;

    for my $row (@$screen) {
        for my $pixel (@$row) {
            if ($pixel eq '#') {
                $lit_pix++;
            }
        }
    }
    
    return $lit_pix;
}

sub print_disp {
    my $screen = shift @_;

    for my $row (@$screen) {
        print join('', @$row) . "\n";
    }
}

sub rect {
    my ($screen, $w, $h) = @_;

    for my $x (0..$w-1) {
        for my $y (0..$h-1) {
            $screen->[$y]->[$x] = '#';
        }
    }
}

sub row_rot {
    my ($screen, $a, $b) = @_;

    my @row_copy = @{$screen->[$a]};

    for (0..$screen_w-1) {
        my $repl_index = ($_ + $b) % $screen_w;
        print "width: $screen_w \t \$repl_index: $repl_index \t \$_: $_ \t \$b: $b \n";
        $screen->[$a]->[$repl_index] = $row_copy[$_];
    }
}

sub col_rot {
    my ($screen, $a, $b) = @_;
    
    my @col_copy;

    for (0..$screen_h-1) {
        push @col_copy, $screen->[$_]->[$a];
    }

    for (0..$screen_h-1) {
        my $repl_index = ($_ + $b) % $screen_h;
        print "height: $screen_h \t \$repl_index: $repl_index \t \$_: $_ \t \$b: $b \n";
        $screen->[$repl_index]->[$a] = $col_copy[$_];
    }
}
