build_package_combined_patch() {
  local package_name="$1"

  {
    curl https://gist.github.com/funny-falcon/4136373/raw/0b65118d0e0930c5dc15479722309fac971af902/falcon-gc.diff | patch -p1
    autoconf
    ./configure --prefix="$PREFIX_PATH" $CONFIGURE_OPTS
    make -j 8
    make install
  } >&4 2>&1

}

install_package "yaml-0.1.4" "http://pyyaml.org/download/libyaml/yaml-0.1.4.tar.gz"
install_package "ruby-1.9.3-p327" "http://ftp.ruby-lang.org/pub/ruby/1.9/ruby-1.9.3-p327.tar.gz" combined_patch