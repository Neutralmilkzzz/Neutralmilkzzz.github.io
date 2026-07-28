#!/usr/bin/env bash
set -euo pipefail
site_dir="${1:?site output directory required}"
for section in posts categories tags about; do
  source_root="${site_dir}/blog/${section}"
  [[ -d "${source_root}" ]] || continue
  while IFS= read -r -d '' page; do
    relative="${page#${site_dir}/blog/}"
    target="/blog/${relative%index.html}"
    legacy="${site_dir}/${relative}"
    mkdir -p "$(dirname "${legacy}")"
    cat > "${legacy}" <<HTML
<!doctype html><html lang="en"><head><meta charset="utf-8"><meta name="robots" content="noindex"><meta http-equiv="refresh" content="0; url=${target}"><link rel="canonical" href="${target}"><title>Moved</title></head><body><p>This page moved to <a href="${target}">${target}</a>.</p><script>location.replace("${target}"+location.search+location.hash)</script></body></html>
HTML
  done < <(find "${source_root}" -name index.html -type f -print0)
done
[[ -f "${site_dir}/blog/index.xml" ]] && cp "${site_dir}/blog/index.xml" "${site_dir}/index.xml"
[[ -f "${site_dir}/blog/sitemap.xml" ]] && cp "${site_dir}/blog/sitemap.xml" "${site_dir}/sitemap.xml"
[[ -f "${site_dir}/blog/404.html" ]] && cp "${site_dir}/blog/404.html" "${site_dir}/404.html"