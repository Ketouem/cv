# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A single-file LaTeX resume (in French) built with the `moderncv` class. The whole CV lives in `source-fr.tex`; `images/` holds the section and social-link icons it references.

## Build

Docker is the only prerequisite; there is no local TeX toolchain assumed.

- `make build`: builds the `cv-latex` image (Debian + TinyTeX, see `Dockerfile`), then runs a single `pdflatex` pass in a container with the repo mounted at `/data`. Output: `dist/cv.pdf`.
- `make image`: builds only the Docker image.
- `make clean`: removes `dist/`.

There are no tests or linters. The only check (in CI) is that `dist/cv.pdf` exists and is non-empty.

If you add a LaTeX package to `source-fr.tex`, also add it to the `tlmgr install` list in the `Dockerfile`. TinyTeX is minimal, so the build fails on any package that isn't installed explicitly.

## Structure of `source-fr.tex`

- **Age is computed at build time** from the birthdate using TeX `\year`/`\month`/`\day` (the `\age` counter). Don't hardcode it.
- **`\section` is redefined** (`\RenewDocumentCommand{\section}{smo}`) to take an optional trailing icon argument: `\section{Title}[\includegraphics[scale=0.40]{./images/foo.png}]`. New sections should follow this pattern.
- **Experience entries** use `\cventry{dates}{title}{company}{city}{country}{body}`, newest first, each preceded by a `% Company` comment and separated by `\bigbreak`. Bodies are `itemize` lists with key technologies in `\textbf{}`.
- The skills, languages and hobbies sections are laid out in two columns using paired `minipage`s at `0.5\textwidth`.
- The light-blue header band is drawn with `eso-pic` (`\AddToShipoutPictureBG*`).

## CI / deploy

CircleCI (`.circleci/config.yml`) runs `make build` on every branch and tag. On `master`, it uploads `dist/cv.pdf` publicly to `s3://public-dist/cv.pdf` (the link in the README). A push to `master` publishes the CV.
