# Define a list of source Markdown files
MD_INSTRUCTIONS := GPT-instructions.md GPT-instructions-prior.md GPT-instructions-test.md
MD_DESCRIPTION  := GPT-description.md
MD_TEMPLATE     := Zettel-template.md
MD_SOURCES := $(MD_INSTRUCTIONS) $(MD_DESCRIPTION) $(MD_TEMPLATE)

# The text targets are generated using a custom pandoc template
# The text targets are used for GPT instructions and the description
# The PDF targets are generated using the default pandoc template
TXT_TARGETS := $(MD_SOURCES:.md=.txt)
PDF_TARGETS := $(MD_SOURCES:.md=.pdf)

# Eliminate conflict with built-in RM
RM := /usr/bin/rm -f

# Default target
all: $(TXT_TARGETS) $(PDF_TARGETS)

# Rule to convert Markdown to text
%.txt: %.md
	echo Generating $@ from $<
	echo pandoc --lua-filter=remove-spaces-and-newlines.lua --defaults strip-markdown.yaml $< -o $@
	pandoc --lua-filter=remove-spaces-and-newlines.lua --defaults strip-markdown.yaml $< -o $@
	echo Generated $@

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


charcount:
ifeq ($(OS),Windows_NT)
	@$(foreach f,$(TXT_TARGETS), \
		PowerShell -NoProfile -ExecutionPolicy Bypass -Command \
		"$$content = Get-Content '${f}' -Raw; \
		if ('${f}' -match 'GPT-instructions' -and $$content.Length -gt 8000) { \
			Write-Host '${f}: TOO LONG ('$$content.Length' characters, max 8000)'; \
		} elseif ('${f}' -eq 'GPT-description.txt' -and $$content.Length -gt 300) { \
			Write-Host '${f}: TOO LONG ('$$content.Length' characters, max 300)'; \
		} else { \
			Write-Host '${f}: OK ('$$content.Length' characters)'; \
		}"; \
	)
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

.PHONY: all clean charcount print-RM
