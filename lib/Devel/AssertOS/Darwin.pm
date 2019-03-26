# $Id: Darwin.pm~,v 1.1 2007/10/02 09:48:54 drhyde Exp $

package Devel::AssertOS::Darwin;

use Devel::CheckOS qw(die_unsupported);

$VERSION = '1.0';

sub os_is { $^O eq 'darwin' ? 1 : 0; }

die_unsupported() unless(os_is());

=head1 COPYRIGHT and LICENCE

Copyright 2007 - 2014 David Cantrell

This software is free-as-in-speech software, and may be used, distributed, and modified under the terms of either the GNU General Public Licence version 2 or the Artistic Licence. It's up to you which one you use. The full text of the licences can be found in the files GPL2.txt and ARTISTIC.txt, respectively.

=cut

1;
