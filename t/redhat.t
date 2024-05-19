use warnings;
use strict;
use Test::More;
use Devel::CheckOS qw(os_is os_isnt);
use Devel::CheckOS::Helpers::LinuxOSrelease 'distributor_id';

local $^O = 'linux';

Devel::CheckOS::Helpers::LinuxOSrelease::_set_file('t/etc-os-release/rhel');
ok(os_is('Linux::RHEL'), "detected RHEL");
ok(os_is('Linux::Redhat'), "... and also as Redhat");
ok(os_isnt('Linux::Fedora'), "... but not as Fedora");
ok(os_isnt('Linux::Centos'), "... or Centos");

Devel::CheckOS::Helpers::LinuxOSrelease::_set_file('t/etc-os-release/fedora');
ok(os_is('Linux::Fedora'), "detected Fedora");
ok(os_is('Linux::Redhat'), "... and also as Redhat");
ok(os_isnt('Linux::RHEL'), "... but not as RHEL");
ok(os_isnt('Linux::Centos'), "... or Centos");

Devel::CheckOS::Helpers::LinuxOSrelease::_set_file('t/etc-os-release/centos');
ok(os_is('Linux::Centos'), "detected Centos");
ok(os_is('Linux::Redhat'), "... and also as Redhat");
ok(os_isnt('Linux::Fedora'), "... but not as Fedora");
ok(os_isnt('Linux::RHEL'), "... or RHEL");

done_testing;
