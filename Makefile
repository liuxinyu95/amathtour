all: cn en

BOOK-CN := $(wildcard *-zh-cn.tex)
BOOK-EN := $(wildcard *-en.tex)

cn: $(BOOK-CN:.tex=.pdf)
en: $(BOOK-EN:.tex=.pdf)

TEX_FLAGS =

%.pdf: %.tex; latexmk -cd -lualatex $(TEX_FLAGS) $<

# CHAPTERS-CN := $(shell egrep -l documentclass $$(find . -name '*-zh-cn.tex' -a \! -name 'amathtour-*.tex'))
# CHAPTERS-EN := $(shell egrep -l documentclass $$(find . -name '*-en.tex' -a \! -name 'amathtour-*.tex'))

# chapters: chapters-cn chapters-en
# chapters-cn: $(CHAPTERS-CN:.tex=.pdf)
# chapters-en: $(CHAPTERS-EN:.tex=.pdf)

FORCE-FLAGS = -g -use-make $(TEX_FLAGS)

force: force-cn force-en

force-cn:
	latexmk -cd -lualatex $(FORCE-FLAGS) $(BOOK-CN)

force-en:
	latexmk -cd -lualatex $(FORCE-FLAGS) $(BOOK-EN)

clean:
	git clean -fdx

.PHONY: all cn en #chapters chapters-cn chapters-en
