# Quick Start Guide

This is a condensed guide for getting started quickly with the APA 7 Student Paper LaTeX Template.

## Installation

### 1. Install Required Tools

**Ubuntu/Debian:**
```bash
sudo apt install texlive-luatex biber
```

**macOS:**
```bash
brew install --cask mactex
```

**Windows:**
- Download and install [MikTeX](https://miktex.org/) or [TeX Live](https://www.tug.org/texlive/)

### 2. Install Optional Tools

For HTML/DOCX output:
```bash
# Ubuntu/Debian
sudo apt install pandoc

# macOS
brew install pandoc
```

For linting:
```bash
# Ubuntu/Debian
sudo apt install chktex

# macOS
brew install chktex
```

## Quick Commands

### Verify Setup
```bash
make check-deps     # Check required dependencies
make check-deps-all # Check all dependencies
```

### Build Your Paper
```bash
make pdf            # Build PDF (most common)
make html           # Build HTML version
make docx           # Build Word document
make all            # Build all formats
```

### Development Workflow
```bash
make build          # Lint + build + open PDF
make lint           # Check for LaTeX errors
make validate       # Validate output quality
make clean          # Remove temporary files
```

### Get Help
```bash
make help           # Show all available commands
```

## Editing Your Paper

1. **Open `main.tex`** in your favorite editor
2. **Edit the metadata** (title, author, course info)
3. **Write your content** (replace placeholder text)
4. **Add citations** using `\parencite{key}` or `\textcite{key}`
5. **Add references** to `references.bib`
6. **Build**: Run `make pdf`

## Common Citation Commands

```latex
\parencite{smith2020}                    % (Smith, 2020)
\textcite{smith2020}                     % Smith (2020)
\parencite{smith2020,doe2021}           % (Doe, 2021; Smith, 2020)
\parencite[p.~42]{smith2020}            % (Smith, 2020, p. 42)
\parencite[see][pp.~10--15]{smith2020}  % (see Smith, 2020, pp. 10-15)
```

## Managing References with Zotero

1. Install [Zotero](https://www.zotero.org/)
2. Install [Better BibTeX](https://retorque.re/zotero-better-bibtex/) plugin
3. Export your collection:
   - Right-click collection → Export Collection
   - Choose "Better BibLaTeX" format
   - Save as `references.bib`
   - Optional: Enable "Keep Updated" for auto-sync

## Troubleshooting

### Citations not appearing?
```bash
make clean  # Remove old build files
make pdf    # Full rebuild
```

### Missing font errors?
Edit `main.tex` and change:
```latex
\setmainfont{Liberation Serif}  % Instead of Times New Roman
```

### More help?
See the full [README.md](README.md) for detailed troubleshooting.

## Submitting Your Paper

```bash
make submissions  # Copies PDF to submissions/ with timestamp
```

## Overleaf Users

1. Upload all files to your Overleaf project
2. Go to Menu → Settings
3. Set Compiler to **LuaLaTeX**
4. Set Bibliography to **Biber**
5. Compile!

## Next Steps

- Read the full [README.md](README.md) for detailed documentation
- Check [CONTRIBUTING.md](CONTRIBUTING.md) if you want to contribute
- Review [CHANGELOG.md](CHANGELOG.md) for version history
- See [LICENSE](LICENSE) for usage terms

## Support

- 🐛 [Report bugs](https://github.com/Lanie-Carmelo/APA-7-Student-Paper-Template/issues)
- 💬 [Get help](https://github.com/Lanie-Carmelo/APA-7-Student-Paper-Template/discussions)
- 🐘 [Contact maintainer](https://allovertheplace.ca/@RareBird15)
