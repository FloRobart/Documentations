#!/bin/bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")" && pwd)"
MKDOCS_FILE="$REPO_ROOT/mkdocs.yml"
INDEX_FILE="$REPO_ROOT/docs/index.md"

if [[ ! -f "$MKDOCS_FILE" ]];
then
	echo "Fichier introuvable: $MKDOCS_FILE" >&2
	exit 1
fi

if [[ ! -f "$INDEX_FILE" ]];
then
	echo "Fichier introuvable: $INDEX_FILE" >&2
	exit 1
fi

trim() {
	local value="$1"
	value="${value#"${value%%[![:space:]]*}"}"
	value="${value%"${value##*[![:space:]]}"}"
	printf '%s' "$value"
}

strip_quotes() {
	local value
	value="$(trim "$1")"
	[[ -z "$value" ]] && { printf '%s' "$value"; return; }
	local first="${value:0:1}"
	local last="${value: -1}"
	if [[ ${#value} -ge 2 && "$first" == "$last" && ( "$first" == '"' || "$first" == "'") ]]; then
		value="${value:1:-1}"
	fi
	printf '%s' "$value"
}

is_link() {
	local target="$(trim "$1")"
	[[ -z "$target" ]] && return 1
	if [[ "$target" == http://* || "$target" == https://* || "$target" == \#* ]]; then
		return 0
	fi
	if [[ "$target" == *.* ]]; then
		case "$target" in
			*.md|*.markdown|*.html|*.htm)
				return 0
				;;
		esac
	fi
	if [[ "$target" == */* ]]; then
		return 0
	fi
	return 1
}

render_group() {
	local level="$1"
	local title="$2"
	title="$(strip_quotes "$title")"
	local indent=""
	printf -v indent '%*s' $(( level * 4 )) ''
	NAV_LINES+=("${indent}- ${title}")
}

render_leaf() {
	local title="$1"
	local target="$2"
	local level="$3"
	local indent=""
	printf -v indent '%*s' $(( level * 4 )) ''
	title="$(strip_quotes "$title")"
	target="$(strip_quotes "$target")"
	if [[ -z "$target" ]]; then
		NAV_LINES+=("${indent}- ${title}")
	elif is_link "$target"; then
		NAV_LINES+=("${indent}- [${title}](${target})")
	else
		NAV_LINES+=("${indent}- ${title}: ${target}")
	fi
}

parse_nav() {
	local in_nav=0
	while IFS= read -r line || [[ -n "$line" ]]; do
		if (( ! in_nav )); then
			[[ $line =~ ^nav:[[:space:]]*$ ]] && { in_nav=1; continue; }
			continue
		fi
		[[ $line =~ ^[[:space:]]*$ ]] && continue
		if [[ $line =~ ^[A-Za-z0-9_]+: ]] && [[ ! $line =~ ^nav: ]]; then
			break
		fi
		[[ ! $line =~ ^[[:space:]]*- ]] && continue
		if [[ $line =~ ^([[:space:]]*)-[[:space:]]*(.*)$ ]]; then
			local leading="${BASH_REMATCH[1]}"
			local content="${BASH_REMATCH[2]}"
			content="$(strip_quotes "$content")"
			[[ -z "$content" ]] && continue
			local indent_len=${#leading}
			local level=$(( (indent_len / 4) - 1 ))
			(( level < 0 )) && level=0
			if [[ $content == *:* ]]; then
				local title="${content%%:*}"
				local value="${content#*:}"
				title="$(strip_quotes "$title")"
				value="$(strip_quotes "$value")"
				if [[ -z "$value" ]]; then
					render_group "$level" "$title"
				else
					render_leaf "$title" "$value" "$level"
				fi
			else
				render_leaf "$content" "$content" "$level"
			fi
		fi
	done < "$MKDOCS_FILE"
}

declare -a NAV_LINES=()
parse_nav

if ((${#NAV_LINES[@]} == 0));
then
	echo "Aucune section 'nav' trouvée dans mkdocs.yml" >&2
	exit 1
fi

NAV_MD="$(printf '%s\n' "${NAV_LINES[@]}")"
NAV_MD="${NAV_MD%$'\n'}"

START_MARKER="<!-- nav:start -->"
END_MARKER="<!-- nav:end -->"

if ! grep -qF "$START_MARKER" "$INDEX_FILE" || ! grep -qF "$END_MARKER" "$INDEX_FILE";
then
	echo "Impossible de trouver les marqueurs '$START_MARKER' et '$END_MARKER' dans index.md" >&2
	exit 1
fi

REPLACEMENT="$START_MARKER\n\n$NAV_MD\n\n$END_MARKER"
TMP_FILE="$(mktemp)"

if ! awk -v start="$START_MARKER" -v end="$END_MARKER" -v block="$REPLACEMENT" '
BEGIN {
	printed = 0
	skipping = 0
}
{
	if ($0 == start) {
		print block
		skipping = 1
		printed = 1
		deleted = 0
		next
	}
	if (skipping) {
		if ($0 == end) {
			skipping = 0
		}
		next
	}
	print
}
END {
	if (!printed) {
		exit 1
	}
}
' "$INDEX_FILE" > "$TMP_FILE"; then
	rm -f "$TMP_FILE"
	echo "Échec de la mise à jour de docs/index.md" >&2
	exit 1
fi

mv "$TMP_FILE" "$INDEX_FILE"
