# $Id: Unix.pm,v 1.6 2008/09/26 14:28:43 drhyde Exp $

package Devel::AssertOS::Unix;

use Devel::CheckOS;

$VERSION = '1.0';

# list of OSes lifted from Module::Build 0.2808
#
sub os_is {
    $^O =~ /^(
        aix       |
        bsdos     |
        dgux      |
        dragonfly |
        dynixptx  |
        freebsd   |
        linux     |
        hpux      |
        irix      |
        darwin    |
        machten   |
	mirbsd    |
        openbsd   |
        netbsd    |
        dec_osf   |
        svr4      |
        svr5      |
        sco_sv    |
        unicos    |
        unicosmk  |
        solaris   |
        sunos     |
        interix
    )$/x ? 1 : 0;
}

Devel::CheckOS::die_unsupported() unless(os_is());

1;
