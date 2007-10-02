use strict;
$^W = 1;

use File::Spec;
use lib File::Spec->catdir(qw(t lib));

use Test::More tests => 1;

eval "use Devel::AssertOS::NotAnOperatingSystem";
ok($@ =~ /OS unsupported/i);
