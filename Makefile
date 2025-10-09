# Simplified Makefile for LaTeX project with Pandoc output

# Variables
TEXFILE = main.tex
BIBFILE = references.bib
OUTPUT_DIR = output

# Default target
all: pdf html docx

# PDF target
pdf:
	lualatex $(TEXFILE)
	biber main
	lualatex $(TEXFILE)
	lualatex $(TEXFILE)

# HTML target using Pandoc (with language metadata for accessibility)
html: $(TEXFILE) $(BIBFILE) | $(OUTPUT_DIR)
	pandoc $(TEXFILE) \
		--bibliography=$(BIBFILE) \
		--csl=apa.csl \
		--citeproc \
		--standalone \
		--metadata lang=en \
		-o $(OUTPUT_DIR)/main.html

# DOCX target using Pandoc
docx: $(BIBFILE) | $(OUTPUT_DIR)
	pandoc $(TEXFILE) \
		--output=$(OUTPUT_DIR)/main.docx \
		--bibliography=$(BIBFILE) \
		--csl=apa.csl

# Clean target
clean:
	rm -f *.aux *.bbl *.blg *.log *.out *.toc *.bcf *.run.xml
	rm -rf $(OUTPUT_DIR)

# Ensure output directory exists
$(OUTPUT_DIR):
	mkdir -p $(OUTPUT_DIR)
