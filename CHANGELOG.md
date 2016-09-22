## 0.6.1 (2016/9/22)

Feature:

- `clenv init` to bootstrap clenv #8

Bug Fix:

- `clenv environs` uses `clenv environ` internally instead of `CLENV_ENVIRONMENT`
environment variable #8

## 0.6.0 (2016/9/22)

Obsolete: #7

- `clenv_use` is deleted.
- `shrc.d/clenv.shrc` is deleted.

Bug Fix: #7

- [cload] Failed to add CLOAD_PATH when entry exists

Improve: #7

- `CLENV_ENVIRONMENT` env var is not required for all commands: Use `clenv environ`
instead.
- [cload, clenv] Show help when no argument given.

Minor Enhance: #7

- `clenv environ` - Add `--short` option to print environment only

## 0.5.0 (2016/9/21)

Change:

- clenv subcommands #6
  - Rename `init-env` to `create`
  - Rename `list-env` to `environs`

Fix:

- Omit strict `set` command from `clenv exec` #6
- Remove `local` variables for POSIX shell compatiability #6

Features:

- clenv new subcommands #6
  - `global` to show or set global environment
  - `local` to show or set local environment for current directory
  - `environ` to show environment in current context

## 0.4.0 (2016/9/18)

Change:

- clenv #5
  - Remove `clenv_switch` shell function
  - Change `clenv_use` not to load shell resources

## 0.3.2 (2016/9/18)

Enhance:

- clam.spec
  - Add `executablepath` as loading point for executable files #4

## 0.3.1 (2016/9/18)

Bug Fix:

- clam-install failed when `executables` or `libraries` are missing.

## 0.3.0 (2016/9/18)

Change:

- `shims` is changed from symlink to directory
- clam.spec
  - Obsolete `resources` field
  - Add `librarypath` or `libraries` fields
- clenv
  - Add subcommands `exec` and `which`

## 0.2.2 (2016/9/18)

Improve:

- cload:
  - Enable to load resources under directories

Feature:

- Add `cload -` argument to load `shrc.d/cload.shrc`

## 0.2.1 (2016/6/18)

Feature:

- Implement `cllib` shell function as an alternative to `cload` script

## 0.2.0 (2016/6/18)

Feature:

- Add `shrc.d/cload.shrc` to manipulate CLOAD_PATH

Improve:

- cload:
  - Load shell scripts without extention
- clenv:
  - Change CLOAD_PATH according to CLENV_ENVIRONMENT on `clenv_switch`

## 0.1.12 (2016/5/14)

Minor Update:

- Update document and test materials

## 0.1.11 (2016/4/22)

Feature:

- Implement `cload` script to load shell resource files from `environments/$env/lib/`
  for executables.

## 0.1.10 (2016/4/21)

Change:

- `lib/clenv.shrc` is now `shrc.d/clenv.shrc`. The only shrc file to be loaded
  to use **clenv** at this time.

## 0.1.9 (2016/4/19)

Change:

- `clenv` - rename shell functions for portability:
  - `clenv::use` => `clenv_use`, `clenv::switch` => `clenv_switch`

## 0.1.8 (2016/4/18)

Change:

- `clenv`:
  - Add `lib/clenv.shrc` which provides shell functions for `clenv`.
  - `eval $(clenv use $env)` => `clenv::use $env`
  - `eval $(clenv switch $env)` => `clenv::switch $env`

## 0.1.7 (2016/4/18)

Feature:

- `clenv switch $env` - Unlike `clenv use $env`, it does not load shell resources
  in the environment. All other functions are same with `clenv use $env`.

## 0.1.6 (2016/4/18)

Enhancement:

- `clam install`:
  - Add `-f|--force` option to force install; i.e. re-install if installed.

## 0.1.5 (2016/4/18)

Enhancement:

- `clam`:
  - `install`: Re-install (update) module when it's newer than installed one.
  - `install-deps`: Pass module version in `Clamfile` to `clam-install` command
    to update (re-install) newer modules.

## 0.1.4 (2016/4/17)

Enhancement:

- `clam`:
  - Check installation before fetch source repository by using module name passed
    as argument in the format of `<name>,<sourceUrl>`.
  - `clam install-deps` uses this feature to save cost of fetching repository.

## 0.1.3 (2016/4/17)

Fix Bug:

- **v0.1.2**
  - `clam install`: Module name would be always 'module' unless set by `clam.spec`
    param.

## 0.1.2 **obsolete** (2016/4/17)

Enhancement:

- `clam.spec`:
  - Enable to specify `name` param in `clam.spec`.

## 0.1.1 (2016/4/17)

Feature:

- `clam install-deps [Clamfile]` to install modules from `Clamfile`.

Change:

- Rename `Clamfile` in `${CLENV_ROOT}/environments/${env}/` to `Clamdb.txt` because
  the format is different from `Clamfile` above.

## 0.1.0 (2016/4/16)

Feature:

- `clam uninstall|-u <MODULE>` to uninstall module.

## 0.0.6 (2016/4/16)

Feature:

- `clam list|-l` to list installed modules.

Change:

- `clam`: Don't install module already installed.

## 0.0.5 (2016/4/16)

Minor Feature:

- `clam -h|--help`, `clam -v|--version`

## 0.0.4 (2016/4/16)

Change:

- `clam`:
  - Does not copy executables and resources into `bin/` or `lib/`.
  Creates symlinks of them instead.

## 0.0.3 (2016/4/16)

Minor Improve:

- `clenv list-env` now marks current environment so that one can easily distinguish
it from others.

## 0.0.2 (2016/4/16)

Minor Improve of `clam`.

## 0.0.1 (2016/4/16)

Initial release.
