# $Id: v10_4.pm,v 1.1 2007/10/18 13:29:34 drhyde Exp $

package Devel::AssertOS::MacOSX::v10_4;

use Devel::CheckOS qw(die_unsupported);

use Devel::AssertOS::MacOSX;

$VERSION = '1.0';

sub os_is {
    `sw_vers -productVersion` =~ /^10\.4\./ ? 1 : 0;
}

die_unsupported() unless(os_is());

1;
