# Qrypt Docs site

This repo hosts the content for `docs.qrypt.com`.

It's built using a static site generator called [Hugo](https://gohugo.io/)

The site itself is published automatically by GitHub Actions whenever changes are merged into the main branch.

## Updating the docs

1. Open the repo in the devcontainer (needed to get the right version of Hugo)
2. Make any desired changes in the [content](./content) directory.
3. Run `hugo --baseURL="https://QryptInc.github.io" --cleanDestinationDir` to build the site.
4. Commit all changes and make a PR.

