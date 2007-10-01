# $Id: Makefile.PL,v 1.10 2007/10/01 16:46:06 drhyde Exp $

use ExtUtils::MakeMaker;
use Cwd;

use strict;
$^W = 1;

use lib 'lib';

# this and all the annoying chdir()s are because I have no idea how to
# construct paths on VMS and RISCOS.  Doing several individual chdir()s
# should work, also I opendir() directory names and not '.' or 'foo/bar'.
# Yuck.
#
# If only I could assume File::Spec was installed at this point, but I
# can't.  Double-yuck.

my $cwd = getcwd();

opendir(T, 't');
chdir('t');
unlink $_ foreach(grep { /^XX/ } readdir(T));
close(T);
chdir($cwd);

my @OSes = ();
my @notOSes = ();
chdir('lib');
chdir('Devel');
opendir(LIBS, 'AssertOS') ||
    die("Can't read lib/Devel/AssertOS. Your distribution is broken\n");
chdir($cwd);
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

chdir('t');
if(@notOSes) { # user told us we got it wrong
    open(FAIL, ">XX-autodetected-$^O-as-".join('-', @notOSes).".t");
    print FAIL 'print "1..1\\n";print "not ok 1\\n"';
    close(FAIL);
} elsif(!@OSes) { # didn't detect anything!
    open(FAIL, ">XX-autodetected-$^O-as-nothing.t");
    print FAIL 'print "1..1\\n";print "not ok 1\\n"';
    close(FAIL);
} elsif(@OSes) {
    # OS-specific tests?
}
chdir($cwd);

# print "OSes: ".join(', ', @OSes)."\n";

WriteMakefile(
    NAME         => 'Devel::CheckOS',
    VERSION      => 0.91,
    # FIXME have this look at all the modules, or summat
    # VERSION_FROM => 'lib/Devel/CheckOS.pm',
    PREREQ_PM    => {
        'Test::More'       => 0.62,  # too high? but it works
        'File::Find::Rule' => 0.28,
        'File::Spec::Functions' => '1.3',
        # 'Exporter' => 0 # core
    }
);
