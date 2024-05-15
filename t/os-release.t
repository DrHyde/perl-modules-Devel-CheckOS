use warnings;
use strict;
use Test::More;
use Devel::CheckOS::Helpers::LinuxOSrelease 'distributor_id';

Devel::CheckOS::Helpers::LinuxOSrelease::_set_file('t/etc-os-release/ubuntu');
is( distributor_id, 'ubuntu', "can fetch the distribution ID when it's not quoted" );

Devel::CheckOS::Helpers::LinuxOSrelease::_set_file('t/etc-os-release/opensuse-tumbleweed');
is( distributor_id, 'opensuse-tumbleweed', "... and when it is");

done_testing;
