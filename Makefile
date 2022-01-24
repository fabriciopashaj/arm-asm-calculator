CC ?= gcc
SRC = calculator.s
BIN = calculator

$(BIN): $(SRC)

clean:
	@if [ -f calculator ]; then rm calculator; fi
