use strict;
$^W = 1;

use lib 't/lib';
use Test::More tests => 1;

use_ok('Devel::AssertOS', 'NotAnOperatingSystem', 'AnOperatingSystem');
