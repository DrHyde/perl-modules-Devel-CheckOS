# $Id: Makefile.PL,v 1.6 2007/09/30 14:39:28 drhyde Exp $

use ExtUtils::MakeMaker;

use strict;
$^W = 1;

use lib 'lib';

opendir(T, 't');
unlink "t/$_" foreach(grep { /^XX/ } readdir(T));
close(T);

my @OSes = ();
my @notOSes = ();
opendir(LIBS, 'lib/Devel/AssertOS/') ||
    die("Can't read lib/Devel/AssertOS. Your distribution is broken\n");
foreach (map { s/\.pm$//; $_ } grep { /\.pm$/ } readdir(LIBS)) {
    eval "use Devel::AssertOS::$_";
    next if($@);
    my $answer = prompt(
        "I think you're using $_, is this right? [Y/n]",
        "Y"
    );
    if($answer =~ /^y/i) {
        push @OSes, $_;
    } else {
        print "Eek!\n";
        push @notOSes, $_;
    }
}
closedir(LIBS);
if(@notOSes) {
    open(FAIL, ">t/XX-autodetect-$^O-as-".join('-', @notOSes).".t");
    print FAIL 'print "1..1\\n";print "not ok 1\\n"';
    close(FAIL);
} else {

}

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
