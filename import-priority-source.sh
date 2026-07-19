#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$repo_root"

if [[ -f AGENTS.md && ! -d .source-parts ]]; then
  echo "Priority App source is already imported."
  exit 0
fi

test -d .source-parts
archive="$(mktemp /tmp/priority-source.XXXXXX.zip)"
stage="$(mktemp -d /tmp/priority-source.XXXXXX)"
trap 'rm -f "$archive"; rm -rf "$stage"' EXIT

cat .source-parts/part-* > "$archive"
echo "e8f8e6582252f362d20415260934a3be244106c443ca43c47cb8938754a791f2  $archive" | sha256sum -c -
unzip -q "$archive" -d "$stage"

source_root="$stage/PriorityTasks2-Automation"
test -f "$source_root/AGENTS.md"
test -f "$source_root/FEATURE-LEDGER.md"
test -f "$source_root/package-lock.json"

cp -a "$source_root/." .
git rm -r .source-parts

npm ci
npm test

echo "Priority App source imported and regression checks passed."
