.PHONY: all
all:
	make bin/cpals
	make bin/hpals
	make bin/recpals
	make bin/revpals
	make bin/Palindromes

bin/cpals: cpals.c
	gcc -Wall -std=gnu99 -pedantic -O3 -o bin/cpals cpals.c

bin/hpals: hpals.hs
	ghc -Wall -O2 -outputdir bin -o bin/hpals hpals.hs

bin/recpals: recpals.pas
	fpc -vw -TLINUX -O3 -obin/recpals recpals.pas

bin/revpals: revpals.pas
	fpc -vw -TLINUX -O3 -obin/revpals revpals.pas

bin/Palindromes: Palindromes.pas
	fpc -vw -TLINUX -O3 -obin/Palindromes Palindromes.pas
