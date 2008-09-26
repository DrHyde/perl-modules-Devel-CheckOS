# $Id: 50-script.t,v 1.2 2008/09/26 14:28:43 drhyde Exp $
use strict;
$^W = 1;

use Test::More skip_all => 'script tests not written yet';
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
