package Tie::Cycle;

require 5.6.0;
use strict;
use warnings;

our $VERSION = 0.01;

sub TIESCALAR
	{
	my $class    = shift;
	my $list_ref = shift;

	my @shallow_copy = map { $_ } @$list_ref;

	return unless ref $list_ref eq ref [];
	return unless @$list_ref > 1;

	my $self = [ 0, scalar @shallow_copy, \@shallow_copy ];

	bless $self, $class;
	}

sub FETCH
	{
	my $self = shift;
	
        my $index = $$self[0]++;
        $$self[0] %= $self->[1];

	return $self->[2]->[ $index ];
	}

sub STORE
	{
	my $self = shift;
	my $list_ref = shift;

        return unless ref $list_ref eq ref [];
        return unless @$list_ref > 1;

        $self = [ 0, scalar @$list_ref, $list_ref ];
	}

"Tie::Cycle";

__END__

=pod

=head1 NAME

Tie::Cycle - Cycle through a list of values via a scalar.

=head1 SYNOPSIS

    use Tie::Cycle;

    tie my $cycle, 'Tie::Cycle', [ qw( FFFFFF 000000 FFFF00 ) ];

	print $cycle; # FFFFFF
	print $cycle; # 000000
	print $cycle; # FFFF00
	print $cycle; # FFFFFF  back to the beginning    

=head1 DESCRIPTION

You use C<Tie::Cycle> to go through a list over and over again.
Once you get to the end of the list, you go back to the beginning.
You don't have to worry about any of this since the magic of
tie does that for you.

The tie takes an array reference as its third argument.  The tie
should succeed unless the argument is not an array reference or
the referenced array contains less than two elements.

During the tie, this module makes a shallow copy of the array
reference.  If the array reference contains references, and those
references are changed after the tie, the elements of the cycle
will change as well. See the included test.pl script for an
example of this effect.

=head1 AUTHOR

brian d foy <brian+cpan@smithrenaud.com>.

=head1 COPYRIGHT and LICENSE

Copyright 2000 by brian d foy.

This software is available under the same terms as perl.

=cut

