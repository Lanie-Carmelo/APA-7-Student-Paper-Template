# Simplified Makefile for LaTeX project with Pandoc output

# Variables
MAIN = main
TEXFILE = $(MAIN).tex
BIBFILE = references.bib
OUTPUT_DIR = output

# Create submissions directory
submissions-dir:
	mkdir -p submissions

# Default target
all: pdf html docx

# PDF target
pdf:
	mkdir -p $(OUTPUT_DIR)
	lualatex $(TEXFILE)
	biber $(MAIN)
	lualatex $(TEXFILE)
	lualatex $(TEXFILE)
	mv $(MAIN).pdf $(OUTPUT_DIR)/

# PDF target using Pandoc
pdf-pandoc:
	pandoc $(TEXFILE) \
		--pdf-engine=lualatex \
		--bibliography=$(BIBFILE) \
		--csl=apa.csl \
		-o $(OUTPUT_DIR)/main-pandoc.pdf

# HTML target using Pandoc (with language metadata for accessibility)
html: $(TEXFILE) $(BIBFILE) | $(OUTPUT_DIR)
	pandoc $(TEXFILE) \
		--bibliography=$(BIBFILE) \
		--csl=apa.csl \
		--citeproc \
		--standalone \
		--metadata lang=en \
		--shift-heading-level-by=1 \
		-o $(OUTPUT_DIR)/main.html

# DOCX target using Pandoc
docx: $(BIBFILE) | $(OUTPUT_DIR)
	pandoc $(TEXFILE) \
		--output=$(OUTPUT_DIR)/main.docx \
		--bibliography=$(BIBFILE) \
		--csl=apa.csl

# Check target to verify PDF integrity
check:
		pdfinfo $(MAIN).pdf

# Status target to show last modified time of created files
status:
	@echo "📄 Output file status:"
	@ls -lh $(OUTPUT_DIR)/main.pdf $(OUTPUT_DIR)/main.html $(OUTPUT_DIR)/main.docx 2>/dev/null || echo "No output files found."

# Open PDF with default viewer
view:
		powershell.exe Start-Process "$(shell wslpath -w $(OUTPUT_DIR)/$(MAIN).pdf)"

# Lint, build, and view
build: lint pdf view

# Refresh open PDF
refresh:
		powershell.exe Start-Process "$(shell wslpath -w $(OUTPUT_DIR)/$(MAIN).pdf)"

# Watch for changes (requires inotify-tools)
watch:
	while true; do \
		inotifywait -e modify $(TEXFILE) $(BIBFILE); \
		make pdf; \
	done

# Lint target (requires chktex)
lint:
	chktex -q -n22 -n30 $(TEXFILE)
	@grep -Ei "undefined|citation|reference" $(MAIN).log || true

# Submissions target
submissions: pdf | submissions-dir
	cp $(OUTPUT_DIR)/$(MAIN).pdf submissions/$(MAIN)-$(shell date +%Y%m%d-%H%M).pdf

# Clean target
clean:
	rm -f *.aux *.bbl *.blg *.log *.out *.toc *.bcf *.run.xml
	rm -rf $(OUTPUT_DIR)

# Distclean target to remove all generated files
distclean: clean
	rm -f $(OUTPUT_DIR)/$(MAIN).pdf $(OUTPUT_DIR)/main.html $(OUTPUT_DIR)/main.docx $(OUTPUT_DIR)/main-pandoc.pdf

# Ensure output directory exists
$(OUTPUT_DIR):
	mkdir -p $(OUTPUT_DIR)

# Phony targets
.PHONY: all pdf html docx clean check view refresh lint build submissions status

