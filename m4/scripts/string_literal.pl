#!/usr/bin/perl

# NOTE: This script is intended for gdmarp script.
# Usage : <Script path> <String>
# What this script does :
# First, find all occurences of starting /# and ending #/
# second, replace all "," "`" "'" into escaped characters

use warnings;
use strict;

# Subroutine to convert all unallowed characters to escaped ones
sub escape{
	print "BEGIN\n";
	my $s;
	$s=shift;
	# Escpae characters
	$s=~s/,/\\\./g;
	$s=~s/`/\\~/g;
	$s=~s/'/\\;/g;
	# Remove string literal directives
	$s=~s/\/\#|\#\///g;
	print "END\n";
	$s
}

# This sets line ending as none, thus reading the whole given data without
# stopping.
local $/;
# First find match lines that begin with /$ and end widh $/
# After that apply subroutin escape to the matched
while(<>) {
	$_ =~ s/(\/\#.*?\#\/)/escape$&/ges;
	print $_
}
