# $Id: 50-script.t,v 1.1 2008/06/16 15:01:29 drhyde Exp $
use strict;
$^W = 1;

use Test::More tests => 42;
use File::Temp;
use Cwd;
use Data::Dumper;

my $cwd = getcwd();

my $projectdir = File::Temp->newdir();

_run_script();

sub _run_script {
    chdir($projectdir);
    system($^X, $cwd.'/bin/use-devel-assertos', @_);
    chdir($cwd);
}
