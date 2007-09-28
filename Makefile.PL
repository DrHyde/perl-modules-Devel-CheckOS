# $Id: Makefile.PL,v 1.3 2007/09/28 14:35:08 drhyde Exp $

use ExtUtils::MakeMaker;

WriteMakefile(
    NAME         => 'Devel::CheckOS',
    # FIXME have this look at all the modules, or summat
    VERSION_FROM => 'lib/Devel/CheckOS.pm'
    PREREQ_PM    => {
        'File::Find::Rule' => 0.28,
        # 'Exporter' => 0 # core
    }
);
