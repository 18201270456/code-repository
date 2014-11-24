
CC	 = gcc

TARGET = quintet

everything: $(TARGET)

clean:
	rm -f *.o
	rm -f quintet

all:
	clean
	everything

..c.o:
	$(CC) -c $^

quintet: main.o ai.o chessboard.o lib.o
	$(CC) -o $@ $^


