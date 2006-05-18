# $Id: one.t,v 1.1 2005/01/04 00:36:06 comdog Exp $

use Test::More tests => 3;

use Tie::Cycle;

my @array = qw( A );

tie my $cycle, 'Tie::Cycle', \@array;

is( $cycle, $array[0], "Cycle is first element, iteration 1" );
is( $cycle, $array[0], "Cycle is first element, iteration 2" );
is( $cycle, $array[0], "Cycle is first element, iteration 3" );
