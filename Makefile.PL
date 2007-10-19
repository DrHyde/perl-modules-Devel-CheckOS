# $Id: Makefile.PL,v 1.24 2007/10/19 16:57:11 drhyde Exp $

require 5.005;
use ExtUtils::MakeMaker;

use File::Spec;

use strict;
local $^W = 1;

use lib 'lib';

opendir(T, 't');
unlink File::Spec->catfile('t', $_) foreach(grep { /^XX/ } readdir(T));
close(T);

my @OSes = ();
my @notOSes = ();

findOSes(File::Spec->catdir(qw(lib Devel AssertOS)));

sub findOSes {
    my $dir = shift;
    opendir(LIBS, $dir) ||
    die("Can't read $dir. Your distribution is broken\n");
    my @dirents = File::Spec->no_upwards(readdir(LIBS));
    closedir(LIBS);
    foreach (grep { -d File::Spec->catdir($dir, $_) } @dirents) {
        findOSes(File::Spec->catdir($dir, $_));
    }
    foreach (map { s/\.pm$//; $_ } grep { /\.pm$/ } @dirents) {
        my $modname = join('::', File::Spec->splitdir($dir), $_);
        (my $prompt_modname = $modname) =~ s/.*AssertOS:://;
        {
            # suppress 'Subroutine os_is redefined'
            local $^W = 0;
            eval "use $modname";
        }
        next if($@);
        my $answer = prompt(
            "I think you're using $prompt_modname, is this right (multiple matches are OK)? [Y/n]",
            "Y"
        );
        if($answer =~ /^y/i) {
            push @OSes, $prompt_modname;
        } else {
            print "Eek!\n";
            push @notOSes, $prompt_modname;
        }
    }
}

my @extrafiles = ();
if(@notOSes) { # user told us we got it wrong
    push @extrafiles, File::Spec->catfile('t', "XX-autodetected-$^O-as-".join('--', map { s/::/-/g; $_ } @notOSes).".t");
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
        (my $filename_os = $os) =~ s/::/-/g;
        push @extrafiles, File::Spec->catfile('t', "XX-autodetected-$^O-as-$filename_os.t");
        open(PASS, '>'.$extrafiles[-1]);
        print PASS qq{
            use Devel::AssertOS::$os;
            print "1..1\\n";print "ok 1\\n";
        };
        close(PASS);
    }
}

# print "OSes: ".join(', ', @OSes)."\n";

WriteMakefile(
    NAME         => 'Devel::CheckOS',
    VERSION      => '1.3',
    # FIXME have this look at all the modules, or summat
    # VERSION_FROM => 'lib/Devel/CheckOS.pm',
    PREREQ_PM    => {
        'Test::More'       => 0.62,  # too high? but it works
        'File::Find::Rule' => 0.28,
        # 'Exporter' => 0 # core
    },
    EXE_FILES    => [qw(
        bin/use-devel-assertos
    )],

    clean         => { FILES => join(' ', @extrafiles) }
);
