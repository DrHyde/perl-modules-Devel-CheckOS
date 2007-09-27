# $Id: Unix.pm,v 1.2 2007/09/27 16:02:18 drhyde Exp $

package Devel::AssertOS::Unix;

use Devel::CheckOS qw(die_unsupported);

$VERSION = '1.0';

sub os_is {
    $^O =~ /^
        aix      |
        bsdos    |
        darwin   |
        dgux     |
        dynixptx |
        freebsd  |
        linux    |
        hpux     |
        irix     |
        machten  |
        next     |
        openbsd  |
        dec_osf  |
        svr4     |
        unicos   |
        unicosmk |
        solaris  |
        sunos
    $/x ? 1 : 0;
}

die_unsupported() unless(os_is());

1;
