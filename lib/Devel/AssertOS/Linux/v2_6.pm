# $Id: v2_6.pm,v 1.1 2007/10/18 13:29:05 drhyde Exp $

package Devel::AssertOS::Linux::v2_6;

use Devel::CheckOS qw(die_unsupported);

use Devel::AssertOS::Linux;

$VERSION = '1.0';

sub os_is {
    `uname -r` =~ /^2\.6\./ ? 1 : 0;
}

die_unsupported() unless(os_is());

1;
