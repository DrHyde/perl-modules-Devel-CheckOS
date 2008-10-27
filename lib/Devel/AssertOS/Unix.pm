# $Id: Unix.pm,v 1.8 2008/10/27 20:31:21 drhyde Exp $

package Devel::AssertOS::Unix;

use Devel::CheckOS;

$VERSION = '1.1';

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
    Devel::CheckOS::os_is('MacOSX') ||
    Devel::CheckOS::os_is('MirOSBSD') ||
    Devel::CheckOS::os_is('NetBSD') ||
    Devel::CheckOS::os_is('OpenBSD') ||
    Devel::CheckOS::os_is('OSF') ||
    Devel::CheckOS::os_is('QNX') ||
    Devel::CheckOS::os_is('SCO') ||
    Devel::CheckOS::os_is('Solaris') ||
    Devel::CheckOS::os_is('SunOS') ||
    Devel::CheckOS::os_is('SysVr4') ||
    Devel::CheckOS::os_is('SysVr5') ||
    Devel::CheckOS::os_is('Unicos')
}

Devel::CheckOS::die_unsupported() unless(os_is());

=head1 COPYRIGHT and LICENCE

Copyright 2007 - 2008 David Cantrell

This software is free-as-in-speech software, and may be used, distributed, and modified under the terms of either the GNU General Public Licence version 2 or the Artistic Licence. It's up to you which one you use. The full text of the licences can be found in the files GPL2.txt and ARTISTIC.txt, respectively.

=cut

1;
