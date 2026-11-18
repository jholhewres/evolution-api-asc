# patches/

`patch-package` patches for third-party dependencies, applied by the `postinstall`
hook in `package.json`. The Docker builder copies this directory before `npm ci`.

Each patch is pinned to the exact dependency version in its file name. Bumping that
dependency means re-creating the patch (`npx patch-package <name>`) or dropping it
once upstream ships the fix. `CHANGELOG.md` lists what each patch changes and why.
