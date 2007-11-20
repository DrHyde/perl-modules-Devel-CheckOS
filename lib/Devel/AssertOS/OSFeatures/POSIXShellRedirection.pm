# $Id: POSIXShellRedirection.pm,v 1.1 2007/11/20 21:04:38 drhyde Exp $

package Devel::AssertOS::OSFeatures::POSIXShellRedirection;

use Devel::CheckOS;

use Devel::AssertOS qw(Unix Cygwin);

=head1 NAME

Devel::AssertOS::OSFeatures::POSIXShellRedirection - check whether
the OS we're running on can be expected to support POSIX shell
redirection.

=head1 SYNOPSIS

See L<Devel::CheckOS> and L<Devel::AssertOS>

=cut

$VERSION = '1.0';

sub os_is { 1; }

Devel::CheckOS::die_unsupported() unless(os_is());

1;
