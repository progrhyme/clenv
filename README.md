# clenv

Command-Line modules manager.

Table of Contents:

* [clenv](#clenv)
  * [Components](#components)
  * [Requirements](#requirements)
  * [Install](#install)
  * [Configure](#configure)
  * [Install modules by clam](#install-modules-by-clam)
  * [clam\.spec](#clamspec)
* [AUTHORS](#authors)
* [LICENSE](#license)

## Components

Executable files:

- `clenv`
  - CLI to control _clenv_ environments. An environment contains sets of modules.
- `clam`
  - CLI to install _clam_ modules for _clenv_.  
  A module consists of some executable files and shell resources, and must have a `clam.spec` file which tells meta info of the module.

## Requirements

- Bash or Zsh

## Install

```
git clone https://github.com/key-amb/clenv.git ~/.clenv
```

## Configure

`clenv` needs some environment variables for now.

```
export CLENV_ROOT=$HOME/.clenv
export PATH="$HOME/.clenv/shims:$PATH"
export PATH="$HOME/.clenv/bin:$PATH"
```

Then, you need initialize an environment.

```
clenv init-env [$env]
```

This command creates `$CLENV_ROOT/environments/$env`.  
Default `$env` is `"default"`.

And to use `clam` modules in the environment, run following command:

```
eval $(clenv use $env)
```

This command does followings:

- Set environment variable `CLENV_ENVIRONMENT` to `$env`.
- Create symlink `$CLENV_ROOT/shims` of `$CLENV_ROOT/environments/$CLENV_ENVIRONMENT/bin`.

## Install modules by `clam`

```
# Install local module
clam /path/to/module

# Install from git repository
clam https://github.com/foo/bar.git
```

Executable files in modules can be run after installed.  
But shell resources are not automatically loaded.  
So you need again `eval $(clenv use $env)` to load them.

## `clam.spec`

A `clam.spec` file looks like below:

```
version=0.1
executables=bin/*
resources=lib/*
```

With this `clam.spec`, `clam` installs `bin/*` files under `$CLENV_ROOT/environments/$CLENV_ENVIRONMENT/bin/`.  
And it installs `lib/*` files under `$CLENV_ROOT/environments/$CLENV_ENVIRONMENT/lib/`.

# AUTHORS

YASUTAKE Kiyoshi <yasutake.kiyoshi@gmail.com>

# LICENSE

The MIT License (MIT)

Copyright (c) 2016 YASUTAKE Kiyoshi