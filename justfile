# Justfile for Rakesh Kandhi's Resume Repository
# Run `just` or `just --list` to see available recipes

# Default recipe: build latest resume PDF
default: build

# Build resume PDF using build.sh (auto-archives previous versions)
build:
    @./build.sh

# Build a specific .tex file (e.g. `just build-file resume.tex`)
build-file tex_file:
    @./build.sh {{tex_file}}

# Preview / generate PNG thumbnail of the compiled resume
preview:
    @swift -e '\
    import Quartz; \
    import AppKit; \
    let url = CFURLCreateWithFileSystemPath(nil, "resumes/RAKESH_KANDHI.pdf" as CFString, .cfurlposixPathStyle, false)!; \
    let doc = CGPDFDocument(url)!; \
    let page = doc.page(at: 1)!; \
    let rect = page.getBoxRect(.mediaBox); \
    let scale: CGFloat = 2.0; \
    let width = Int(rect.width * scale); \
    let height = Int(rect.height * scale); \
    let colorSpace = CGColorSpaceCreateDeviceRGB(); \
    let context = CGContext(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!; \
    context.scaleBy(x: scale, y: scale); \
    context.setFillColor(CGColor(red: 1, green: 1, blue: 1, alpha: 1)); \
    context.fill(CGRect(x: 0, y: 0, width: rect.width, height: rect.height)); \
    context.drawPDFPage(page); \
    let image = context.makeImage()!; \
    let dest = CGImageDestinationCreateWithURL(URL(fileURLWithPath: "assets/preview-page-1.png") as CFURL, "public.png" as CFString, 1, nil)!; \
    CGImageDestinationAddImage(dest, image, nil); \
    CGImageDestinationFinalize(dest); \
    print("Preview generated at assets/preview-page-1.png")'

# List all versions including archived ones
list:
    @echo "📁 Resume versions:"
    @ls -lh resumes/RAKESH_KANDHI.pdf 2>/dev/null || true
    @echo "--- Archive ---"
    @ls -lh resumes/archive/V*_RAKESH_KANDHI.pdf 2>/dev/null || true

# Open latest resume in default viewer
open:
    @open resumes/RAKESH_KANDHI.pdf

# Open latest resume in Safari
open-safari:
    @open -a Safari resumes/RAKESH_KANDHI.pdf

# Clean build artifacts and archives
clean:
    @rm -f resume.pdf
    @rm -f resumes/archive/V*_RAKESH_KANDHI.pdf
    @echo "🧹 Cleaned build artifacts and archived resume versions."
