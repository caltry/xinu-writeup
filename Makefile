
.PHONY: default clean realclean
.SUFFIXES: .pdf .tex

LATEX := pdflatex
LATEX_ARGS := -file-line-error -halt-on-error

default: graphs
	$(MAKE) -B $(shell ls *.tex | sed 's/^\(.*\)\.tex$$/\1.pdf/')
	$(MAKE) clean

.PHONY: graphs
graphs: $(shell find graphs/ -name '*.dot' | sed 's/^\(.*\).dot$$/\1_dot.pdf/')

%_dot.pdf: %.dot
	dot -Tpdf $^ > $@

.tex.pdf:
	$(LATEX) $(LATEX_ARGS) $<
	$(LATEX) $(LATEX_ARGS) $<

clean:
	rm -f *.aux *.log *.dvi *.toc

realclean: clean
	rm -f *.dvi *.pdf
	find graphs/ -name '*.pdf' -exec rm {} \;
