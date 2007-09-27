# $Id: Linux.pm,v 1.2 2007/09/27 16:02:18 drhyde Exp $

package Devel::AssertOS::Linux;

use Devel::CheckOS qw(die_unsupported);

$VERSION = '1.0';

sub os_is { $^O eq 'linux' ? 1 : 0; }

die_unsupported() unless(os_is());

1;
