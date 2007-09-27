# $Id: Makefile.PL,v 1.2 2007/09/27 16:41:24 drhyde Exp $

use ExtUtils::MakeMaker;

WriteMakefile(
    NAME         => 'Devel::CheckOS',
    # FIXME have this look at all the modules, or summat
    VERSION_FROM => 'lib/Devel/CheckOS.pm'
    PREREQ_PM    => {
        # 'Exporter' => 0 # core
    }
);
