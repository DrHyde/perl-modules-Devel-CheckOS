use strict;
use warnings;

use Expect;
use File::Spec;

(my @platforms_wanted = @ARGV) ||
    die("You need to tell me what platforms to expect\n");
my $platforms_regex = '^Are you using ('.join('|', @platforms_wanted).')\\?';
my @platforms_found;
my $e = Expect->new();

$ENV{AUTOMATED_TESTING} = 1;
$e->spawn($^X, 'Makefile.PL');

my($eof, $timeout) = (0, 0);
while(!$eof && !$timeout) {
    my $pattern_index = $e->expect(
        50,
        [ eof     => sub { $eof++;     } ],
        [ timeout => sub { $timeout++; } ],
        -re => qr/(Are you using (.*)\?)/,
    );
    if($pattern_index && $pattern_index == 3) {
        my $matched = $e->match();
        (my $os_detected = $matched) =~ s/^Are you using (.*?)\?.*/$1/;
        push @platforms_found, $os_detected;

        if($matched =~ /$platforms_regex/) {
            $e->send("\n");
        } else {
            $e->send("n\n");
        }
    }
}

my @errors = ();
foreach my $wanted_platform (@platforms_wanted) {
    if(!grep { $_ eq $wanted_platform } @platforms_found) {
        push @errors, "Wanted $wanted_platform, but not detected";
        (my $filename_os = $wanted_platform) =~ s/::/-/g;
        my $test_file = File::Spec->catfile('t', "XX-no-autodetect-$^O-as-$filename_os.t");
        open(my $fh, '>', $test_file) || die("Couldn't write $test_file: $!\n");
        print $fh 'print "1..1\\nnot ok 1\\n"';
        close($fh);
    }
}
foreach my $got_platform (@platforms_found) {
    if(!grep { $_ eq $got_platform } @platforms_wanted) {
        push @errors, "Got $got_platform, unexpectedly";
    }
}
die(
    "Didn't match all (and only!) expected platforms:\n".
    join("\n", map { "  $_" } @errors).
    "\n"
) if(@errors);
