# Changelog

This changelog reflects the evolution of a template built for equity in academic publishing. Every version prioritizes accessibility, clarity, and community empowerment.

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Planned

- Add citation guidance for users referencing the template in academic work
- Improve README accessibility notes with screen reader testing details
- Expand Makefile with optional targets for archiving DOCX and HTML outputs
- Add sample `main.tex` with placeholder content and comments for new users

## [v1.1.1] - 2025-10-20

### Fixed

- GitHub Actions CI build
  - Fixed Times New Roman font installation in CI environment
  - Added automatic EULA acceptance for msttcorefonts installer
  - Improved font cache update with verbose logging
  - Added font verification step to catch installation issues

## [v1.1.0] - 2025-10-20

### Added

- Expanded README with purpose, audience, accessibility tools, and contributor links
- Added GitHub, LinkedIn, Mastodon, and website links to README header
- Clarified BibLaTeX/Biber usage and Overleaf compatibility
- Added “Who This Is For” and “Accessibility Tools Used” sections

### Fixed

- Improved Markdown structure for screen reader clarity

## [v1.0.0] - 2025-10-20

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

[Unreleased]: https://github.com/lanie-carmelo/apa-7-student-paper-template/compare/v1.1.0...HEAD
[v1.0.0]: https://github.com/lanie-carmelo/apa-7-student-paper-template/releases/tag/v1.0.0
[v1.1.0]: https://github.com/lanie-carmelo/apa-7-student-paper-template/releases/tag/v1.1.0
