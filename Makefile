# Default target
all: $(TXT_TARGETS) $(PDF_TARGETS) post-process

# Define a list of source Markdown files
MD_SOURCES := GPT-instructions.md GPT-instructions-prior.md GPT-instructions-test.md Zettel-template.md 
TXT_SOURCES := $(MD_SOURCES) GPT-description.md

# The text targets are generated using a custom pandoc template
# The text targets are used for GPT instructions and the description
# The PDF targets are generated using the default pandoc template
TXT_TARGETS := $(TXT_SOURCES:.md=.txt)
PDF_TARGETS := $(MD_SOURCES:.md=.pdf)


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

charcount:
ifeq ($(OS),Windows_NT)
	@for %%f in ($(TXT_TARGETS)) do  @PowerShell -NoProfile -ExecutionPolicy Bypass -Command "$$content = [IO.File]::ReadAllText('%%f'); Write-Host '%%f: '$$content.Length"
else
	@for f in $(TXT_TARGETS); do wc -m $$f | awk '{print $$f, $$1}'; done
endif

post-process:
ifeq ($(OS),Windows_NT)
	@for %%f in ($(TXT_TARGETS)) do @(PowerShell -NoProfile -ExecutionPolicy Bypass -Command "$$content = [IO.File]::ReadAllText('%%f') -replace '\s+', ' ' -replace '\r\n', '\n' -replace '\n\n+', '\n'; [IO.File]::WriteAllText('%%f', $$content)")
else
	@for f in $(TXT_TARGETS); do sed -i 's/^[ \t]*//;s/[ \t]*$$//;s/  +/ /g;/^$$/d' $$f; done
endif

.PHONY: all clean post-process charcount

