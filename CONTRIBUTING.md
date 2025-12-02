# Contributing to APA 7 Student Paper LaTeX Template

Thank you for considering contributing to this project! Your help is welcome, whether it’s fixing bugs, improving documentation, or suggesting new features.

## How to Contribute

1. **Fork the repository** and create your branch from `main`.
2. **Make your changes** (code, documentation, or examples).
3. **Test your changes** to ensure everything builds and works as expected.
4. **Submit a pull request** with a clear description of what you’ve changed and why.

## Guidelines

- Keep the template clean and easy to use for students.
- Follow the APA 7th edition guidelines.
- Maintain screen reader compatibility and accessibility features.
- Write clear commit messages using conventional commits:
  - `feat:` for new features
  - `fix:` for bug fixes
  - `docs:` for documentation changes
  - `ci:` for CI/CD changes
  - `chore:` for maintenance tasks
- If you add new files (e.g., examples), keep them minimal and relevant.
- Test your changes thoroughly:
  - Run `make check-deps` to verify dependencies
  - Run `make lint` to check for LaTeX issues
  - Run `make pdf` to build the document
  - Run `make validate` to verify output quality
- Update documentation (README.md, CHANGELOG.md) for user-facing changes.
- Be respectful and constructive in discussions.

## Reporting Issues

When reporting bugs or issues:
- Describe what you expected to happen
- Describe what actually happened
- Include your LaTeX distribution and version
- Share relevant error messages from `.log` files
- Mention your operating system (Windows, macOS, Linux)

## Suggesting Features

Feature suggestions are welcome! Please:
- Explain the use case
- Describe how it would help students
- Check if it aligns with APA 7 guidelines

## Development Tools

### Pre-commit Hooks

This project uses pre-commit hooks for quality assurance:
```bash
pre-commit install        # Install hooks
pre-commit run --all      # Run all hooks manually
pre-commit autoupdate     # Update hook versions
```

### Makefile Targets for Contributors

```bash
make help                 # Show all available targets
make check-deps-all       # Verify all dependencies (including optional)
make lint                 # Run LaTeX linter
make validate             # Validate output quality
make clean                # Remove build artifacts
```

### Testing Changes

Before submitting a PR:
1. Ensure the template builds: `make clean && make pdf`
2. Check for errors: `make lint`
3. Validate output: `make validate`
4. Test on different platforms if possible (Linux, macOS, Windows)
5. Verify accessibility features are preserved

## Code Review Process

All contributions go through code review:
- Automated checks must pass (CI/CD pipeline)
- At least one maintainer approval required
- Changes must maintain APA 7 compliance
- Accessibility features must be preserved
- Documentation must be updated for user-facing changes

## Need Help?

If you have questions, feel free to:
- Open an issue for bugs or feature requests
- Start a discussion for general questions
- Reach out to the maintainer on [Mastodon](https://allovertheplace.ca/@RareBird15)

Thank you for helping improve this project!
