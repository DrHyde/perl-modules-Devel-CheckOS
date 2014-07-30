package Devel::AssertOS::Linux;

use Devel::CheckOS;

$VERSION = '1.2';


sub matches { qw(Linux Android) }
sub os_is {
    $^O =~ /^linux$/i
    ? 1
    : Devel::CheckOS::os_is(grep !/^linux$/i, matches());
}

Devel::CheckOS::die_unsupported() unless(os_is());

sub expn {
    "The operating system has a Linux kernel"
}

=head1 COPYRIGHT and LICENCE

Copyright 2007 - 2014 David Cantrell

This software is free-as-in-speech software, and may be used, distributed, and modified under the terms of either the GNU General Public Licence version 2 or the Artistic Licence. It's up to you which one you use. The full text of the licences can be found in the files GPL2.txt and ARTISTIC.txt, respectively.

=cut

1;
