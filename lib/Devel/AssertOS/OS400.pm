# $Id: OS400.pm,v 1.2 2007/10/19 16:45:52 drhyde Exp $

package Devel::AssertOS::OS400;

use Devel::CheckOS;

$VERSION = '1.0';

sub os_is { $^O eq 'os400' ? 1 : 0; }

Devel::CheckOS::die_unsupported() unless(os_is());

1;
