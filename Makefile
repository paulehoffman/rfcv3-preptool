.PRECIOUS: %.xml
all: draft-hoffman-rfcv3-preptool-latest.txt draft-hoffman-rfcv3-preptool-latest.html

%.txt: %.xml
	xml2rfc --text $<
    
%.html: %.xml
	xml2rfc --html $<

%.xml: %.mkd
	kramdown-rfc2629 $< >$@.new
	# -diff $@ $@.new
	mv $@.new $@
