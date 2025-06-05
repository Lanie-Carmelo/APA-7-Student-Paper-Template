
# Makefile for LaTeX project

# Variables
TEXFILE = main.tex
BIBFILE = references.bib
CSLFILE = apa.csl
OUTPUT_DIR = output

# Default target
all: pdf html docx

# PDF target
pdf:
	pdflatex $(TEXFILE)
	biber $(basename $(TEXFILE))
	pdflatex $(TEXFILE)
	pdflatex $(TEXFILE)

# HTML target
html: $(BIBFILE)
	pandoc $(TEXFILE) --citeproc --bibliography=$(BIBFILE) --csl=$(CSLFILE) -s -o $(OUTPUT_DIR)/main.html

# DOCX target
docx: $(BIBFILE)
	pandoc $(TEXFILE) --citeproc --bibliography=$(BIBFILE) --csl=$(CSLFILE) -s -o $(OUTPUT_DIR)/main.docx

# Clean target
clean:
	rm -f *.aux *.bbl *.blg *.log *.out *.toc *.bcf *.run.xml
	rm -rf $(OUTPUT_DIR)

# Ensure output directory exists
$(OUTPUT_DIR):
	mkdir -p $(OUTPUT_DIR)

# Dependencies
html: $(OUTPUT_DIR)
docx: $(OUTPUT_DIR)
