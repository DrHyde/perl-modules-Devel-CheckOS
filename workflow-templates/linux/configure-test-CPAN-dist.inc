cpanm --installdeps .
perl makefile-expect-driver.pl Linux::Debian Linux::Ubuntu Linux Unix OSFeatures::Systemd OSFeatures::POSIXShellRedirection HWCapabilities::Int64
make test TEST_VERBOSE=1
