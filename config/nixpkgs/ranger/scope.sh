#!/usr/bin/env bash

set -o noclobber -o noglob -o nounset -o pipefail
IFS=$'\n'

# If the option `use_preview_script` is set to `true`,
# then this script will be called and its output will be displayed in ranger.
# ANSI color codes are supported.
# STDIN is disabled, so interactive scripts won't work properly

# This script is considered a configuration file and must be updated manually.
# It will be left untouched if you upgrade ranger.

# Meanings of exit codes:
# code | meaning    | action of ranger
# -----+------------+-------------------------------------------
# 0    | success    | Display stdout as preview
# 1    | no preview | Display no preview at all
# 2    | plain text | Display the plain content of the file
# 3    | fix width  | Don't reload when width changes
# 4    | fix height | Don't reload when height changes
# 5    | fix both   | Don't ever reload
# 6    | image      | Display the image `$IMAGE_CACHE_PATH` points to as an image preview
# 7    | image      | Display the file directly as an image

# Script arguments
FILE_PATH="${1}"         # Full path of the highlighted file
PV_WIDTH="${2}"          # Width of the preview pane (number of fitting characters)
PV_HEIGHT="${3}"         # Height of the preview pane (number of fitting characters)
IMAGE_CACHE_PATH="${4}"  # Full path that should be used to cache image preview
PV_IMAGE_ENABLED="${5}"  # 'True' if image previews are enabled, 'False' otherwise.

FILE_EXTENSION="${FILE_PATH##*.}"
FILE_EXTENSION_LOWER="${FILE_EXTENSION,,}"
FILE_SIZE=$(stat --printf="%s" "${FILE_PATH}")
MAX_FILE_SIZE_TO_READ=3147528 # 3 Mb

# Settings
HIGHLIGHT_SIZE_MAX=262143  # 256KiB
HIGHLIGHT_TABWIDTH=8
HIGHLIGHT_STYLE='pablo'
PYGMENTIZE_STYLE='autumn'


try() { output=$(eval '"$@"'); }


dump() { echo "$output"; }


separator()
{
    echo "----------------------------------------------------------------------------------------";
}


try_git()
{
    git diff --shortstat "${FILE_PATH}"
    git log --color -n 1 -- "${FILE_PATH}" && separator
}


hexdump()
{
    xxd -l 880 "${FILE_PATH}" && exit 4 || exit 1
}

elf_headers()
{
    readelf -hd "${FILE_PATH}" | grep "Class:\|Data:\|ABI:\|Type:\|Machine:\|(NEEDED)"
    separator
}

elf_rodata_strings()
{
    if [ "${FILE_SIZE}" -lt "${MAX_FILE_SIZE_TO_READ}" ]; then
        readelf -x .rodata "${FILE_PATH}" | sed '1,2d' | sed 's/^.\{12\}\(.\{36\}\).*$/\1/' | xxd -r -p | strings
        separator
    else
        hexdump
    fi
}

on_elf()
{
    elf_headers
    elf_rodata_strings
    exit 5;
}

on_json()
{
    if [ "${FILE_SIZE}" -lt "300000000" ]; then
        echo "JSON lines:"
        echo "--------"
        jq . "${FILE_PATH}" | wc -l
        echo ""

        echo "JSON Schema lines:"
        echo "--------"
        genson "${FILE_PATH}" | jq . | wc -l
        echo ""

        echo "JSON Keys (and frequency):"
        echo "--------"
        genson "${FILE_PATH}" | jq -c  ".. | .required? | .."  | grep -v null | grep -v "^\[" | sort | uniq -c | sort -n -r
        echo ""

        echo "JSON first bytes:"
        echo "--------"
        if [[ "$( tput colors )" -ge 256 ]]; then
            local pygmentize_format='terminal256'
            local highlight_format='xterm256'
        else
            local pygmentize_format='terminal'
            local highlight_format='ansi'
        fi
        head -4000 "${FILE_PATH}" | jq . | highlight --syntax=json --out-format="${highlight_format}"
    fi
    exit 5;
}

on_csv()
{
    if [ "${FILE_SIZE}" -lt "300000000" ]; then
        echo "CSV lines:"
        echo "--------"
        wc -l "${FILE_PATH}"
        echo ""
    fi
    echo "CSV Columns:"
    echo "-------------"
    xsv headers "${FILE_PATH}"
    echo ""
    echo "CSV Stats (on 10K lines):"
    echo "-------------"
    head -10000 "${FILE_PATH}" | xsv stats | xsv table -c 10 && exit 5
    exit 5;
}

on_highlight()
{
    # Syntax highlight
    if [[ "$( stat --printf='%s' -- "${FILE_PATH}" )" -gt "${HIGHLIGHT_SIZE_MAX}" ]]; then
        exit 2
    fi
    if [[ "$( tput colors )" -ge 256 ]]; then
        local pygmentize_format='terminal256'
        local highlight_format='xterm256'
    else
        local pygmentize_format='terminal'
        local highlight_format='ansi'
    fi
    highlight --replace-tabs="${HIGHLIGHT_TABWIDTH}" --out-format="${highlight_format}" \
        --style="${HIGHLIGHT_STYLE}" -- "${FILE_PATH}" && exit 5
    # pygmentize -f "${pygmentize_format}" -O "style=${PYGMENTIZE_STYLE}" -- "${FILE_PATH}" && exit 5
}


handle_extension() {
    case "${FILE_EXTENSION_LOWER}" in
        # Archive
        a|ace|alz|arc|arj|bz|bz2|cab|cpio|deb|gz|jar|lha|lz|lzh|lzma|lzo|\
        rpm|rz|t7z|tar|tbz|tbz2|tgz|tlz|txz|tZ|tzo|war|xpi|xz|Z|zip)
            atool --list -- "${FILE_PATH}" && exit 5
            bsdtar --list --file "${FILE_PATH}" && exit 5
            exit 1;;
        rar)
            # Avoid password prompt by providing empty password
            unrar lt -p- -- "${FILE_PATH}" && exit 5
            exit 1;;
        7z)
            # Avoid password prompt by providing empty password
            7z l -p -- "${FILE_PATH}" && exit 5
            exit 1;;

        # PDF
        pdf)
            # Preview as text conversion
            pdftotext -l 10 -nopgbrk -q -- "${FILE_PATH}" - && exit 5
            exiftool "${FILE_PATH}" && exit 5
            exit 1;;

        # BitTorrent
        torrent)
            transmission-show -- "${FILE_PATH}" && exit 5
            exit 1;;

        # OpenDocument
        odt|ods|odp|sxw)
            # Preview as text conversion
            odt2txt "${FILE_PATH}" && exit 5
            exit 1;;

        # CSV
        csv)
            on_csv
            exit 1;;

        # JSON
        json)
            on_json
            exit 1;;

        # HTML
        htm|html|xhtml)
            # Preview as text conversion
            w3m -dump "${FILE_PATH}" && exit 5
            lynx -dump -- "${FILE_PATH}" && exit 5
            elinks -dump "${FILE_PATH}" && exit 5
            ;; # Continue with next handler on failure

    esac
}

handle_image() {
    local mimetype="${1}"
    case "${mimetype}" in
        # SVG
        # image/svg+xml)
        #     convert "${FILE_PATH}" "${IMAGE_CACHE_PATH}" && exit 6
        #     exit 1;;

        # Image
        image/*)
            # `w3mimgdisplay` will be called for all images (unless overriden as above),
            # but might fail for unsupported types.
            exit 7;;

        # Video
        # video/*)
        #     # Thumbnail
        #     ffmpegthumbnailer -i "${FILE_PATH}" -o "${IMAGE_CACHE_PATH}" -s 0 && exit 6
        #     exit 1;;

        application/octet-stream)
            hexdump
            ;;
    esac
}

handle_mime() {
    local mimetype="${1}"
    case "${mimetype}" in
        # Text
        text/* | */xml)
            try_git
            on_highlight
            exit 2;;

        # Image
        image/*)
            # Preview as text conversion
            # img2txt --gamma=0.6 --width="${PV_WIDTH}" -- "${FILE_PATH}" && exit 4
            exiftool "${FILE_PATH}" && exit 5
            exit 1;;


        # Video and audio
        video/* | audio/*)
            mediainfo "${FILE_PATH}" && exit 5
            exiftool "${FILE_PATH}" && exit 5
            ;;

        application/x-executable|application/x-sharedlib)
            on_elf
            ;;

        data)
            hexdump
            ;;
    esac
}

handle_fallback() {
    echo '----- File Type Classification -----' && file --dereference --brief -- "${FILE_PATH}" && exit 5
    exit 1
}

handle_extension
MIMETYPE="$( file --dereference --brief --mime-type -- "${FILE_PATH}" )"
if [[ "${PV_IMAGE_ENABLED}" == 'True' ]]; then
    handle_image "${MIMETYPE}"
fi
handle_mime "${MIMETYPE}"
handle_fallback

exit 1

