# $Id: Makefile.PL,v 1.7 2004/09/03 00:52:46 comdog Exp $
use ExtUtils::MakeMaker;

eval "use Test::Manifest";

unless( $@ )
	{
	* ExtUtils::MM_Any::test_via_harness = sub
		{
		my($self, $perl, $tests) = @_;
		
		return qq|\t$perl "-MTest::Manifest" | .
			qq|"-e" "run_t_manifest(\$(TEST_VERBOSE), '\$(INST_LIB)', | .
			qq|'\$(INST_ARCHLIB)')"\n|;
		}
	}

WriteMakefile(
	'NAME'          => 'Tie::Cycle',
	'VERSION_FROM'  => 'Cycle.pm',
 
	'PREREQ_PM'		=> {
		'Test::More'       => '0',
    },
    
	'MAN3PODS'      => {
    	'Cycle.pm'  => '$(INST_MAN3DIR)/Tie::Cycle.3',
    	},

	'clean' => { FILES => 'Tie-Cycle-*' },
);
