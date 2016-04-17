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
