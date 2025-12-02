#!/bin/bash
# Script to validate LaTeX output files for quality and accessibility

set -e

OUTPUT_DIR="output"
MAIN_PDF="${OUTPUT_DIR}/main.pdf"
MAIN_HTML="${OUTPUT_DIR}/main.html"
MAIN_DOCX="${OUTPUT_DIR}/main.docx"

echo "🔍 Validating output files..."

# Check if PDF exists
if [ ! -f "$MAIN_PDF" ]; then
    echo "❌ PDF not found: $MAIN_PDF"
    exit 1
fi

echo "✓ PDF exists: $MAIN_PDF"

# Check PDF size (should be at least 10KB)
PDF_SIZE=$(stat -f%z "$MAIN_PDF" 2>/dev/null || stat -c%s "$MAIN_PDF" 2>/dev/null)
if [ "$PDF_SIZE" -lt 10240 ]; then
    echo "⚠ Warning: PDF seems too small (${PDF_SIZE} bytes)"
else
    echo "✓ PDF size looks reasonable (${PDF_SIZE} bytes)"
fi

# Check for common LaTeX errors in log file
if [ -f "${OUTPUT_DIR}/main.log" ]; then
    echo "🔍 Checking log file for errors..."
    
    if grep -q "Error" "${OUTPUT_DIR}/main.log"; then
        echo "⚠ Warning: Errors found in log file"
        grep "Error" "${OUTPUT_DIR}/main.log" | head -5
    else
        echo "✓ No errors in log file"
    fi
    
    if grep -q "Citation.*undefined" "${OUTPUT_DIR}/main.log"; then
        echo "⚠ Warning: Undefined citations found"
        grep "Citation.*undefined" "${OUTPUT_DIR}/main.log"
    else
        echo "✓ No undefined citations"
    fi
    
    if grep -q "Reference.*undefined" "${OUTPUT_DIR}/main.log"; then
        echo "⚠ Warning: Undefined references found"
        grep "Reference.*undefined" "${OUTPUT_DIR}/main.log"
    else
        echo "✓ No undefined references"
    fi
fi

# Check optional HTML output
if [ -f "$MAIN_HTML" ]; then
    echo "✓ HTML exists: $MAIN_HTML"
    
    # Check for lang attribute (accessibility)
    if grep -q 'lang="en-US"' "$MAIN_HTML" || grep -q "lang='en-US'" "$MAIN_HTML"; then
        echo "✓ HTML has language metadata (accessibility)"
    else
        echo "⚠ Warning: HTML missing language metadata"
    fi
    
    # Check for semantic HTML
    if grep -q "<article" "$MAIN_HTML" || grep -q "<section" "$MAIN_HTML"; then
        echo "✓ HTML uses semantic markup"
    fi
else
    echo "ℹ HTML not generated (optional)"
fi

# Check optional DOCX output
if [ -f "$MAIN_DOCX" ]; then
    echo "✓ DOCX exists: $MAIN_DOCX"
    DOCX_SIZE=$(stat -f%z "$MAIN_DOCX" 2>/dev/null || stat -c%s "$MAIN_DOCX" 2>/dev/null)
    echo "  Size: ${DOCX_SIZE} bytes"
else
    echo "ℹ DOCX not generated (optional)"
fi

echo ""
echo "✅ Validation complete!"
