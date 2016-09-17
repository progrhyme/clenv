#!/usr/bin/env bash

set -euxo pipefail

shove_dir="vendor/shove"

if [[ ! -d $shove_dir ]]; then
  git clone https://github.com/key-amb/shove.git $shove_dir
else
  cd $shove_dir
  git pull origin master
fi

exit

: <<'__EOF__'

=encoding utf8

=head1 NAME

B<setup-shove.sh> - Set up shove under vendor/ directory

=head1 SYNOPSYS

    ./script/setup-shove.sh

=head1 AUTHORS

IKEDA Kiyoshi E<lt>yasutake.kiyoshi@gmail.comE<gt>

=head1 LICENSE

The MIT License (MIT)

Copyright (c) 2016 IKEDA Kiyoshi

=cut

__EOF__

