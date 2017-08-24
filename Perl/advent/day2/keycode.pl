use strict;
use warnings;


open(CODE, "<input");

print &ParseCode."\n";

sub ParseCode {
	my $code = "";
	my $curKey = 5;
	
	for my $line (<CODE>) {
		$curKey = &ParseLine($line, $curKey);
		$code .= $curKey;
	}

	return $code
}

sub ParseLine {
	my ($codeLine, $prevKey) = @_;
	for my $dir (split(//, $codeLine)) {
		my $tempKey = $prevKey;
		if ($dir eq "U") {
			$tempKey -= 3;
		} elsif ($dir eq "D") {
			$tempKey += 3;
		} elsif ($dir eq "L") {
			unless ($prevKey == 4 or $prevKey == 7) {
				$tempKey -= 1;
			}
		} elsif ($dir eq "R") {
			unless ($prevKey == 6 or $prevKey == 3) {
				$tempKey += 1;
			}
		}
		
		unless ($tempKey > 9 or $tempKey < 1) {
			$prevKey = $tempKey;
		}
	}

	return $prevKey;
}
