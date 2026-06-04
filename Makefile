IMAGE := cv-latex

image:
	docker build -t $(IMAGE) .

build: image
	mkdir -p dist
	docker run --rm -v $$(pwd):/data $(IMAGE) bash -c "pdflatex -output-directory=./dist source-fr.tex && mv dist/source-fr.pdf dist/cv.pdf"

clean:
	rm -fr dist/
