#!/usr/bin/env bash
# ──────────────────────────────────────────────────────────────────
#  build.sh — Tectonic-based LaTeX resume builder with auto-versioning
#
#  Usage:
#    ./build.sh                   # builds the default resume.tex
#    ./build.sh path/to/file.tex  # builds a specific .tex file
#
#  Output:
#    resumes/RAKESH_KANDHI.pdf           ← always the latest build
#    resumes/archive/V<N>_RAKESH_KANDHI.pdf  ← auto-archived previous versions
# ──────────────────────────────────────────────────────────────────
set -euo pipefail

# ── Configuration ────────────────────────────────────────────────
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEFAULT_TEX="resume.tex"
OUTPUT_NAME="RAKESH_KANDHI"
RESUMES_DIR="${SCRIPT_DIR}/resumes"
ARCHIVE_DIR="${RESUMES_DIR}/archive"
ACTIVE_PDF="${RESUMES_DIR}/${OUTPUT_NAME}.pdf"

# ── Resolve input .tex file ──────────────────────────────────────
TEX_FILE="${1:-${SCRIPT_DIR}/${DEFAULT_TEX}}"
if [[ ! -f "$TEX_FILE" ]]; then
    echo "❌ Error: TeX file not found: ${TEX_FILE}"
    exit 1
fi
echo "📄 Source:  ${TEX_FILE}"

# ── Check tectonic is installed ──────────────────────────────────
if ! command -v tectonic &>/dev/null; then
    echo "❌ Error: tectonic is not installed."
    echo "   Install with: brew install tectonic"
    exit 1
fi

# ── Create output directories ───────────────────────────────────
mkdir -p "${RESUMES_DIR}" "${ARCHIVE_DIR}"

# ── Auto-version existing PDF before overwriting ─────────────────
if [[ -f "$ACTIVE_PDF" ]]; then
    # Find the highest existing version number in the archive
    HIGHEST=0
    for f in "${ARCHIVE_DIR}"/V*_${OUTPUT_NAME}.pdf; do
        [[ -e "$f" ]] || continue
        BASENAME="$(basename "$f")"
        # Extract version number: V<number>_RAKESH_KANDHI.pdf
        NUM="${BASENAME#V}"
        NUM="${NUM%%_*}"
        if [[ "$NUM" =~ ^[0-9]+$ ]] && (( NUM > HIGHEST )); then
            HIGHEST=$NUM
        fi
    done

    NEXT_VERSION=$(( HIGHEST + 1 ))
    ARCHIVE_PATH="${ARCHIVE_DIR}/V${NEXT_VERSION}_${OUTPUT_NAME}.pdf"

    # Safety check: compare SHA-256 with the most recent archive
    if (( HIGHEST > 0 )); then
        LATEST_ARCHIVE="${ARCHIVE_DIR}/V${HIGHEST}_${OUTPUT_NAME}.pdf"
        HASH_ACTIVE="$(shasum -a 256 "$ACTIVE_PDF" | awk '{print $1}')"
        HASH_LATEST="$(shasum -a 256 "$LATEST_ARCHIVE" | awk '{print $1}')"
        if [[ "$HASH_ACTIVE" == "$HASH_LATEST" ]]; then
            echo "⏭️  Skipping archive: current PDF is identical to V${HIGHEST} (SHA-256 match)."
        else
            mv "$ACTIVE_PDF" "$ARCHIVE_PATH"
            echo "📦 Archived: ${ACTIVE_PDF} → V${NEXT_VERSION}_${OUTPUT_NAME}.pdf"
        fi
    else
        mv "$ACTIVE_PDF" "$ARCHIVE_PATH"
        echo "📦 Archived: ${ACTIVE_PDF} → V${NEXT_VERSION}_${OUTPUT_NAME}.pdf"
    fi
fi

# ── Compile with Tectonic ────────────────────────────────────────
TEX_DIR="$(dirname "$TEX_FILE")"
TEX_BASE="$(basename "$TEX_FILE")"
echo "🔨 Compiling with tectonic..."
(cd "$TEX_DIR" && tectonic "$TEX_BASE")

# ── Move compiled PDF to resumes/ ────────────────────────────────
COMPILED_PDF="${TEX_DIR}/${TEX_BASE%.tex}.pdf"
if [[ ! -f "$COMPILED_PDF" ]]; then
    echo "❌ Error: Compilation failed — no PDF generated."
    exit 1
fi
mv "$COMPILED_PDF" "$ACTIVE_PDF"
mkdir -p "${SCRIPT_DIR}/docs"
cp "$ACTIVE_PDF" "${SCRIPT_DIR}/docs/resume.pdf"

# ── Summary ──────────────────────────────────────────────────────
SIZE="$(du -h "$ACTIVE_PDF" | awk '{print $1}')"
echo ""
echo "✅ Build complete!"
echo "   Output: ${ACTIVE_PDF} (${SIZE})"
echo ""

# List all versions
echo "📁 All versions in ${RESUMES_DIR}/:"
echo "   ${OUTPUT_NAME}.pdf  ← latest"
for f in $(ls -1 "${ARCHIVE_DIR}"/V*_${OUTPUT_NAME}.pdf 2>/dev/null | sort -V); do
    BASENAME="$(basename "$f")"
    echo "   archive/${BASENAME}"
done
