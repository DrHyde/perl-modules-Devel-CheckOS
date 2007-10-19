# $Id: v10_4.pm,v 1.2 2007/10/19 16:45:52 drhyde Exp $

package Devel::AssertOS::MacOSX::v10_4;

use Devel::CheckOS;

use Devel::AssertOS::MacOSX;

$VERSION = '1.0';

sub os_is {
    `sw_vers -productVersion` =~ /^10\.4\./ ? 1 : 0;
}

Devel::CheckOS::die_unsupported() unless(os_is());

1;
