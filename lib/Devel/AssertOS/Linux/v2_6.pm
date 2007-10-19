# $Id: v2_6.pm,v 1.2 2007/10/19 16:45:52 drhyde Exp $

package Devel::AssertOS::Linux::v2_6;

use Devel::CheckOS;

use Devel::AssertOS::Linux;

$VERSION = '1.0';

sub os_is {
    `uname -r` =~ /^2\.6\./ ? 1 : 0;
}

Devel::CheckOS::die_unsupported() unless(os_is());

1;
