# Changelog

All notable changes are documented here.

## [Unreleased]

### Added
- Migrated to the `lint_roller`-based RuboCop plugin system (RuboCop 1.72+). Register with `plugins: rubocop-greppable_rails` in `.rubocop.yml`.

### Changed
- Bumped required Ruby to `>= 3.2`.
- Pinned `rubocop` runtime dependency to `>= 1.72`.
- Modernized CI matrix (Ruby 3.2 ~ head) and now actually run RSpec.
- Cleaned up gemspec metadata (summary/description).
- Renamed top-level module `Rubocop::GreppableRails` → `RuboCop::GreppableRails` to match RuboCop convention.

## [0.1.1]

_Released before changelog was kept._
