use strict;
$^W = 1;

use Test::More tests => 2;

use Devel::CheckOS ':booleans';

use File::Spec::Functions qw(catdir);
use lib catdir(qw(t lib));

ok(os_is('AnOperatingSystem'), "os_is imported");
ok(os_isnt('NotAnOperatingSystem'), "os_isnt imported");
