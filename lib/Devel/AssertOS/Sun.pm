# $Id: Sun.pm,v 1.3 2007/10/19 16:45:52 drhyde Exp $

package Devel::AssertOS::Sun;

use Devel::CheckOS;

$VERSION = '1.0';

sub os_is { $^O =~ /^(sunos|solaris)$/ ? 1 : 0; }

Devel::CheckOS::die_unsupported() unless(os_is());

1;
