# $Id: test.pl,v 1.2 2002/08/14 23:13:14 comdog Exp $
# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

######################### We start with some black magic to print on failure.

# Change 1..1 below to 1..last_test_to_print .
# (It may become useful if the test is moved to ./t subdirectory.)

BEGIN { $| = 1; print "1..8\n"; }
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

#test 6: can we reset the iterator?
eval {
my @cycle = qw(a b c d e f g);

tie my $cycle, 'Tie::Cycle', \@cycle;

die "Cycle not reset" unless $cycle eq $cycle[0];
die "Cycle not reset" unless $cycle eq $cycle[1];
die "Cycle not reset" unless $cycle eq $cycle[2];

(tied $cycle)->reset;

die "Cycle not reset" unless $cycle eq $cycle[0];
die "Cycle not reset" unless $cycle eq $cycle[1];

(tied $cycle)->reset;

die "Cycle not reset" unless $cycle eq $cycle[0];

print "ok 6\n";
};
if( $@ ) { print "not ok 6\n$@\n" }

#test 7: can we see the previous thing?
eval {
my @cycle = qw(a b c d e f g);

tie my $cycle, 'Tie::Cycle', \@cycle;

die "Next element wrong at start"     unless (tied $cycle)->previous eq $cycle[-1];
my $foo = $cycle;
die "Next element wrong after first"  unless (tied $cycle)->previous eq $cycle[0];
my $foo = $cycle;
die "Next element wrong after second" unless (tied $cycle)->previous eq $cycle[1];

print "ok 7\n";
};
if( $@ ) { print "not ok 7\n$@\n" }

#test 8: can we see the next thing?
eval {
my @cycle = qw(a b c d e f g);

tie my $cycle, 'Tie::Cycle', \@cycle;

die "Next element wrong at start"     unless (tied $cycle)->next eq $cycle[1];
my $foo = $cycle;
die "Next element wrong after first"  unless (tied $cycle)->next eq $cycle[2];
my $foo = $cycle;
die "Next element wrong after second" unless (tied $cycle)->next eq $cycle[3];

print "ok 8\n";
};
if( $@ ) { print "not ok 8\n$@\n" }

