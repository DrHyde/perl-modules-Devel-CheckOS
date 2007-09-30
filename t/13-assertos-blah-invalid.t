use strict;
$^W = 1;

use lib 't/lib';
use Test::More tests => 1;

eval "use Devel::AssertOS::NotAnOperatingSystem";
ok($@ =~ /OS unsupported/i);
