# $Id: cycle.t,v 1.2 2002/12/17 20:19:16 comdog Exp $

use Test::More tests => 9;

use Tie::Cycle;

my @array = qw( A B C );

tie my $cycle, 'Tie::Cycle', \@array;

foreach( 0 .. 2 )
	{
	is( $cycle, $array[0], "Cycle is first element, iteration $_" );
	is( $cycle, $array[1], "Cycle is second element, iteration $_" );
	is( $cycle, $array[2], "Cycle is third element, iteration $_" );
	}
