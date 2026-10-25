.PHONY: build clean list open

# Build the resume (archives previous version automatically)
build:
	@./build.sh

# Build a specific .tex file
# Usage: make build-file TEX=path/to/file.tex
build-file:
	@./build.sh $(TEX)

# List all versions
list:
	@echo "📁 Resume versions:" && \
	ls -lh resumes/RAKESH_KANDHI.pdf 2>/dev/null && \
	echo "--- Archive ---" && \
	ls -lh resumes/archive/V*_RAKESH_KANDHI.pdf 2>/dev/null || true

## Remove compiled PDFs and all archived resume versions
clean:
	@rm -f resume.pdf
	@rm -f resumes/archive/V*_RAKESH_KANDHI.pdf
	@echo "🧹 Cleaned build artifacts and archived resume versions." 

# Open latest resume in Safari
open:
	@open -a Safari resumes/RAKESH_KANDHI.pdf
