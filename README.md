# clenv

A toolkit to organize Command-Line environments including executable scripts and
shell resource files.  
This toolkit modularize command-line executables or shell resources and manages
them in the way which might looks like [rbenv](https://github.com/rbenv/rbenv)
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
* [AUTHORS](#authors)
* [LICENSE](#license)

# Components

Executable files:

- `clenv`
  - CLI to control _clenv_ environments. An environment contains sets of _clam_ modules.
- `clam`
  - CLI to manage _clam_ modules for _clenv_.  
  A module consists of some executable files and shell resources, and must have a `clam.spec` file which tells meta info of the module.

# Requirements

- Bash or Zsh

# Install

```
git clone https://github.com/key-amb/clenv.git ~/.clenv
```

# Configure

To use `clenv`, it is required to set some environment variables and load shell
functions.

```
export CLENV_ROOT=$HOME/.clenv
export PATH="$HOME/.clenv/shims:$PATH"
export PATH="$HOME/.clenv/bin:$PATH"
source ${CLENV_ROOT}/lib/clenv.shrc
```

Then, you need initialize an environment.

```
clenv init-env [$env]
```

This command creates `$CLENV_ROOT/environments/$env`.  
Default `$env` is `"default"`.

And to use `clam` modules in the environment, run either of following shell functions:

```
# Switch symlinks
clenv_switch $env
# Load libraries in addition
clenv_use $env
```

`clenv_switch $env` does followings:

- Set environment variable `CLENV_ENVIRONMENT` to `$env`.
- Create symlink `$CLENV_ROOT/shims` of `$CLENV_ROOT/environments/$CLENV_ENVIRONMENT/bin`.

`clenv_use $env` does followings **in addition** to `clenv_switch $env`:

- Load shell resources by `source` command which are in
  `$CLENV_ROOT/environments/$CLENV_ENVIRONMENT/lib` directory.

To use `clenv_use` or `clenv_switch` is your choice.  
Use one which you prefer.

# clam

`clam -h` may show you what are not described here in more detail.

## Install modules by `clam`

```
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

```
name=foo
version=0.1
executables=bin/*
resources=lib/*
```

With this `clam.spec`, `clam` installs as followings:

- Copy module directory as `$CLENV_ROOT/environments/$CLENV_ENVIRONMENT/modules/foo/` directory.
- Create symlinks of `bin/*` files in `$CLENV_ROOT/environments/$CLENV_ENVIRONMENT/bin/` directory.
- Create symlinks of `lib/*` files in `$CLENV_ROOT/environments/$CLENV_ENVIRONMENT/lib/` directory.

## Install from `Clamfile`

When you want to install many modules at once, you can write down their info in
one `Clamfile`.  
A `Clamfile` looks like below:

```
bb         0.2.0    https://github.com/key-amb/bash-bb.git
pathctl    0.9.1    https://github.com/key-amb/bash-pathctl.git
```

When you run `clam install-deps [Clamfile]` in the directory in which there is this
file named `Clamfile`, it installs `bb` and `pathctl` into your `clenv`
from the URLs.

## Uninstall clam modules

```
clam -u|uninstall <MODULE>
```

# AUTHORS

YASUTAKE Kiyoshi <yasutake.kiyoshi@gmail.com>

# LICENSE

The MIT License (MIT)

Copyright (c) 2016 YASUTAKE Kiyoshi