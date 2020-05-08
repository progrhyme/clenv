[![Build Status](https://travis-ci.org/key-amb/clenv.svg?branch=master)](https://travis-ci.org/key-amb/clenv)

# clenv

A toolkit to organize Command-Line environments including executable scripts and
shell resource files.  
This toolkit modularize command-line executables or shell resources and manages
them in the way which might look like [rbenv](https://github.com/rbenv/rbenv)
or [plenv](https://github.com/tokuhirom/plenv).

### Table of Contents

* [Components](#components)
* [Requirements](#requirements)
* [Install](#install)
* [Configure](#configure)
* [clam](#clam)
  * [Install modules by clam](#install-modules-by-clam)
  * [clam\.spec](#clamspec)
  * [Install from Clamfile](#install-from-clamfile)
  * [Uninstall clam modules](#uninstall-clam-modules)
* [cload](#cload)
  * ["cllib" vs "cload"](#cllib-vs-cload)
* [AUTHORS](#authors)
* [LICENSE](#license)

# Components

Executable files:

- `clenv`
  - CLI to control _clenv_ environments. An environment contains sets of _clam_ modules.
- `clam`
  - CLI to manage _clam_ modules for _clenv_.  
  A module consists of some executable files and shell resources, and must have
  a `clam.spec` file which tells meta info of the module.
- `cload`
  - CLI to load shell resources using _CLOAD_PATH_ environment variable.

# Requirements

- Recommend: _Bash_ or _Zsh_
- Support other POSIX shells: _sh_, _dash_ and _ksh_

# Install

```sh
git clone https://github.com/key-amb/clenv.git ~/.clenv # Or your favorite path
```

# Configure

To use `clenv`, append following commands to your shell profile:

```sh
export CLENV_ROOT=$HOME/.clenv
export PATH="$CLENV_ROOT/bin:$PATH"
eval "$(clenv init -)"
```

Then, restart your shell and `clenv` will be ready.

Check your installation like this:

```sh
% clenv environ
default (set by /home/key-amb/.clenv/environment)
```

"default" is your first _clenv environment_.  
You can add other environments by `clenv create` command:

```
clenv create $env
```

This command creates `$env` under `$CLENV_ROOT/environments/`.  

And `clenv global` command set the environment as _global_ one:

```
clenv global $env
```

This command create or replace `$CLENV_ROOT/environment` file.

Alternative command is `clenv local $env`.
This creates `.clenv-environment` file in current directory.

Run `clenv environ[s]` command to see which environment is active now.

# clam

You can install clam modules in **clenv** environments.

`clam -h` may show you what are not described here in more detail.

## Install modules by `clam`

```sh
# Install local module
clam [install] /path/to/module [-f|--force]

# Install from git repository
clam [install] https://github.com/foo/bar.git [-f|--force]
```

Executable files in modules can be run after installed.  
But shell resources are not automatically loaded.  
So you need again `eval $(clenv use $env)` to load them.

`clam` does not install when newer or latest module is already installed.  
You can specify `-f|--force` option to force re-install it.

## `clam.spec`

A `clam.spec` file looks like below:

```sh
name=foo
version=0.1
executables="bin/foo"
#executablepath="bin"
librarypath="lib"
#libraries="lib/foo.sh lib/foo/"
```

With this `clam.spec`, `clam` installs as followings:

- Copy module directory as `$CLENV_ROOT/environments/$env/modules/foo/`
directory.
- Create symlinks of `bin/foo` file into `$CLENV_ROOT/environments/$env/bin/`
directory.
- Create symlinks of files or directories just under `lib/` into
`$CLENV_ROOT/environments/$env/lib/` directory.

Alternatives:

- If you have many executables in one directory, you can use `executablepath` field
instead of `executables`.
- You can list your `libraries` as space-separated string instead of `librarypath`.

## Install from `Clamfile`

When you want to install many modules at once, you can write down their info in
one `Clamfile`.  
A `Clamfile` looks like below:

```
bb         0.2.0    https://github.com/key-amb/bash-bb.git
pathctl    1.0.0    https://github.com/key-amb/sh-pathctl.git
shove      0.7.2    https://github.com/key-amb/shove.git
```

When you run `clam install-deps [Clamfile]` in the directory in which there is this
file named `Clamfile`, it installs `bb` and `pathctl` into your `clenv`
from the URLs.

And you can find more clam modules in [example/Clamfile](example/Clamfile).

## Uninstall clam modules

```
clam -u|uninstall <MODULE>
```

# cload

Command `cload` loads shell resources using `.` (or `source` in bash/zsh) shell
function.  
And shell function `cllib` in `shrc.d/cload.shrc` has the same feature.

If you have already configured **clenv**,
following code loads _mylib.sh(rc)_ file under `$CLENV_ROOT/environments/$env/lib/`
directory.

```sh
eval $(cload mylib)
# Or
cllib mylib
```

And file name _mylib_ is also fine.

`cload` searches files under the directories specified by environment variable **CLOAD_PATH**.  
With `clenv` configured, `cload` or `cllib` appends `$CLENV_ROOT/environments/$env/lib`
to `CLOAD_PATH` implicitly.

`cload` itself is independent from _clenv_.  
You can use `cload` out of _clenv_ in the following way:

```sh
. ${CLENV_ROOT}/shrc.d/cload.shrc
cload_path_push /path/to/lib
eval $(cload mylib)
# Or `cllib mylib`
```

`cload.shrc` provides some shell functions to manipulate `CLOAD_PATH`.  
For more information, run `pod2text shrc.d/cload.shrc`.

## "cllib" vs "cload"

As described in former section, **cllib** is a short-hand way for `eval $(cload <src>)`.

But note that _cllib_ is a shell function so you can't execute it unless you have loaded `shrc.d/cload.shrc`
in the same shell context.  
On the other hand, you can run _cload_ in any shell context.

Here is another way: `eval $(cload -)` loads `shrc.d/cload.shrc` in the shell context.

In scripting shell programs, you can go either of following ways to load libraries:

```sh
# (1)
eval $(cload foo)
eval $(cload foo/bar)

# (2)
eval $(cload -)
cllib 'foo'
cllib 'foo/bar'
```

The former way is simple.
But the latter has advantage in terms of performance on larger system.

# AUTHORS

IKEDA Kiyoshi <progrhyme@gmail.com>

# LICENSE

The MIT License (MIT)

Copyright (c) 2016 IKEDA Kiyoshi
