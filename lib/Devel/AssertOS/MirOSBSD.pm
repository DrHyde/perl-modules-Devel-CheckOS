# $Id: MirOSBSD.pm,v 1.1 2008/09/26 14:28:43 drhyde Exp $

package Devel::AssertOS::MirOSBSD;

use Devel::CheckOS;

$VERSION = '1.0';

sub os_is { $^O eq 'mirbsd' ? 1 : 0; }

Devel::CheckOS::die_unsupported() unless(os_is());

1;
