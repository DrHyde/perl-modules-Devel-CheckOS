use warnings;
use strict;
use Test::More;
use Devel::AssertOS::OSFeatures::Release 'distributor_id';

my $total_tests = 3;
plan tests => $total_tests;

SKIP: {
    skip 'Not a Linux distribution', $total_tests unless ( $^O eq 'linux' );
    my $id = distributor_id();
    ok( $id, 'can fetch the distribution ID' )
      or BAIL_OUT('No use to keep testing with ID = undef');
    like $id, qr/^\w+$/, 'ID looks like a string';
    my $copy = ucfirst( lc $id );
    is( $id, $copy, 'ID is returned with first character in uppercase' );
}
