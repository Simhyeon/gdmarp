# SOURCE : https://stackoverflow.com/questions/546433/regular-expression-to-match-balanced-parentheses
# Now this "regular expression recursion is god sent... holy moly"

use strict;
sub purge{
	# Set variable
	my $s;
	$s=shift;
	my $mode = $ENV{"PURGEMODE"};
	if ($mode eq "ALL") {
		# Remove all variable macros
		$s=~s/\bv_[\w]*\(([^()]|(?R))*\)//g;
		# Remove all internal macros
		$s=~s/\bm_[\w]*\(([^()]|(?R))*\)//g;
		# Remove all user macros
		$s=~s/\b_[\w]*\(([^()]|(?R))*\)//g;
	}
	elsif ($mode eq "USER") {
		# Remove all user macros
		$s=~s/\b_[\w]*\(([^()]|(?R))*\)//g;
	}
	elsif ($mode eq "VAR") {
		# Remove all variable macros
		$s=~s/\bv_[\w]*\(([^()]|(?R))*\)//g;
	}
	$s
}

# This sets line ending as none, thus reading the whole given data without
# stopping.
local $/;

while(<>) {
	print purge $_
}
