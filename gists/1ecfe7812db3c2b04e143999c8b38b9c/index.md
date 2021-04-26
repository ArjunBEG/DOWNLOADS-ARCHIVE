## Setup

Static files and 404 pages.

```
{{ mkdir "build" }}
{{ copy "static/*" "build" }}
{{ render "404" | write "build/404.html" }}
```

## Documentation

Generate documentation index pages.

```
{{ mkdir "build/docs/ping" }}

{{ with read "content/docs/index.md" | frontmatter }}
  {{ render "docs-products" . | write "build/docs/index.html" }}
{{ end }}

{{ with read "content/docs/ping.md" | frontmatter }}
  {{ render "docs-guides" . | write "build/docs/ping/index.html" }}
{{ end }}
```

Generate documentation pages for each product.

```
{{ title "generating documentation guides" }}
{{ range files "content/docs" | dirs }}
  {{ $product := . }}
  {{ range files .Path }}
    {{ $dest := printf "build/docs/%s/%s/index.html" $product.Name .Base }}
    {{ $dest | dirname | mkdir }}
    {{ $page := read .Path | frontmatter }}
    {{ info "render %s" $dest }}
    {{ $page | render "doc" | write $dest }}
  {{ end }}
{{ end }}
```

## Pages

Generate landing pages.

```
{{ title "generating landing pages" }}
{{ range files "content/pages" }}
  {{ $page := read .Path | frontmatter }}
  {{ $dest := $page.URL | printf "build/%s/index.html" }}
  {{ $dest | dirname | mkdir }}
  {{ info "render %s" $dest }}
  {{ $page | render $page.Layout | write $dest }}
{{ end }}
```

## Done

```
{{ title "done" }}
```
