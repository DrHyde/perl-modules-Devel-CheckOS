use strict;
$^W = 1;

use File::Spec;
use lib File::Spec->catdir(qw(t lib));

use Test::More tests => 49;

my %platforms = (
    aix         => 'AIX',
    amigaos     => 'Amiga',
    android     => 'Android',
    beos        => 'BeOS',
    bsdos       => 'BSDOS',
    cygwin      => 'Cygwin',
    dgux        => 'DGUX',
    dragonfly   => 'DragonflyBSD',
    dynixptx    => 'Dynix',
    freebsd     => 'FreeBSD',
    gnukfreebsd => 'GNUkFreeBSD',
    haiku       => 'Haiku',
    hpux        => 'HPUX',
    interix     => 'Interix',
    irix        => 'Irix',
    linux       => 'Linux',
    machten     => 'MachTen',
    MacOS       => 'MacOSclassic',
    darwin      => 'MacOSX',
    midnightbsd => 'MidnightBSD',
    mirbsd      => 'MirOSBSD',
    mpeix       => 'MPEiX',
    dos         => 'MSDOS',
    MSWin32     => 'MSWin32',
    netbsd      => 'NetBSD',
    netware     => 'Netware',
    next        => 'NeXT',
    openbsd     => 'OpenBSD',
    dec_osf     => 'OSF',
    os2         => 'OS2',
    os390       => 'OS390',
    os400       => 'OS400',
    'posix-bc'  => 'POSIXBC',
    nto         => 'QNX::Neutrino',
    qnx         => 'QNX::v4',
    riscos      => 'RISCOS',
    sco_sv      => 'SCO',
    svr4        => 'SysVr4',
    svr5        => 'SysVr5',
    solaris     => 'Solaris',
    sunos       => 'SunOS',
    unicosmk    => 'Unicos',
    unicos      => 'Unicos',
    vmesa       => 'VMESA',
    VMS         => 'VMS',
    VOS         => 'VOS',
    
);

# see if all the platform-specific modules load OK with the right $^O
foreach my $o (sort { lc($platforms{$a}) cmp lc($platforms{$b}) }keys %platforms) {
    my $platform = $platforms{$o};
    eval qq{ local \$^O = '$o'; eval 'use Devel::AssertOS::$platform'; };
    ok(!$@, "\$^O = $o\t=> $platform". ($@ ? ": $@" : ''));
}

{
  local $^O = 'haiku';
  ok(Devel::CheckOS::os_is('BeOS'), "Haiku is also BeOS");
}

{
    local $^O = 'android';
    ok(Devel::CheckOS::os_is('Linux'), "Android is also Linux");
    ok(Devel::CheckOS::os_is('Unix'), "Android is also Unix");
}
