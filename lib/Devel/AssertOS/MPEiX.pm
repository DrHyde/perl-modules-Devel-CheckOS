# $Id: MPEiX.pm,v 1.2 2007/10/19 16:45:52 drhyde Exp $

package Devel::AssertOS::MPEiX;

use Devel::CheckOS;

$VERSION = '1.0';

sub os_is { $^O eq 'mpeix' ? 1 : 0; }

Devel::CheckOS::die_unsupported() unless(os_is());

1;
