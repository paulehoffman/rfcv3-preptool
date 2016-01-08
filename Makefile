BRANCH := $(shell git symbolic-ref --short HEAD)
DRAFT := draft-iab-rfcv3-preptool-latest
.PRECIOUS: %.xml
all: $(DRAFT).txt $(DRAFT).html

%.txt: %.xml
	xml2rfc --text $<
    
%.html: %.xml
	xml2rfc --html $<

%.xml: %.mkd
	kramdown-rfc2629 $< >$@.new
	# -diff $@ $@.new
	mv $@.new $@

publish: $(DRAFT).html $(DRAFT).txt
	git checkout gh-pages
	git checkout $(BRANCH) -- $(DRAFT).txt
	git checkout $(BRANCH) -- $(DRAFT).xml
	git checkout $(BRANCH) -- $(DRAFT).html
	git commit -m "Publish to GitHub pages"
	git push origin gh-pages
	git checkout $(BRANCH)
