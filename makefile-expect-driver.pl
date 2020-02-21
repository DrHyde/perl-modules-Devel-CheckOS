use strict;
use warnings;

use Expect;

(my @platforms = @ARGV) ||
    die("You need to tell me what platforms to expect\n");
my $platforms_regex = join('|', @platforms);
my $platforms_found = 0;
my $e = Expect->new();

$ENV{AUTOMATED_TESTING} = 1;
$e->spawn($^X, 'Makefile.PL');

my($eof, $timeout) = (0, 0);
while(!$eof && !$timeout) {
    my $pattern_index = $e->expect(2,
        [ eof     => sub { $eof++;     } ],
        [ timeout => sub { $timeout++; } ],
        -re => qr/(Are you using (.*)\?)/,
        -re => qr/./
    );
    if($pattern_index && $pattern_index == 3) {
        my $matched = $e->match();
        $platforms_found++;
        if($matched =~ /^Are you using ($platforms_regex)/) {
            $e->send("\n");
        } else {
            $e->send("n\n");
        }
    }
}

die("Didn't match all expected platforms: expected [".join(', ', @platforms)."]\n")
    if($platforms_found != @platforms);
