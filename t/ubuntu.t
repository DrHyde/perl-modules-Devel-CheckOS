use warnings;
use strict;
use Test::More;
use Devel::AssertOS::Ubuntu::LSB 'distributor_id';

SKIP: {
    skip 'Not running on Ubuntu-like', 1 unless ( -r '/etc/lsb-release' );
    is( distributor_id(), 'Ubuntu', 'can fetch the correct distributor ID' );
}

done_testing;
