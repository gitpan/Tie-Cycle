# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

######################### We start with some black magic to print on failure.

# Change 1..1 below to 1..last_test_to_print .
# (It may become useful if the test is moved to ./t subdirectory.)

BEGIN { $| = 1; print "1..5\n"; }
END {print "not ok 1\n" unless $loaded;}
use Tie::Cycle;
$loaded = 1;
print "ok 1\n";

######################### End of black magic.

# Insert your test code below (better if it prints "ok 13"
# (correspondingly "not ok 13") depending on the success of chunk 13
# of the test code):

#test 2: is the list stored and acccessed correctly?
#test 3: does it cycle?
{
my @cycle = qw( joey sammy frank dean );

tie my $cycle, 'Tie::Cycle', \@cycle;

my $sum = 0;
foreach my $rat ( @cycle )
	{
	$sum++ if $cycle = $rat
	}

print $sum == @cycle ? "ok" : "not ok", " 2\n";

print $cycle eq $cycle[0] ? "ok" : "not ok", " 3\n";
}

#test 4: does the shallow copy work?
eval {
my @cycle = qw( joey sammy frank dean );
my @copy  = @cycle;

tie my $cycle, 'Tie::Cycle', \@cycle;

$cycle[0] = 'fred';

my $next = $cycle;
	
print "not " unless( $next eq $copy[0] and $next ne $cycle[0] );
print "ok 4\n";
};
if( $@ ) { print "not ok 4\n$@\n" }

#test 5: does deep copy (unimplemented) work? (obviously no)
eval {
my( $a, $b, $c ) = map { my $x = [$_, $_] } 0 .. 2;
my @cycle = ( $a, $b, $c );

tie my $cycle, 'Tie::Cycle', \@cycle;

my $next = $cycle;
$sum++ if ref $next;
$sum++ if $next->[0] == $a->[0];
$sum++ if $next->[1] == $a->[1];
 
$b->[1]++;

$next = $cycle;
$sum++ if $next->[0] == $b->[0];
$sum++ if $next->[1] == $b->[1];

print "not " unless $sum == 5;
print "ok 5\n";
};
if( $@ ) { print "not ok 5\n$@\n" }
