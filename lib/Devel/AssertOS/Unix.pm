# $Id: Unix.pm,v 1.1 2007/09/26 23:13:56 drhyde Exp $

package Devel::AssertOS::Unix;

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

die("OS unsupported\n") unless(os_is());

1;
