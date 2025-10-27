# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.4.0] - 2025-10-27

### Changed
- Removed PDF/UA tagging and \DocumentMetadata from main.tex due to persistent compatibility issues with LaTeX distributions and screen readers. PDF/UA compliance is no longer guaranteed; semantic markup and accessibility best practices are still maintained.
- Updated README and documentation to clarify that PDF/UA tagging is disabled and instructions no longer reference DocumentMetadata or PDF/UA features.

## [1.3.0] - 2025-10-20

### Added
- CSpell configuration file (.cspell.json) for spell checking with LaTeX-aware ignore patterns
- Typography note in README documenting en dash usage and screen reader behavior for APA 7 compliance

### Changed
- Added explicit Keep a Changelog and Semantic Versioning references to CHANGELOG header

## [1.2.0] - 2025-10-20

### Added
- Version tracking in main.tex header with repository URL and attribution guidelines
- CITATION.cff file for machine-readable citation metadata
- VERSION file for easy version tracking
- Citation and attribution section in README with BibTeX example
- Guidance for derivative works and template attribution
- Pre-commit hooks for automated LaTeX linting and quality checks
- Automatic release workflow triggered by version tags
- CODEOWNERS file to automate code review assignments and clarify ownership of repository files for contributors
- Comprehensive Copilot instructions file for improved coding agent efficiency

### Changed
- Split CI workflow into parallel PDF, HTML, and DOCX jobs
- Made HTML and DOCX builds non-blocking (only PDF is required)
- Improved .gitignore patterns

## [1.1.1] - 2025-10-20

### Fixed
- GitHub Actions CI build font installation
  - Fixed Times New Roman font installation in CI environment
  - Added automatic EULA acceptance for msttcorefonts installer
  - Improved font cache update with verbose logging
  - Added font verification step to catch installation issues

## [1.1.0] - 2025-10-20

### Added
- Support for DOCX output via Pandoc
- Enhanced PDF/UA accessibility compliance checks
- Additional citation examples in `main.tex`
- Improved build scripts for multi-format output
- Expanded documentation for contributors

## [1.0.0] - 2025-10-20

### Added

- Initial public release
- Sample `main.tex` with placeholder metadata, citation examples, and PDF/UA tagging
- Sample `references.bib` with book and journal entries, including DOI and ISBN metadata
- `Makefile` with targets for PDF (LaTeX and Pandoc), HTML, DOCX, linting, viewing, archiving, and submissions
- Lua filter for Pandoc to add accessible reference headings
- APA 7 citation style file (`apa.csl`) for Pandoc
- LuaLaTeX support with Times New Roman font
- Accessibility features (PDF/UA-1 compliance)
- Multiple output formats (PDF, HTML, DOCX)
- MIT License
- CONTRIBUTING.md with contribution guidelines

[Unreleased]: https://github.com/lanie-carmelo/apa-7-student-paper-template/compare/v1.3.0...HEAD
[1.3.0]: https://github.com/lanie-carmelo/apa-7-student-paper-template/compare/v1.2.0...v1.3.0
[1.2.0]: https://github.com/lanie-carmelo/apa-7-student-paper-template/compare/v1.1.1...v1.2.0
[1.1.1]: https://github.com/lanie-carmelo/apa-7-student-paper-template/compare/v1.1.0...v1.1.1
[1.1.0]: https://github.com/lanie-carmelo/apa-7-student-paper-template/compare/v1.0.0...v1.1.0
[1.0.0]: https://github.com/lanie-carmelo/apa-7-student-paper-template/releases/tag/v1.0.0
