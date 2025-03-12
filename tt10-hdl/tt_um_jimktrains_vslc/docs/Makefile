MD_SRC=$(wildcard src/*.md)

view-pdf: datasheet.pdf
	okular datasheet.pdf

pdf: datasheet.pdf

datasheet.pdf: info.md
	cd ..; tt/tt_tool.py --print-warnings --create-pdf
	mv ../datasheet.* .

src/SUMMARY.md: $(MD_SRC)
	echo "# Summary\n" > src/SUMMARY.md
	ls src/*.md | grep -v SUMMARY | sed s~src/~~ | sed 's~\(.*\)~[\1](\1)~' >> src/SUMMARY.md


info.md: src/SUMMARY.md
	mdbook clean
	mdbook build
	echo > info.md
	#for i in book/*; do cat $$i >> info.md; echo "\n" '```' "{=latex}\n\\\\newpage\n " '```' "\n\n" >> info.md; done
	for i in book/*; do cat $$i >> info.md; echo "\n\n------\n\n" >> info.md; done
	mv src/*.generated.svg .

clean:
	mdbook clean
	rm -f book/* info.md datasheet.pdf datasheet.md *.generated.svg src/SUMMARY.md
