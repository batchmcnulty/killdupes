#!/usr/bin/perl

# little program to kill all the duplicates in a file and echo the result to standard output

my @file_array;
my $line_no = 0;
my $searched_line_no = 0;
my $filename = @ARGV[0];
my @searchresult;
my $lastchar;
my $curr_line;
my @unique_array;
my $curr_value;
my $counter = 0;
my %test_hash;

#my $option = @ARGV[1];

@input = @ARGV;
my $debug_option;
my $tws_option;
my $dupefile_option;
my $loud_option;

print STDERR "\n\n \t  KILLDUPES by Batch McNulty (With thanks to Gabor Szabo) \n";
print STDERR "\n Finally you can properly kill duplicate lines in a text file";
print STDERR " without \n any nonsense about trailing whitespace or the wrong type of CR / LF.";
print STDERR "\n";
if (!@ARGV[0])	{
	print STDERR "\n USAGE: killdupes filename.ext";
	print STDERR "\n\tkilldupes filename.ext > output.txt";
	print STDERR "\n";
	print STDERR "\n  Eliminates all duplicate lines in filename.ext and sends the results to ";
	print STDERR "\n standard output, where you can redirect them to a file or do whatever you ";
	print STDERR "\n like. It is more aggressive than sort -u or uniq because trailing whitespace ";
	print STDERR "\n and mixed Windows/Linux style CRLFs are ignored.";
	print STDERR "\n";

	# These options are still in the program, but I didn't think they'd be any use to you.
	# Feel free to uncomment 'em though.

#	print STDERR "\n killdupes filename.ext -loud  ";
#	print STDERR "\n  Also prints found duplicates to standard error (usually the screen).";
#	print STDERR "\n";
#	print STDERR "\n killdupes filename.txt -dupefile  ";
#	print STDERR "\n  Also prints found duplicates to dupefile.txt.";
#	print STDERR "\n";
#	print STDERR "\n killdupes filename.txt -debug";
#	print STDERR "\n  Also prints debugging information to standard error (Implies -loud).";
#	print STDERR "\n";
#	print STDERR "\n killdupes filename.txt -ignoretws";
#	print STDERR "\n  Ignores trailing whitespace - like sort -u.";

	print STDERR "\n This program is free, but if you want to give me money, my Bitcoin address is: ";
	print STDERR "\n  1NYnGXRS4ZzNzmHu5Hsrqx169D7k7qBcYy " ;
	die "\n\nThis program requires you to enter a filename as a rider\n\n";
}
print STDERR "\n Opening $filename for killdupe... \n";

@input_matches = grep { /-ignoretws/ } @input;
$tws_option = $input_matches[0];

@input_matches = grep { /-debug/ } @input;
$debug_option = $input_matches[0];


@input_matches = grep { /-dupefile/ } @input;
$dupefile_option = $input_matches[0];

@input_matches = grep { /-loud/ } @input;
$loud_option = $input_matches[0];



if ($tws_option eq "-ignoretws")	{
	print STDERR "Ignoring trailing whitespace (seeking duplicates less agressively)";
}

open (FH, $filename) or die "\n\n Looks like you pointed me to a file that doesn't exist or is corrupt.\n\n";
while (<FH>)	{
	$curr_line = $_;
	chomp $curr_line;
	chomp $curr_line;
	unless ($tws_option eq "-ignoretws")	{
		$curr_line =~ s/\s+$//;	# With thanks to Perlmaven.com's Gabor Szabo (https://perlmaven.com/trim)
	}
	@file_array[$line_no] = $curr_line;
	$line_no ++;
}
$last_array_entry = $line_no;
$line_no = 0;
############ debugging ############
if ($debug_option eq "-debug")	{
	print STDERR "OK, so here's the file array:";
	print STDERR "\n_____________________________________\n";
	print STDERR @file_array;
	print STDERR "\n";
	print STDERR "Trailing whitespaces and cr/lfs have been removed.";
	print STDERR "Now it's time to eliminate those duplicates";

	print STDERR "lenght of file array:";

	print STDERR $#file_array;
	print STDERR "test hash (shld be empty):";
	print STDERR join ",", keys %test_hash;
	print STDERR ".";
	print  STDERR "\n\n About to process file array...\n";
}


################## /debugging ##############

# Removed trailing whitespace and cr /lf nonsense
# Now to remove duplicate lines!


######### Funny story - thanks to a programming error, I thought this code was faulty, #######
#### but it was my mistake. Fixed now ########

foreach my $curr_value (@file_array)	{
	if ($debug_option eq "-debug")	{print STDERR "\n curr value:$curr_value.";}	# debugging
	if (! $test_hash{$curr_value})	{
		push @unique_array, $curr_value;
		$test_hash{$curr_value} = 1;
	}
	else	{
		if ($dupefile_option !~ "dupefile")	{
			print STDERR "\n DUPE FOUND! $curr_value.";# my mistake
		}
		elsif ($dupefile_option eq "-dupefile")	{
			print STDERR "Storing dupes in dupefile...";
			open (FH, ">>dupefile.txt") or die "Shit! Couldn't open dupefile!";
			printf (FH "$curr_value\n");
			close (FH);
		}
	}
}
### debugging
if ($debug_option eq "-debug")	{
	print STDERR "\n\n Test hash:";
	print STDERR join ",", keys %test_hash;
	print STDERR "\n";
	print STDERR "\n Unique array is now ready!\n";
}
### /debugging
# Credit for the above code is also due to Gabor Szabo
# https://perlmaven.com/unique-values-in-an-array-in-perl

print join "\n",@unique_array;
print STDERR "\n";
print STDERR "\n\n All done! Please Bitcoin me at: 1NYnGXRS4ZzNzmHu5Hsrqx169D7k7qBcYy \n\n";

