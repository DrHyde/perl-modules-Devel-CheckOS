# $Id: DragonflyBSD.pm,v 1.2 2007/10/19 16:45:51 drhyde Exp $

package Devel::AssertOS::DragonflyBSD;

use Devel::CheckOS;

$VERSION = '1.0';

sub os_is { $^O eq 'dragonfly' ? 1 : 0; }

Devel::CheckOS::die_unsupported() unless(os_is());

1;
