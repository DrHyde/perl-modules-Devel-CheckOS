mkdir dist-for-test &&
tar -C dist-for-test -xzf *.tar.gz &&
cd dist-for-test/* &&
cpanm --installdeps . &&
perl Makefile.PL &&
perl -V|grep .vsize &&
make test TEST_VERBOSE=1
