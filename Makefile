OPTIONS := -Wall

build: hpack
	cabal build --ghc-options='${OPTIONS}'

hpack:
	hpack .

test: hpack
	cabal test --ghc-options='${OPTIONS}'

format:
	find src/ test/ -name "*.hs" -exec fourmolu -i -o '-XTypeApplications' -o '-XImportQualifiedPost' {} +

format-check:
	find src/ test/ -name "*.hs" -exec fourmolu -m check -o '-XTypeApplications' -o '-XImportQualifiedPost' {} +

ghcid: hpack
	ghcid -c "cabal repl --ghc-options='${OPTIONS}'"

ghcid-test: hpack
	ghcid -c "cabal repl snail-shell-test --ghc-options='${OPTIONS}'"

clean:
	cabal clean

hlint:
	hlint .

.PHONY: build hpack test format format-check ghcid ghcid-test clean hlint
