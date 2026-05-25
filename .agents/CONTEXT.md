# Dotfiles

Personal configuration files managed across multiple machine targets.

## Language

**Managed File**:
A tracked dotfile entry that the installer may link into `$HOME`.
_Avoid_: cache, generated file, local state

**Shared Layer**:
OS-agnostic managed files that should be edited once and installed on every profile.
_Avoid_: agnostic configs, common configs

**Profile Layer**:
Target-specific managed files for one machine family such as WSL2, macOS, or Omarchy.
_Avoid_: OS directory

**Portable Layer**:
Managed files shared by a subset of profiles when they are not valid for every profile. In this repo it currently means WSL2 and macOS terminal configs that should not be installed into Omarchy.

**Stateful Directory**:
A user home directory where tools write credentials, caches, sessions, generated files, or downloaded plugins. Stateful directories must remain real local directories; the installer links only selected managed children inside them.
_Avoid_: managed directory, profile directory

**Overlay**:
The install-time relationship where the Shared Layer is applied first and the Profile Layer overrides or adds managed files for one target.
