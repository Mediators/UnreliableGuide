all: unreliable-mediator-guide.html unreliable-mediator-guide.pdf

unreliable-mediator-guide.html: README.md
	pandoc --template=data/pandoc_template.html -T "Unreliable Mediator Guide" --toc --toc-depth=6 --email-obfuscation=none -f markdown -t html README.md -o unreliable-mediator-guide.html
	cp unreliable-mediator-guide.html unreliable-mediator-guide.html.txt

unreliable-mediator-guide.pdf: README.md
	pandoc --variable=colorlinks -T "Unreliable Mediator Guide" --toc --toc-depth=6 --latex-engine=/Library/TeX/Root/bin/x86_64-darwin/pdflatex -f markdown -t latex README.md -o unreliable-mediator-guide.pdf

website:
	data/update_website.sh
