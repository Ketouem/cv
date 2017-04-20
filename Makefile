build-container:
	docker build -t ketouem/latex-moderncv .

build:
	pdflatex source-fr.tex -output-directory dist/cv.pdf
