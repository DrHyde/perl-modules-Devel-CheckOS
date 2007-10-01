use strict;
$^W = 1;

use Test::More tests => 9;

BEGIN { use_ok('Devel::CheckOS'); }

use File::Spec::Functions qw(catdir);
use lib catdir(qw(t lib));

ok(Devel::CheckOS::os_is('AnOperatingSystem'),
   "a single valid OS detected");
ok(Devel::CheckOS::os_isnt('NotAnOperatingSystem'),
   "a single invalid OS detected");

eval { Devel::CheckOS::die_if_os_isnt('AnOperatingSystem') };
ok(!$@, "a single valid OS detected using die_if_os_isnt");
eval { Devel::CheckOS::die_if_os_is('AnOperatingSystem') };
ok($@ =~ /OS unsupported/i, "a single valid OS detected using die_if_os_is");

eval { Devel::CheckOS::die_if_os_is('NotAnOperatingSystem') };
ok(!$@, "a single invalid OS detected using die_if_os_is");
eval { Devel::CheckOS::die_if_os_isnt('NotAnOperatingSystem') };
ok($@ =~ /OS unsupported/i, "a single invalid OS detected using die_if_os_isnt");

eval { Devel::CheckOS::die_unsupported() };
ok($@ =~ /OS unsupported/i, "die_unsupported works");

ok((grep { /^AnOperatingSystem$/ } Devel::CheckOS::list_platforms()) &&
   (grep { /^NotAnOperatingSystem$/ } Devel::CheckOS::list_platforms()),
   "list_platforms works");
