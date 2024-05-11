use warnings;
use strict;
use Test::More;
use Devel::AssertOS::OSFeatures::Release 'distributor_id';

is( distributor_id(), 'Ubuntu', 'can fetch the correct distribution ID' );

done_testing;
