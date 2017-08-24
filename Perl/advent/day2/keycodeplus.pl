use strict;
use warnings;


open(CODE, "<input");

our %conversion = (
	1 => "1",
	5 => "2",
	6 => "3",
	7 => "4",
	9 => "5",
	10 => "6",
	11 => "7",
	12 => "8",
	13 => "9",
	15 => "A",
	16 => "B",
	17 => "C",
	21 => "D",
);

print &ParseCode."\n";


sub ParseCode {
	my $code = "";
	my $curKey = 9;
	
	for my $line (<CODE>) {
		$curKey = &ParseLine($line, $curKey);
		$code .= $conversion{$curKey};
	}

	return $code
}

sub ParseLine {
	my ($codeLine, $prevKey) = @_;
	for my $dir (split(//, $codeLine)) {
		my $tempKey = $prevKey;
		if ($dir eq "U") {
			$tempKey -= 5;
		} elsif ($dir eq "D") {
			$tempKey += 5;
		} elsif ($dir eq "L") {
			$tempKey -= 1;
		} elsif ($dir eq "R") {
			$tempKey += 1;	
		}
		
		if (exists $conversion{$tempKey}) {
			$prevKey = $tempKey;
		}
	}

	return $prevKey;
}
