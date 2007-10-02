# $Id: Makefile.PL,v 1.16 2007/10/02 07:53:05 drhyde Exp $

use 5.005;
use ExtUtils::MakeMaker;

use File::Spec;

use strict;
$^W = 1;

use lib 'lib';

opendir(T, 't');
unlink File::Spec->catfile('t', $_) foreach(grep { /^XX/ } readdir(T));
close(T);

my @OSes = ();
my @notOSes = ();
opendir(LIBS, File::Spec->catdir(qw(lib Devel AssertOS))) ||
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

my @extrafiles = ();
if(@notOSes) { # user told us we got it wrong
    push @extrafiles, File::Spec->catfile('t', "XX-autodetected-$^O-as-".join('-', @notOSes).".t");
    open(FAIL, '>'.$extrafiles[-1]);
    print FAIL 'print "1..1\\n";print "not ok 1\\n"';
    close(FAIL);
} elsif(!@OSes) { # didn't detect anything!
    push @extrafiles, File::Spec->catfile('t', "XX-autodetected-$^O-as-nothing.t");
    open(FAIL, '>'.$extrafiles[-1]);
    print FAIL 'print "1..1\\n";print "not ok 1\\n"';
    close(FAIL);
} elsif(@OSes) {
    foreach my $os (@OSes) {
        push @extrafiles, File::Spec->catfile('t', "XX-autodetected-$^O-as-$os.t");
        open(PASS, '>'.$extrafiles[-1]);
        print PASS 'print "1..1\\n";print "ok 1\\n"';
        close(PASS);
    }
}

# print "OSes: ".join(', ', @OSes)."\n";

WriteMakefile(
    NAME         => 'Devel::CheckOS',
    VERSION      => 0.92,
    # FIXME have this look at all the modules, or summat
    # VERSION_FROM => 'lib/Devel/CheckOS.pm',
    PREREQ_PM    => {
        'Test::More'       => 0.62,  # too high? but it works
        'File::Find::Rule' => 0.28,
        # 'Exporter' => 0 # core
    },
    clean         => { FILES => join(' ', @extrafiles) }
);
