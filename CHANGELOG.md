# Change Log

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## [0.1.1] - [2017-09-02]

### Changed

- Switched to [evil-client] v2+ (nepalez)

## [0.1.0] - [2017-08-11]

The gem is re-written on top of newer version of [evil-client]
Some changes in the interface has been made as well.

### Changed

- The root option `:test` renamed to `:testsend` for internal reasons of [evil-client][evil-client] implementation (nepalez)
- Version of [evil-client][evil-client] used under the hood: 0.3.3 -> 1.1.0 (nepalez)

### Deleted

- Method `send_to_group` removed in favor or `group:` option of `send_sms` (nepalez)
- Validation of responses returned by a remote server (nepalez)
- Dependency from [dry-types][dry-types] (nepalez)

## [0.0.9] - [2017-06-23]

### Fixed
- Always add `#success` to answers to `#send_sms` (@nepalez)

## [0.0.8] - [2017-06-23]

### Added
- Weakened dependency from [dry-types], allowing v0.0.9 (@nepalez)

[evil-client]: https://github.com/evilmartians/evil-client
[dry-types]: https://github.com/dry-rb/dry-types
[0.0.8]: https://github.com/nepalez/sms_aero/compare/v0.0.7...v0.0.8
[0.0.9]: https://github.com/nepalez/sms_aero/compare/v0.0.8...v0.0.9
[0.1.0]: https://github.com/nepalez/sms_aero/compare/v0.0.9...v0.1.0
[0.1.1]: https://github.com/nepalez/sms_aero/compare/v0.1.0...v0.1.1
