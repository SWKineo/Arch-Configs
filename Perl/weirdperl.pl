#!/usr/bin/perl
sub TestParams
{
	my $range = (100000000000000000);

	my $random = int(rand($range));
	

	print $random."\n";
}

&TestParams;

