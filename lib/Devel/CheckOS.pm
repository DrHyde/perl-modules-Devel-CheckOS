# $Id: CheckOS.pm,v 1.3 2007/09/27 16:41:24 drhyde Exp $

package Devel::CheckOS;

use strict;

use vars qw($VERSION @ISA @EXPORT_OK %EXPORT_TAGS);

$VERSION = '1.0';

# localising prevents the warningness leaking out of this module
local $^W = 1;    # use warnings is a 5.6-ism

@ISA = qw(Exporter);
@EXPORT_OK = qw(os_is os_isnt die_if_os_is die_if_os_isnt die_unsupported);
%EXPORT_TAGS = (
    all      => \@EXPORT_OK,
    booleans => [qw(os_is os_isnt die_unsupported)],
    fatal    => [qw(die_if_os_is die_if_os_isnt)]
);

=head1 NAME

Devel::CheckOS - check what OS we're running on

=head1 DESCRIPTION

Devel::CheckOS provides a more friendly interface to $^O, and also lets
you check for various OS "families" such as "Unix", which includes things
like Linux, Solaris, AIX etc.

=head1 SYNOPSIS

    use Devel::CheckOS;
    print "Hey, I know this, it's a Unix system\n" if(os_is('Unix'));

=head1 FUNCTIONS

Devel::CheckOS implements the following functions, which load subsidiary
OS-specific modules on demand to do the real work.  They can be exported
by listing their names after C<use Devel::CheckOS>.  You can also export
groups of functions thus:

    use Devel::CheckOS qw(:booleans); # export the boolean functions
                                      # and 'die_unsupported'
    
    use Devel::CheckOS qw(:fatal);    # export those that die on no match

    use Devel::CheckOS qw(:all);      # export everything

=head2 Boolean functions

=head3 os_is

Takes a list of OS names.  If the current platform matches any of them,
it returns true, otherwise it returns false.  The names can be a mixture
of OSes and OS families, eg ...

    os_is(qw(Unix VMS)); # Unix is a family, VMS is an OS

=cut

sub os_is {
    my @targets = @_;
    foreach my $target (@targets) {
        die("Devel::CheckOS: $target isn't a legal OS name\n")
            unless($target =~ /^\w+$/);
        eval "use Devel::AssertOS::$target";
        if(!$@) {
            no strict 'refs';
            return 1 if(&{"Devel::AssertOS::${target}::os_is"}());
        }
    }
    return 0;
}

=head3 os_isnt

If the current platform matches any of the parameters it returns false,
otherwise it returns true.

=cut

sub os_isnt {
    my @targets = @_;
    foreach my $target (@targets) {
        return 0 if(os_is($target));
    }
    return 1;
}

=head2 Fatal functions

=head3 die_if_os_isnt

As C<os_is()>, except that it dies instead of returning false.  The die()
message matches what the CPAN-testers look for to determine if a module
doesn't support a particular platform.

=cut

sub die_if_os_isnt {
    os_is(@_) ? 1 : die_unsupported();
}

=head3 die_if_os_is

As C<os_isnt()>, except that it dies instead of returning false.

=cut

sub die_if_os_is {
    os_isnt(@_) ? 1 : die_unsupported();
}

=head2 And a utility function for dieing ...

=head3 die_unsupported

This function simply dies with the message "OS unsupported", which is what
the CPAN testers look for to figure out whether a platform is supported or
not.

=cut

sub die_unsupported { die("OS unsupported\n"); }

=head1 PLATFORMS SUPPORTED

The following operating systems are supported:

    AIX            HPUX           NetBSD    Solaris
    Amiga          Interix        Netware   SunOS
    BSDOS          Irix           OS2       SysVr4
    BeOS           Linux          OS390     SysVr5
    Cygwin         MPEiX          OS400     Unicos
    DGUX           MSDOS          OSF       VMESA
    Darwin         MacOSX         OpenBSD   VMS
    DragonflyBSD   MacOSclassic   POSIXBC   VOS
    Dynix          MachTen        RISCOS
    FreeBSD        NeXT           SCO

Note that capitalisation is important.  These are the names of the
underlying Devel::AssertOS::* modules (see L<Devel::AssertOS> for
details) which do the actual platform detection, so they have to
be 'legal' filenames, which unfortunately precludes funny characters,
so platforms like OS/2 are mis-spelt deliberately.  Sorry.

The following OS 'families' are supported:

    Apple
    DEC
    MicrosoftWindows
    Sun
    Unix

=head1 BUGS and FEEDBACK

I welcome feedback about my code, including constructive criticism.
Bug reports should be made using L<http://rt.cpan.org/> or by email.

You will need to include in your bug report the exact value of $^O, what
the OS is called (eg Windows Vista 64 bit Ultimate Home Edition), and,
if relevant, what "OS family" it should be in and who wrote it.

If you are feeling particularly generous you can encourage me in my
open source endeavours by buying me something from my wishlist:
  L<http://www.cantrell.org.uk/david/wishlist/>

=head1 SEE ALSO

$^O in L<perlvar>

L<perlport>

=head1 AUTHOR

David Cantrell E<lt>F<david@cantrell.org.uk>E<gt>

Thanks to David Golden for the name and ideas about the interface, and
for the cpan-testers-discuss mailing list for prompting me to write it
in the first place.

=head1 COPYRIGHT and LICENCE

Copyright 2007 David Cantrell

This module is free-as-in-speech software, and may be used, distributed,
and modified under the same conditions as perl itself.

=head1 CONSPIRACY

This module is also free-as-in-mason software.

=cut

$^O;
