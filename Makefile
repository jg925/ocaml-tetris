MODULES=board main shapes test tile tilearray
OBJECTS=$(MODULES:=.cmo)
MLS=$(MODULES:=.ml)
MLIS=$(MODULES:=.mli)
TEST=test.byte
MAIN=main.byte
OCAMLBUILD=ocamlbuild -use-ocamlfind
PKGS=ounit2,ANSITerminal,graphics

default: build
	export DISPLAY=:0
	utop

build:
	$(OCAMLBUILD) $(OBJECTS)

test:
	$(OCAMLBUILD) -tag 'debug' $(TEST) && ./$(TEST)

zip:
	zip tetris.zip *.ml* _tags *.md Makefile

play:
	$(OCAMLBUILD) $(MAIN) && ./$(MAIN)

docs: docs-public docs-private
	
docs-public: build
	mkdir -p doc.public
	ocamlfind ocamldoc -I _build -package $(PKGS) \
		-html -stars -d doc.public board.mli shapes.mli tile.mli tilearray.mli

docs-private: build
	mkdir -p doc.private
	ocamlfind ocamldoc -I _build -package $(PKGS) \
		-html -stars -d doc.private \
		board.ml board.mli shapes.ml shapes.mli tile.ml tile.mli tilearray.ml \
		tilearray.mli main.ml test.ml

clean:
	ocamlbuild -clean
