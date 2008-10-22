# $Id: Realtime.pm,v 1.1 2008/10/22 19:10:52 drhyde Exp $

package Devel::AssertOS::Realtime;

use Devel::CheckOS;

$VERSION = '1.0';

sub os_is {
    Devel::CheckOS::os_is('QNX')
    # || Devel::CheckOS::os_is('some other RTOS')
    ;
}


Devel::CheckOS::die_unsupported() unless(os_is());

1;
