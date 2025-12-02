# Instructions for Creating Missing Tags

## Overview
This document provides instructions for manually creating and pushing the missing git tags for v1.5.0 and v1.6.0.

## Missing Tags Identified

The CHANGELOG.md documents releases v1.5.0 and v1.6.0, but these tags don't exist in the repository. This prevents the automatic release workflow from creating GitHub releases for these versions.

### Tags to Create:

1. **v1.5.0** - Points to commit `7bdcec373dc5ce0509a17149973d242fd62280b8`
   - Release Date: October 27, 2025
   - Commit Message: "chore: release v1.5.0 - Update template version and refine layout for APA compliance"
   
2. **v1.6.0** - Points to commit `d951c5d3ab2df73143e33f51da4aebe99b93fe74`
   - Release Date: December 1, 2025 (commit date), December 2, 2025 (CHANGELOG date)
   - Commit Message: "feat: enhance build system, validation, and documentation (v1.6.0) (#18)"

## Commands to Execute

### Option 1: Create and Push Tags Individually

```bash
# Navigate to repository
cd /path/to/APA-7-Student-Paper-Template

# Create v1.5.0 tag
git tag -a v1.5.0 7bdcec373dc5ce0509a17149973d242fd62280b8 -m "Release v1.5.0 - Update template version and refine layout for APA compliance"

# Create v1.6.0 tag
git tag -a v1.6.0 d951c5d3ab2df73143e33f51da4aebe99b93fe74 -m "Release v1.6.0 - Enhance build system, validation, and documentation"

# Push both tags to remote
git push origin v1.5.0 v1.6.0
```

### Option 2: Use Short Commit SHAs (if preferred)

```bash
# Create v1.5.0 tag
git tag -a v1.5.0 7bdcec3 -m "Release v1.5.0 - Update template version and refine layout for APA compliance"

# Create v1.6.0 tag
git tag -a v1.6.0 d951c5d -m "Release v1.6.0 - Enhance build system, validation, and documentation"

# Push both tags to remote
git push origin v1.5.0 v1.6.0
```

## Verification Steps

After pushing the tags, verify they were created successfully:

```bash
# Check local tags
git tag -l

# Verify tags point to correct commits
git show v1.5.0 --no-patch --format="%H %s"
git show v1.6.0 --no-patch --format="%H %s"

# Check remote tags
git ls-remote --tags origin
```

## Expected Outcome

1. **Tags Created**: Both v1.5.0 and v1.6.0 tags will exist in the repository
2. **Automatic Release Creation**: The `.github/workflows/release.yml` workflow will automatically trigger when tags are pushed
3. **GitHub Releases Created**: Within a few minutes, GitHub releases will be created for both versions:
   - Release notes will be automatically extracted from CHANGELOG.md
   - Releases will appear at: https://github.com/Lanie-Carmelo/APA-7-Student-Paper-Template/releases

## Monitoring Release Creation

After pushing tags, check:
1. **Actions Tab**: https://github.com/Lanie-Carmelo/APA-7-Student-Paper-Template/actions
   - Look for "Create Release" workflow runs
2. **Releases Page**: https://github.com/Lanie-Carmelo/APA-7-Student-Paper-Template/releases
   - Verify v1.5.0 and v1.6.0 releases appear

## What's in the Release Notes

The release workflow extracts content from CHANGELOG.md between version headers:

### v1.5.0 Release Notes (from CHANGELOG):
- Title page layout and metadata fields clarified
- Page counter reset so main content starts at page 1
- Section structure and placeholders updated for APA format
- Instructor and course fields separated and formatted per APA guidelines
- General template refinements for student papers

### v1.6.0 Release Notes (from CHANGELOG):
**Added:**
- Quick Start Guide (QUICKSTART.md)
- Dependency checking targets
- Output validation script
- Enhanced Makefile with better error handling
- Enhanced Dependabot configuration
- Concurrency control in CI workflow
- Pre-commit hooks for checking executable shebangs

**Changed:**
- Makefile now validates dependencies before attempting builds
- Improved CI caching strategy
- Enhanced .gitignore

**Fixed:**
- Makefile now handles missing optional tools gracefully

See CHANGELOG.md for complete details.

## Troubleshooting

### If Tags Already Exist
If you get an error that tags already exist:
```bash
# Delete local tag
git tag -d v1.5.0
git tag -d v1.6.0

# Delete remote tag (if needed)
git push origin --delete v1.5.0
git push origin --delete v1.6.0

# Recreate tags with commands above
```

### If Release Workflow Doesn't Trigger
1. Check that the tag name matches the pattern `v*.*.*` (must start with 'v')
2. Verify the workflow file exists at `.github/workflows/release.yml`
3. Check Actions tab for any errors
4. Ensure the GitHub token has `contents: write` permission

### If Release Notes Are Empty
The workflow extracts content between `## [X.Y.Z]` headers in CHANGELOG.md. Verify:
1. CHANGELOG.md has properly formatted version headers
2. Version numbers match (e.g., `## [1.5.0]` for tag `v1.5.0`)
3. Content exists between the version header and the next version header

## Additional Notes

- **Tag Format**: Tags use annotated format (`-a` flag) which includes tagger information and can be verified with GPG signatures
- **Tag Messages**: Keep messages concise but descriptive
- **Semantic Versioning**: This project follows semantic versioning (major.minor.patch)
- **Automated Process**: After this initial catch-up, future releases should be tagged promptly when CHANGELOG is updated
