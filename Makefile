# Makefile for APA 7 Student Paper LaTeX Template
# Supports PDF, HTML, and DOCX output with automated linting and quality checks

# Variables
MAIN = main
TEXFILE = $(MAIN).tex
BIBFILE = references.bib
OUTPUT_DIR = output
SUBMISSIONS_DIR = submissions

# Tool detection
LUALATEX := $(shell command -v lualatex 2> /dev/null)
BIBER := $(shell command -v biber 2> /dev/null)
PANDOC := $(shell command -v pandoc 2> /dev/null)
CHKTEX := $(shell command -v chktex 2> /dev/null)

# Create submissions directory
submissions-dir:
	mkdir -p $(SUBMISSIONS_DIR)

# Check for required dependencies
check-deps:
	@echo "🔍 Checking required dependencies..."
	@echo -n "  LuaLaTeX: "
	@if [ -n "$(LUALATEX)" ]; then echo "✓ found"; else echo "✗ not found - install texlive-luatex"; exit 1; fi
	@echo -n "  Biber: "
	@if [ -n "$(BIBER)" ]; then echo "✓ found"; else echo "✗ not found - install biber"; exit 1; fi
	@echo -n "  ChkTeX (optional): "
	@if [ -n "$(CHKTEX)" ]; then echo "✓ found"; else echo "⚠ not found - linting will be skipped"; fi
	@echo "✅ Core dependencies satisfied"

# Check for optional dependencies
check-deps-all: check-deps
	@echo -n "  Pandoc: "
	@if [ -n "$(PANDOC)" ]; then echo "✓ found"; else echo "⚠ not found - HTML/DOCX output unavailable"; fi

# Default target
all: check-deps pdf html docx

# PDF target
pdf: check-deps | $(OUTPUT_DIR)
	@echo "📄 Building PDF with LuaLaTeX..."
	@lualatex -interaction=nonstopmode -output-directory=$(OUTPUT_DIR) $(TEXFILE) || { echo "❌ LaTeX compilation failed"; exit 1; }
	@cp $(BIBFILE) $(OUTPUT_DIR)/ 2>/dev/null || true
	@echo "📚 Processing bibliography with Biber..."
	@cd $(OUTPUT_DIR) && biber $(MAIN) || { echo "❌ Biber processing failed"; exit 1; }
	@echo "📄 Second LaTeX pass..."
	@lualatex -interaction=nonstopmode -output-directory=$(OUTPUT_DIR) $(TEXFILE) > /dev/null
	@echo "📄 Final LaTeX pass..."
	@lualatex -interaction=nonstopmode -output-directory=$(OUTPUT_DIR) $(TEXFILE) > /dev/null
	@echo "✅ PDF build complete: $(OUTPUT_DIR)/$(MAIN).pdf"

# PDF target using Pandoc
pdf-pandoc: | $(OUTPUT_DIR)
	@if [ -z "$(PANDOC)" ]; then echo "❌ Pandoc not found. Install pandoc first."; exit 1; fi
	@echo "📄 Building PDF with Pandoc..."
	@pandoc $(TEXFILE) \
		--pdf-engine=lualatex \
		--bibliography=$(BIBFILE) \
		--csl=apa.csl \
		-o $(OUTPUT_DIR)/main-pandoc.pdf
	@echo "✅ Pandoc PDF complete: $(OUTPUT_DIR)/main-pandoc.pdf"

# HTML target using Pandoc (with language metadata for accessibility)
html: $(TEXFILE) $(BIBFILE) | $(OUTPUT_DIR)
	@if [ -z "$(PANDOC)" ]; then echo "❌ Pandoc not found. Install pandoc first."; exit 1; fi
	@echo "🌐 Building HTML with Pandoc..."
	@pandoc $(TEXFILE) \
		--from latex \
		--to html \
		--standalone \
		--shift-heading-level-by=1 \
		--citeproc \
		--csl=apa.csl \
		--bibliography=$(BIBFILE) \
		--lua-filter=add-refs-heading.lua \
		--metadata lang=en-US \
		--output $(OUTPUT_DIR)/$(MAIN).html
	@echo "✅ HTML build complete: $(OUTPUT_DIR)/$(MAIN).html"

# DOCX target using Pandoc
docx: $(TEXFILE) $(BIBFILE) | $(OUTPUT_DIR)
	@if [ -z "$(PANDOC)" ]; then echo "❌ Pandoc not found. Install pandoc first."; exit 1; fi
	@echo "📝 Building DOCX with Pandoc..."
	@pandoc $(TEXFILE) \
		--output=$(OUTPUT_DIR)/main.docx \
		--bibliography=$(BIBFILE) \
		--csl=apa.csl \
		--citeproc
	@echo "✅ DOCX build complete: $(OUTPUT_DIR)/main.docx"

# Check target to verify PDF integrity
check:
	@if command -v pdfinfo >/dev/null 2>&1; then \
		pdfinfo $(OUTPUT_DIR)/$(MAIN).pdf; \
	else \
		echo "⚠ pdfinfo not found - skipping PDF metadata check"; \
	fi

# Validate output files for quality and accessibility
validate:
	@if [ -x scripts/validate-output.sh ]; then \
		./scripts/validate-output.sh; \
	else \
		echo "❌ Validation script not found or not executable"; \
		exit 1; \
	fi

# Status target to show last modified time of created files
status:
	@echo "📄 Output file status:"
	@ls -lh $(OUTPUT_DIR)/main.pdf $(OUTPUT_DIR)/main.html $(OUTPUT_DIR)/main.docx 2>/dev/null || echo "No output files found."

# Open PDF with default viewer
view:
	@if [ -f $(OUTPUT_DIR)/$(MAIN).pdf ]; then \
		sh -c 'cmd.exe /c start "" "$$(wslpath -w $(OUTPUT_DIR)/$(MAIN).pdf)"'; \
	else \
		echo "Error: PDF not found. Run 'make pdf' first."; \
	fi

# Lint, build, and view
build: lint pdf view

# Refresh open PDF
refresh:
	sh -c 'cmd.exe /c start "" "$$(wslpath -w $(OUTPUT_DIR)/$(MAIN).pdf)"'

# Watch for changes (requires inotify-tools)
watch:
	while true; do \
		inotifywait -e modify $(TEXFILE) $(BIBFILE); \
		make pdf; \
	done

# Lint target (requires chktex)
lint:
	@echo "🔍 Running LaTeX linter..."
	@if [ -n "$(CHKTEX)" ]; then \
		chktex -q -n22 -n30 $(TEXFILE) || true; \
	else \
		echo "⚠ ChkTeX not found - skipping lint check"; \
	fi
	@if [ -f $(OUTPUT_DIR)/$(MAIN).log ]; then \
		echo "🔍 Checking log for errors..."; \
		grep -Ei "undefined|citation|reference" $(OUTPUT_DIR)/$(MAIN).log || true; \
	fi

# Submissions target
submissions: pdf | submissions-dir
	cp $(OUTPUT_DIR)/$(MAIN).pdf $(SUBMISSIONS_DIR)/$(MAIN)-$(shell date +%Y%m%d-%H%M).pdf
	@echo "✅ Submission saved to $(SUBMISSIONS_DIR)/$(MAIN)-$(shell date +%Y%m%d-%H%M).pdf"

# Clean target - remove intermediate files
clean:
	@echo "🧹 Cleaning intermediate files..."
	@rm -f *.aux *.bbl *.blg *.log *.out *.toc *.bcf *.run.xml *.fls *.fdb_latexmk *.synctex.gz
	@rm -rf $(OUTPUT_DIR)/*.aux $(OUTPUT_DIR)/*.bbl $(OUTPUT_DIR)/*.blg $(OUTPUT_DIR)/*.log \
		   $(OUTPUT_DIR)/*.out $(OUTPUT_DIR)/*.toc $(OUTPUT_DIR)/*.bcf $(OUTPUT_DIR)/*.run.xml \
		   $(OUTPUT_DIR)/*.fls $(OUTPUT_DIR)/*.fdb_latexmk $(OUTPUT_DIR)/*.synctex.gz $(OUTPUT_DIR)/*.bib
	@echo "✅ Cleanup complete"

# Distclean target to remove all generated files
distclean: clean
	@echo "🧹 Removing all generated files..."
	@rm -rf $(OUTPUT_DIR) $(SUBMISSIONS_DIR)
	@echo "✅ Deep cleanup complete"

# Ensure output directory exists
$(OUTPUT_DIR):
	mkdir -p $(OUTPUT_DIR)

# Help target
help:
	@echo "📚 APA 7 Student Paper LaTeX Template - Makefile Help"
	@echo ""
	@echo "Build Targets:"
	@echo "  all            - Build PDF, HTML, and DOCX (checks dependencies)"
	@echo "  pdf            - Build PDF using LuaLaTeX (recommended)"
	@echo "  pdf-pandoc     - Build PDF using Pandoc (alternative)"
	@echo "  html           - Build HTML using Pandoc"
	@echo "  docx           - Build DOCX using Pandoc"
	@echo ""
	@echo "Development Targets:"
	@echo "  build          - Lint, build PDF, and view (full workflow)"
	@echo "  lint           - Run ChkTeX linter and check for errors"
	@echo "  validate       - Validate output files for quality and accessibility"
	@echo "  watch          - Watch for changes and rebuild (requires inotify-tools)"
	@echo "  check          - Display PDF metadata and integrity info"
	@echo ""
	@echo "Utility Targets:"
	@echo "  check-deps     - Verify required dependencies are installed"
	@echo "  check-deps-all - Check all dependencies (including optional)"
	@echo "  view           - Open PDF in default viewer"
	@echo "  refresh        - Reopen PDF (useful during editing)"
	@echo "  submissions    - Copy PDF to submissions/ with timestamp"
	@echo "  status         - Show output file sizes and modification times"
	@echo ""
	@echo "Cleanup Targets:"
	@echo "  clean          - Remove intermediate LaTeX files"
	@echo "  distclean      - Remove all generated files (output/ and submissions/)"
	@echo ""
	@echo "Help:"
	@echo "  help           - Show this help message"
	@echo ""
	@echo "📖 For more information, see README.md"

# Phony targets (targets that don't represent files)
.PHONY: all pdf pdf-pandoc html docx clean distclean check validate view refresh lint build submissions submissions-dir status help watch check-deps check-deps-all
