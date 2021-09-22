CC=		g++
CFLAGS=	-Wall -g -std=c++11
LIBS= 	

program: 	program.cpp
	$(CC) $(CFLAGS) -o $@ $^ $(LIBS)

clean:
	rm -f program
