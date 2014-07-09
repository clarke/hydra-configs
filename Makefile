EXAMPLES=$(wildcard *.lua.example)
OBJS = $(EXAMPLES:%.lua.example=%.lua)

all: $(OBJS)

install:
	ln -s `pwd` $(HOME)/.hydra

%.lua: %.lua.example
	cp $^ $@
