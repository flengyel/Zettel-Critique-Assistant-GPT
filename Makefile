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
all: $(TXT_TARGETS) $(PDF_TARGETS) post-process

# Rule to convert Markdown to text
%.txt: %.md
	echo Generating $@ from $<
	pandoc --defaults strip-markdown.yaml $< -o $@
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

post-process:
ifeq ($(OS),Windows_NT)
	@$(foreach f,$(TXT_TARGETS), \
		pwsh -noprofile -command "& {.\replace.ps1 -FilePath '.\\$(f)'}"; )
#	pwsh -noprofile -command "& {.\replace.ps1 -FilePath '.\\GPT-instructions.txt'}"
#	pwsh -noprofile -command "& {.\replace.ps1 -FilePath '.\\GPT-instructions-prior.txt'}"
#	pwsh -noprofile -command "& {.\replace.ps1 -FilePath '.\\GPT-instructions-test.txt'}"
#	pwsh -noprofile -command "& {.\replace.ps1 -FilePath '.\\GPT-description.txt'}"
#	pwsh -noprofile -command "& {.\replace.ps1 -FilePath '.\\Zettel-template.txt'}"
else	
	@for f in $(TXT_TARGETS); do sed -i 's/[ \t]*$$//; s/^[ \t]*//; /^$$/N; /\n$$/D; s/  */ /g' $$f; echo "Processed $$f"; done
	# Special processing for GPT-description.txt
	@sed -i '1d;s/  */ /g' GPT-description.txt; echo "Processed GPT-description.txt"
endif


# remove consequtive spaces and newlines, and warn if instructions exceed 8000 characters
# and if the description exceeds 300 characters
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
x 		elif [ $$count -le 8000 ]; then \
			echo "$$f: OK ($$count characters)"; \
		else \
			echo "$$f: TOO LONG ($$count characters)"; \
		fi; \
	done
endif

.PHONY: all clean post-process charcount print-RM
