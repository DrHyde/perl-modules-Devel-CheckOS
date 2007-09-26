# $Id: Linux.pm,v 1.1 2007/09/26 23:13:56 drhyde Exp $

package Devel::AssertOS::Linux;

$VERSION = '1.0';

sub os_is { $^O eq 'linux' ? 1 : 0; }

die("OS unsupported\n") unless(os_is());

1;
