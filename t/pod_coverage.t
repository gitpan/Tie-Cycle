# $Id: pod_coverage.t 1569 2005-03-08 22:29:30Z comdog $

use Test::More;
eval "use Test::Pod::Coverage";

if( $@ )
	{
	plan skip_all => "Test::Pod::Coverage required for testing POD";
	}
else
	{
	plan tests => 1;

	pod_coverage_ok( "Tie::Cycle",
		{ trustme => [ qr/^[A-Z_]+$/ ] }
		);      
	}
