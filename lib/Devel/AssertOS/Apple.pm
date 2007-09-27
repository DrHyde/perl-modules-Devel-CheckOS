# $Id: Apple.pm,v 1.1 2007/09/27 16:41:24 drhyde Exp $

package Devel::AssertOS::Apple;

use Devel::CheckOS qw(die_unsupported);

$VERSION = '1.0';

sub os_is { $^O =~ /^darwin|MacOS/ ? 1 : 0; }

die_unsupported() unless(os_is());

1;
