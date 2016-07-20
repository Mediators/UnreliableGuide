unreliable-mediator-guide.html: README.md
	pandoc --template=data/pandoc_template.html --toc --toc-depth=6 --email-obfuscation=none -f markdown -t html README.md -o unreliable-mediator-guide.html
