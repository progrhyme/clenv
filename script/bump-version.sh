#!/usr/bin/env bash

set -euo pipefail

curr_version=$(bin/clenv -v)
next_version=$1
perl -pi -e "s/(version=)\"$curr_version\"/\1\"$next_version\"/g" bin/{clenv,clam,cload}

exit

: <<'__EOF__'

=encoding utf8

=head1 NAME

B<bump-version.sh> - Utility to bump version of clenv

=head1 SYNOPSYS

    script/bump-version.sh $NEXT_VERSION

=head1 DESCRIPTION

Utility to bump version of clenv.

=head1 AUTHORS

IKEDA Kiyoshi E<lt>yasutake.kiyoshi@gmail.comE<gt>

=head1 LICENSE

The MIT License (MIT)

Copyright (c) 2016 IKEDA Kiyoshi

=cut

__EOF__

