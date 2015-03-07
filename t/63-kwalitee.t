use Test::More;

use strict;
use warnings;
BEGIN {
   plan skip_all => 'these tests are for release candidate testing'
      unless $ENV{RELEASE_TESTING};
}

# no license is by design
use Test::Kwalitee::Extra qw(:optional !meta_yml_has_license);

done_testing;
