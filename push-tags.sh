#!/bin/bash
# Script to push missing tags v1.5.0 and v1.6.0 to GitHub
# This will trigger the automatic release workflow

set -e  # Exit on error

echo "🏷️  Pushing missing tags for APA 7 Student Paper Template"
echo ""

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "❌ Error: Not in a git repository"
    exit 1
fi

# Verify tags exist locally
echo "📋 Verifying local tags..."
if ! git rev-parse v1.5.0 >/dev/null 2>&1; then
    echo "❌ Error: Tag v1.5.0 not found locally"
    echo "   Run: git tag -a v1.5.0 7bdcec3 -m 'Release v1.5.0 - Update template version and refine layout for APA compliance'"
    exit 1
fi

if ! git rev-parse v1.6.0 >/dev/null 2>&1; then
    echo "❌ Error: Tag v1.6.0 not found locally"
    echo "   Run: git tag -a v1.6.0 d951c5d -m 'Release v1.6.0 - Enhance build system, validation, and documentation'"
    exit 1
fi

echo "✅ Both tags found locally"
echo ""

# Show tag details
echo "📌 Tag details:"
echo ""
git show v1.5.0 --no-patch --format="v1.5.0: %s (commit: %h, date: %ai)"
git show v1.6.0 --no-patch --format="v1.6.0: %s (commit: %h, date: %ai)"
echo ""

# Confirm before pushing
echo "⚠️  This will push tags to GitHub and trigger automatic release creation."
read -p "Do you want to proceed? (y/n): " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "❌ Operation cancelled"
    exit 1
fi

# Push tags
echo ""
echo "📤 Pushing tags to origin..."
git push origin v1.5.0 v1.6.0

echo ""
echo "✅ Tags pushed successfully!"
echo ""
echo "🔄 Next steps:"
echo "   1. Check GitHub Actions: https://github.com/Lanie-Carmelo/APA-7-Student-Paper-Template/actions"
echo "   2. Wait for 'Create Release' workflow to complete (~1-2 minutes)"
echo "   3. Verify releases: https://github.com/Lanie-Carmelo/APA-7-Student-Paper-Template/releases"
echo "   4. You should see new releases for v1.5.0 and v1.6.0"
echo ""
echo "✨ Done!"
