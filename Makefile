# Define a list of source Markdown files
MD_SOURCES := GPT-instructions.md GPT-instructions-prior.md GPT-instructions-test.md Zettel-template.md 
TXT_SOURCES := $(MD_SOURCES) GPT-description.md

# Define the target formats you want from each source
TXT_TARGETS := $(TXT_SOURCES:.md=.txt)
PDF_TARGETS := $(MD_SOURCES:.md=.pdf)

# Default target
all: $(TXT_TARGETS) $(PDF_TARGETS)

# Rule to convert Markdown to text
%.txt: %.md
	pandoc --defaults strip-markdown.yaml $< -o $@

# Rule to convert Markdown to PDF
%.pdf: %.md
	pandoc $< -o $@

# Clean target for removing all generated files
ifeq ($(OS),Windows_NT)
    RM = del /Q
else
    RM = rm -f
endif

clean:
	$(RM) $(TXT_TARGETS) $(PDF_TARGETS)

.PHONY: all clean
