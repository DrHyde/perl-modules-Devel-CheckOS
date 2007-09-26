# $Id: Makefile.PL,v 1.1 2007/09/26 23:13:56 drhyde Exp $

use ExtUtils::MakeMaker;

WriteMakefile(
    NAME         => 'Devel::CheckOS',
    # FIXME have this look at all the modules, or summat
    VERSION_FROM => 'lib/Devel/CheckOS.pm'
    PREREQ_PM    => {
        # no pre-reqs!
    }
);
