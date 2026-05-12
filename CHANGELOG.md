# Changelog

All notable changes are documented here.

## [1.0.0] (Unreleased)

### Added
- Migrated to the `lint_roller`-based RuboCop plugin system (RuboCop 1.72+). Register with `plugins: rubocop-greppable_rails` in `.rubocop.yml`.

### Fixed
- `GreppableRails/NoHelperInController` and `GreppableRails/NoIncludeInHelper` now correctly handle namespaced classes/modules (e.g. `Admin::FoosController`).

### Changed
- **Breaking:** Renamed cops for consistency with the RuboCop ecosystem:
  - `GreppableRails/DontCallHelperInController` → `GreppableRails/NoHelperInController`
  - `GreppableRails/DontIncludeInHelper` → `GreppableRails/NoIncludeInHelper`
- Bumped required Ruby to `>= 3.2`.
- Pinned `rubocop` runtime dependency to `>= 1.72`.
- Modernized CI matrix (Ruby 3.2 ~ head) and now actually run RSpec.
- Cleaned up gemspec metadata (summary/description).
- Renamed top-level module `Rubocop::GreppableRails` → `RuboCop::GreppableRails` to match RuboCop convention.

## [0.1.1]

_Released before changelog was kept._
