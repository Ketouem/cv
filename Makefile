build: build-aux build-pdf

build-aux:
	docker run -v $$(pwd):/data -it blang/latex bash -c "pdflatex -output-directory=./dist source-fr.tex "

build-pdf:
	docker run -v $$(pwd):/data -it blang/latex bash -c "pdflatex -output-directory=./dist source-fr.tex && mv dist/source-fr.pdf dist/cv.pdf"

clean:
	rm dist/*.aux
	rm dist/*.log
	rm dist/*.out
