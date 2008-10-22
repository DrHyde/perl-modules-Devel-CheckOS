# $Id: Neutrino.pm,v 1.1 2008/10/22 19:10:52 drhyde Exp $

package Devel::AssertOS::QNX::Neutrino;

use Devel::CheckOS;

$VERSION = '1.0';

sub os_is { $^O eq 'nto' ? 1 : 0; }

Devel::CheckOS::die_unsupported() unless(os_is());

1;
