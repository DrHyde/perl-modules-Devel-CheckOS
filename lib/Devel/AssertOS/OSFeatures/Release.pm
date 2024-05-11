package Devel::AssertOS::Ubuntu::LSB;

use strict;
use warnings;
use File::Spec;
use parent 'Exporter';

our $VERSION   = '1.0';
our @EXPORT_OK = qw(distributor_id);

=pod

=head1 NAME

Devel::AssertOS::Ubuntu::LSB - functions to manipulate LSB files

=head1 SYNOPSIS

    use Devel::AssertOS::Ubuntu::LSB 'distributor_id';
    my $id = distributor_id;

=head1 DESCRIPTION

This module exports functions to handle text files related to Ubuntu LSB.

=head1 EXPORTED

The following subs are exported.

=head2 distributor_id

Retrieves and returns the distributor ID from the F</etc/lsb-release> file.

It is expected that the file exists, it is readable and have the following
content format:

    DISTRIB_ID=Ubuntu
    DISTRIB_RELEASE=22.04
    DISTRIB_CODENAME=jammy
    DISTRIB_DESCRIPTION="Ubuntu 22.04.4 LTS"

It returns the value of C<DISTRIB_ID> of C<undef>, if the conditions are not
those specified above.

=cut

sub distributor_id {
    my $filename  = 'lsb-release';
    my $file_path = File::Spec->catfile( ( '', 'etc' ), $filename );
    my $regex     = qr/^DISTRIB_ID\=(\w+)/;
    my $dist_id   = undef;

    if ( -r $file_path ) {
        open my $in, '<', $file_path or die "Cannot read $file_path: $!";
        while (<$in>) {
            chomp;
            if ( $_ =~ $regex ) {
                $dist_id = $1;
                last;
            }
        }
        close($in) or die "Cannot close $file_path: $!";
    }

    return $dist_id;
}

=head1 COPYRIGHT and LICENCE

Copyright 2024 David Cantrell

This software is free-as-in-speech software, and may be used, distributed, and modified under the terms of either the GNU General Public Licence version 2 or the Artistic Licence. It's up to you which one you use. The full text of the licences can be found in the files GPL2.txt and ARTISTIC.txt, respectively.

=cut

1;
