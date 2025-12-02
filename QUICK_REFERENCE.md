# Quick Reference - Tag Creation

## TL;DR - What to Do

```bash
# 1. Navigate to repository root
cd /path/to/APA-7-Student-Paper-Template

# 2. Run the script (easiest method)
./push-tags.sh

# 3. Verify releases appear (wait ~2 minutes)
# Visit: https://github.com/Lanie-Carmelo/APA-7-Student-Paper-Template/releases

# 4. (Optional) Delete obsolete branch
git push origin --delete release/v1.2.0
```

## What This Does

- Pushes tags v1.5.0 and v1.6.0 to GitHub
- Triggers automatic release creation workflow
- Creates GitHub releases with notes from CHANGELOG.md
- Completes release history (v1.0.0 → v1.6.0)

## Alternative: Manual Commands

If you prefer not to use the script:

```bash
git push origin v1.5.0 v1.6.0
```

## Verification

Check these URLs after pushing:

1. **Actions**: https://github.com/Lanie-Carmelo/APA-7-Student-Paper-Template/actions
   - Should see 2 "Create Release" workflows running

2. **Releases**: https://github.com/Lanie-Carmelo/APA-7-Student-Paper-Template/releases
   - Should see v1.5.0 and v1.6.0 releases

## Documentation

For detailed information, see:

- `SUMMARY.md` - Complete overview of findings and actions
- `TAG_CREATION_INSTRUCTIONS.md` - Detailed instructions and troubleshooting
- `RELEASE_BRANCH_ANALYSIS.md` - Analysis of release/v1.2.0 branch

## Cleanup (Optional)

After successfully pushing tags and verifying releases:

```bash
# Remove temporary documentation files
git rm QUICK_REFERENCE.md SUMMARY.md TAG_CREATION_INSTRUCTIONS.md \
        RELEASE_BRANCH_ANALYSIS.md push-tags.sh
git commit -m "chore: remove temporary tag creation documentation"
git push origin main
```

## Questions?

If something goes wrong:
1. Check GitHub Actions for error messages
2. Review TAG_CREATION_INSTRUCTIONS.md troubleshooting section
3. Open an issue if you need help
