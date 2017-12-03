# Change Log
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## [0.0.10] - [2017-12-03]

### Added
- checking existance & availability of phone number using methods `#hlr` and `#hlr_status id` (@Earendil95)

## [0.0.9] - [2017-06-23]

### Fixed
- Always add `#success` to answers to `#send_sms` (@nepalez)

## [0.0.8] - [2017-06-23]

### Added
- Weakened dependency from [dry-types], allowing v0.0.9 (@nepalez)

  Between v0.9.0 and v0.9.1 an `optional` property has been broken.

[dry-types]: https://github.com/dry-rb/dry-types
[0.0.8]: https://github.com/nepalez/sms_aero/compare/v0.0.7...v0.0.8
[0.0.9]: https://github.com/nepalez/sms_aero/compare/v0.0.8...v0.0.9
[0.0.10]: https://github.com/nepalez/sms_aero/compare/v0.0.8...v0.0.10

