# $Id: cycle.t,v 1.1 2002/12/17 18:31:29 comdog Exp $

use Test::More tests => 6;

use Tie::Toggle;

tie my $toggle, 'Tie::Toggle';

foreach( 0 .. 2 )
	{
	is( $toggle, '', "Toggle is false, iteration $_" );
	is( $toggle, 1, "Toggle is true, iteration $_" );
	}
