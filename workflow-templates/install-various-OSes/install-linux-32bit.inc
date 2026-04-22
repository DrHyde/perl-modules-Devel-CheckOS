install-32bit-linux:
  runs-on: 'ubuntu-latest'
  needs: build
  container:
    image: i386/debian:trixie-slim
  steps:
    - name: Install on 32-bit Linux
      #include install-various-OSes/set-env-vars-for-install-linux-32bit.inc || null
      run: |
        apt-get update && apt-get install -y unzip curl jq build-essential &&
        curl -L -H "X-GitHub-Api-Version: 2022-11-28" -H "Authorization: Bearer ${GH_TOKEN}" -o dist-for-install.zip $(curl -L -s -H "Accept: application/vnd.github+json" -H "Authorization: Bearer ${GH_TOKEN}" -H "X-GitHub-Api-Version: 2022-11-28" https://api.github.com/repos/${GH_REPOSITORY}/actions/artifacts -o -|jq -r '[.artifacts.[]|select(.expired == false)]|max_by(.created_at).archive_download_url') &&
        curl -o perl-5.42.0-src.tar.gz https://cpan.metacpan.org/authors/id/B/BO/BOOK/perl-5.42.0.tar.gz &&
        tar xzf perl-5.42.0-src.tar.gz &&
        rm perl-5.42.0-src.tar.gz &&
        cd perl-5.42.0 &&
        sh Configure -de -Dprefix=$HOME/perl-5.42.0-installed &&
        make -j $(nproc) &&
        make install &&
        cd .. &&
        unzip dist-for-install.zip &&
        mkdir dist-for-test &&
        tar -C dist-for-test -xzf *.tar.gz &&
        cd dist-for-test/* &&
        $HOME/perl-5.42.0-installed/bin/perl -MCPAN -e 'install qw(App::cpanminus)' &&
        $HOME/perl-5.42.0-installed/bin/cpanm --installdeps . &&
        $HOME/perl-5.42.0-installed/bin/perl Makefile.PL &&
        $HOME/perl-5.42.0-installed/bin/perl -V|grep .vsize &&
        make test TEST_VERBOSE=1

