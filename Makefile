# Define a list of source Markdown files
MD_INSTRUCTIONS := GPT-instructions.md 
MD_DESCRIPTION  := GPT-description.md
#MD_TEMPLATE     := Zettel-template.md
TXT_SOURCES    := $(MD_INSTRUCTIONS) $(MD_DESCRIPTION)
#MD_SOURCES := $(MD_INSTRUCTIONS) $(MD_DESCRIPTION) $(MD_TEMPLATE)
MD_SOURCES := $(MD_INSTRUCTIONS) $(MD_DESCRIPTION)

# The text targets are generated using a custom pandoc template
# The text targets are used for GPT instructions and the description
# The PDF targets are generated using the default pandoc template
TXT_TARGETS := $(TXT_SOURCES:.md=.txt)
PDF_TARGETS := $(MD_SOURCES:.md=.pdf)

# Eliminate conflict with built-in RM
RM := /usr/bin/rm -f

# Default target
all: $(TXT_TARGETS) $(PDF_TARGETS) post-process charcount

# Rule to convert Markdown to text
%.txt: %.md
	pandoc -f markdown -t plain $< -o $@

# Rule to convert Markdown to PDF
%.pdf: %.md
	pandoc $< -o $@

print-RM:
	@echo "RM is set to $(RM)"

# Clean target for removing all generated files
clean:
ifeq ($(OS),Windows_NT)
	$(foreach f,$(TXT_TARGETS) $(PDF_TARGETS),PowerShell -NoProfile -ExecutionPolicy Bypass -Command "Remove-Item -ErrorAction SilentlyContinue -Path '${f}'";)
else
	$(RM) $(TXT_TARGETS) $(PDF_TARGETS)
endif

post-process:
ifeq ($(OS),Windows_NT)
	@$(foreach f,$(TXT_TARGETS), \
		pwsh -noprofile -command ".\replace.ps1 -FilePath '.\$(f)'"; \
		echo "Processed $(f)";)
else
	@for f in $(TXT_TARGETS); do sed -i 's/[ \t][ \t]*/ /g' $$f; echo "Processed $$f"; done
	# Special processing for GPT-description.txt
	@sed -i '1,2d' GPT-description.txt; echo "Processed GPT-description.txt"
endif

charcount:
ifeq ($(OS),Windows_NT)
	@$(foreach f,$(TXT_TARGETS), \
		pwsh -noprofile -command ".\charcount.ps1 -FilePath '.\$(f)'";)
else
	@for f in $(TXT_TARGETS); do \
		count=$$(wc -m < "$$f" | awk '{print $$1}'); \
		if [ "$$f" = "GPT-description.txt" ] && [ $$count -gt 300 ]; then \
			echo "$$f: TOO LONG ($$count characters, max 300)"; \
		elif [ $$count -le 8000 ]; then \
			echo "$$f: OK ($$count characters)"; \
		else \
			echo "$$f: TOO LONG ($$count characters)"; \
		fi; \
	done
endif

.PHONY: all clean charcount print-RM post-process
