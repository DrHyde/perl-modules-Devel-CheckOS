use strict;
$^W = 1;

use Test::More tests => 2;

use Devel::CheckOS ':booleans';

use File::Spec;
use lib File::Spec->catdir(qw(t lib));

ok(os_is('AnOperatingSystem::v2'), "os_is works for a multi-level name that exists");
ok(os_isnt('AnOperatingSystem::v1'), "os_isnt works for a multi-level name that exists");
