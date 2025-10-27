# APA 7 Student Paper LaTeX Template

**Maintained by Lanie Molinar Carmelo**

- 🌐 [Website](https://laniecarmelo.tech)
- 🐘 [Mastodon (Most active)](https://allovertheplace.ca/@RareBird15)
- 💼 [LinkedIn](https://www.linkedin.com/in/laniecarmelo/)
- 🧑‍💻 [GitHub Profile](https://github.com/lanie-carmelo)

## Accessibility Note

All badges and links in this README are designed to be screen-reader-friendly. If you encounter any issues with NVDA, JAWS, or VoiceOver, feel free to open an issue or reach out.

## Project Status

[![Version: 1.5.0](https://img.shields.io/badge/version-1.5.0-blue)](https://github.com/Lanie-Carmelo/APA-7-Student-Paper-Template/releases/tag/v1.5.0) 
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit)](https://pre-commit.com/) 
[Release Notes](CHANGELOG.md)

Built for blind and sighted students alike, this template emphasizes accessibility, automation, and academic integrity in APA 7 academic writing.

This repository provides a ready-to-use template for APA 7th edition student
papers, written in LaTeX. It emphasizes accessibility, automation, and academic
integrity. This template uses the biblatex package with the biber backend (not
BibTeX). It includes:

`main.tex`: Starter document using manual APA formatting and Biber for bibliography processing. PDF/UA tagging is currently disabled ([why?](#pdfua-tagging-status)).
- `apa.csl`: Citation Style Language file for APA 7th edition (used by Pandoc).
- `Makefile`: Build system for PDF, HTML, DOCX, linting, viewing, and archiving.
- `.gitignore`: Ignores LaTeX build artifacts and editor backups.
- `LICENSE`: MIT License.

## Why This Exists

I originally built this for my own coursework as a blind Computer Science
student. Over time, I expanded it into a reusable, standards-compliant template
to support accessible academic publishing.

## Who This is For

This template is designed for students, researchers, and accessibility advocates
who want to produce APA-compliant documents using LaTeX—whether working locally
or in Overleaf.

📝 [How to Cite This Template](#citation-and-attribution)

## Accessibility Tools Used

This template was built with screen readers like NVDA and JAWS using Microsoft Visual
Studio Code.

### Note on Typography and Screen Readers

This template uses en dashes (–) for numeric ranges (e.g., pages 10–15, years 2020–2025) to comply with APA 7th edition style requirements.

Important for screen reader users: Screen readers (NVDA, JAWS, VoiceOver) announce en dashes as "en dash" and em dashes (—) as "em dash"—not as semantic words like "through" or meaningful pauses.

En dashes are used here for APA compliance and professional typography, not for accessibility benefits.

## Getting Started

```sh
make pdf
```

1. **Install LaTeX** (TeX Live, MikTeX, etc.) and Biber.
2. **Clone this repo** and add your content to `main.tex`.
3. **Add your references** to `references.bib` (see Using Zotero below).
4. **Build your document** using the Makefile (see Build Process).

## Build Process

### Pre-Commit Hooks

This repository uses [pre-commit](https://pre-commit.com/) to enforce linting and formatting standards before commits. Hooks include:

- File size checks
- Merge conflict detection
- Whitespace trimming
- YAML validation
- LaTeX linting with ChkTeX
- Citation checks via `.log` parsing

To install and activate the hooks:

```sh
pre-commit install
```

To update hook versions:

```sh
pre-commit autoupdate
```

See `.pre-commit-config.yaml` for configuration details.

### LaTeX Linting with ChkTeX

ChkTeX linting is supported via pre-commit hooks and Makefile targets. Suppression can be done using `% chktex <number> off` / `% chktex <number> on` comments in `.tex` files, or by passing `-n<number>` flags to ChkTeX via the Makefile or pre-commit configuration.

**Note:** Warning 1 (“Command terminated with space”) is a known false positive triggered by `\doublespacing`. This warning is globally disabled in the pre-commit configuration using `-n1`. See `.pre-commit-config.yaml` for details.

The provided `Makefile` automates compilation and conversion to multiple formats.
**Note:** This template uses `biblatex` with the `biber` backend (not BibTeX).

### Common Targets

| Target        | Description                                                                 |
|---------------|-----------------------------------------------------------------------------|
| `pdf`         | Compiles the LaTeX document into a PDF using LuaLaTeX. PDF/UA tagging is currently disabled ([why?](#pdfua-tagging-status)).   |
| `pdf-pandoc`  | Generates a PDF using Pandoc (alternative method).                          |
| `html`        | Converts the LaTeX document to HTML using Pandoc with APA citation styling. |
| `docx`        | Converts the LaTeX document to DOCX using Pandoc.                           |
| `lint`        | Runs `chktex` and checks `.log` for missing citations or references.        |
| `check`       | Displays metadata and integrity info for the compiled PDF.                  |
| `view`        | Opens the final PDF in your default Windows viewer (e.g., Acrobat).         |
| `refresh`     | Reopens the PDF to simulate a manual refresh.                               |
| `build`       | Runs `lint`, compiles the PDF, and opens it—ideal for final review.         |
| `watch`       | Watches for changes to `.tex` or `.bib` and rebuilds automatically.         |
| `submissions` | Copies the final PDF to a `submissions/` folder with a timestamp.           |
| `status`      | Lists output file sizes and last modified times.                            |
| `clean`       | Removes LaTeX build artifacts and the output directory.                     |
| `distclean`   | Removes all generated files, including outputs and submissions.             |

To use a target, run:

```sh
make <target>
```

Example:

```sh
make build
```

All outputs are placed in the `output/` directory. Archived PDFs are stored in `submissions/`.

### Manual Build Steps

If you are not using the Makefile, compile your document with:

```sh
lualatex main.tex
biber main
lualatex main.tex
lualatex main.tex
```

**Do not use `bibtex`—this template requires `biber` for bibliography processing.**

## Overleaf Compatibility

This template works with Overleaf:

- Upload all files (`main.tex`, `references.bib`, etc.) to your Overleaf project.
- In Overleaf, set the bibliography backend to **biber** (Menu → Settings → Compiler → Biber).
- Overleaf automatically runs the correct sequence (`lualatex → biber → lualatex → lualatex`).
- You can manage your bibliography in `references.bib` as usual.

## Using Zotero for References

You can use Zotero to manage your references and export them to BibLaTeX format:

1. Select your references in Zotero.
2. Right-click and choose **Export Items**.
3. Select **Better BibLaTeX** (preferred) or **BibLaTeX** as the format and save as `references.bib`.
4. Replace or merge with the existing `references.bib` in this repository.

**Note:** Install the [Better BibTeX](https://retorque.re/zotero-better-bibtex/) plugin for improved citation keys and automatic updates.

**Zotero Auto-Sync (Optional):**
- Right-click your collection → Export Collection → Enable "Keep Updated"
- Zotero will automatically update `references.bib` when you add/modify entries

## Customization

- Update the document title, author, and other fields in `main.tex` (`\title`,
  `\author`, etc.). PDF/UA metadata is not currently included ([why?](#pdfua-tagging-status)).
- Use the `biblatex` options and APA formatting as needed.
- Modify the Makefile to suit your workflow or add new targets.

## Troubleshooting

If you encounter issues:

1. **Check LaTeX Installation**: Ensure you have a working LaTeX installation and all required packages.
2. **Biber Issues**: If citations or bibliography fail, verify that Biber is installed and properly configured.
3. **Linting Errors**: Run `make lint` to catch syntax issues and missing references.
4. **Log Files**: Review `.log` files for warnings or errors.
5. **Overleaf**: Ensure the bibliography tool is set to Biber in project settings.
6. **Ask for Help**: Reach out via LaTeX forums, Stack Exchange, or GitHub Issues.

## Known Issues

- **ChkTeX Warning 1**: `\doublespacing` may trigger a false positive ("Command terminated with space"). This warning is suppressed globally via `-n1` in `.pre-commit-config.yaml`.
- **PDF/UA Tagging**: Disabled due to compatibility issues with LuaLaTeX and screen readers. Enabling it causes consistent build errors. Semantic markup is preserved, but full compliance is not guaranteed.

## Community and Support

For questions, feedback, or accessibility-related suggestions, feel free to open a GitHub Issue or reach out via [Mastodon](https://allovertheplace.ca/@RareBird15).

## Contributing

Contributions and feedback are welcome. See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## License

MIT License.

## Features

### PDF/UA Tagging Status

PDF/UA-1 tagging is **disabled** in this template due to compatibility issues with LuaLaTeX and screen readers. While semantic markup and screen reader-friendly formatting are preserved, full PDF/UA compliance is not guaranteed.

For details, see [Known Issues](#known-issues).

## File Structure

```
├── main.tex                  # Main LaTeX document (edit this)
├── references.bib            # Bibliography database
├── apa.csl                   # APA 7 citation style for Pandoc
├── Makefile                  # Build automation (PDF, HTML, DOCX, lint, etc.)
├── add-refs-heading.lua      # Pandoc filter for accessible references heading
├── .gitignore                # Ignore LaTeX build artifacts and editor backups
├── .pre-commit-config.yaml   # Pre-commit hook configuration
├── README.md                 # This file (documentation)
├── CONTRIBUTING.md           # Contribution guidelines
├── CHANGELOG.md              # Version history and release notes
├── LICENSE                   # MIT License
├── VERSION                   # Current template version
├── CITATION.cff              # Citation metadata for GitHub
├── output/                   # Build artifacts (PDF, HTML, DOCX; auto-created)
├── submissions/              # Timestamped submission copies (auto-created)
├── .github/
│   └── workflows/            # CI/CD pipeline definitions
└── .vscode/                  # VS Code settings (optional, not committed)
```

## Citation and Attribution

If you use this template for your academic work, consider acknowledging it:

**Option 1: In your paper's acknowledgments (informal):**
> This paper was formatted using the APA 7 Student Paper LaTeX Template (v1.5.0) by Lanie Molinar Carmelo, available at https://github.com/Lanie-Carmelo/APA-7-Student-Paper-Template

**Option 2: In technical documentation or derivative works:**
```bibtex
@misc{carmelo2025apa7template,
  author = {Carmelo, Lanie Molinar},
  title = {APA 7 Student Paper LaTeX Template},
  year = {2025},
  publisher = {GitHub},
  journal = {GitHub repository},
  howpublished = {\url{https://github.com/Lanie-Carmelo/APA-7-Student-Paper-Template}},
  note = {Version 1.5.0}
}
```

**Option 3: For derivative templates:**
- Keep the version header in `main.tex` intact
- Document your changes in your own CHANGELOG
- Link back to this repository in your README
- Consider contributing improvements back via pull request

### Why Attribution Matters

- Helps other students discover accessible LaTeX tools
- Supports ongoing development and maintenance
- Acknowledges accessibility advocacy in academic publishing
- Enables tracking of template usage and impact
