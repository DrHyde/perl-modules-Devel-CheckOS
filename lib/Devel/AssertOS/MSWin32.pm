# $Id: MSWin32.pm,v 1.2 2007/10/19 16:45:52 drhyde Exp $

package Devel::AssertOS::MSWin32;

use Devel::CheckOS;

$VERSION = '1.0';

sub os_is { $^O eq 'MSWin32' ? 1 : 0; }

Devel::CheckOS::die_unsupported() unless(os_is());

1;
