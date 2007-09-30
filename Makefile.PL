# $Id: Makefile.PL,v 1.5 2007/09/30 14:17:59 drhyde Exp $

use ExtUtils::MakeMaker;

use lib 'lib';

my @OSes = ();
opendir(LIBS, 'lib/Devel/AssertOS/') ||
    die("Can't read lib/Devel/AssertOS. Your distribution is broken\n");
foreach (map { s/\.pm$//; $_ } grep { /\.pm$/ } readdir(LIBS)) {
    eval "use Devel::AssertOS::$_";
    push @OSes, $_ if(
        !$@ &&
        prompt(
            "I think you're using $_, is this right? [Y/n]",
            "Y"
        ) =~ /^y/i
    );
}
closedir(LIBS);

# print "OSes: ".join(', ', @OSes)."\n";

WriteMakefile(
    NAME         => 'Devel::CheckOS',
    # FIXME have this look at all the modules, or summat
    VERSION_FROM => 'lib/Devel/CheckOS.pm',
    PREREQ_PM    => {
        'Test::More'       => 0.7,  # way too high, but it works
        'File::Find::Rule' => 0.28,
        # 'Exporter' => 0 # core
    }
);
