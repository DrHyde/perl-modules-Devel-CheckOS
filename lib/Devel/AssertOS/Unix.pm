# $Id: Unix.pm,v 1.7 2008/10/22 19:10:52 drhyde Exp $

package Devel::AssertOS::Unix;

use Devel::CheckOS;

$VERSION = '1.0';

# list of OSes lifted from Module::Build 0.2808
#
sub os_is {
    Devel::CheckOS::os_is('AIX') ||
    Devel::CheckOS::os_is('BSDOS') ||
    Devel::CheckOS::os_is('DGUX') ||
    Devel::CheckOS::os_is('DragonflyBSD') ||
    Devel::CheckOS::os_is('Dynix') ||
    Devel::CheckOS::os_is('FreeBSD') ||
    Devel::CheckOS::os_is('HPUX') ||
    Devel::CheckOS::os_is('Interix') ||
    Devel::CheckOS::os_is('Irix') ||
    Devel::CheckOS::os_is('Linux') ||
    Devel::CheckOS::os_is('MachTen') ||
    Devel::CheckOS::os_is('MirOSBSD') ||
    Devel::CheckOS::os_is('OpenBSD') ||
    Devel::CheckOS::os_is('NetBSD') ||
    Devel::CheckOS::os_is('OSF') ||
    Devel::CheckOS::os_is('SysVr4') ||
    Devel::CheckOS::os_is('SysVr5') ||
    Devel::CheckOS::os_is('SCO') ||
    Devel::CheckOS::os_is('Unicos') ||
    Devel::CheckOS::os_is('Solaris') ||
    Devel::CheckOS::os_is('SunOS') ||
    Devel::CheckOS::os_is('QNX')
}

Devel::CheckOS::die_unsupported() unless(os_is());

1;
