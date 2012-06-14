all: userapp

CFLAG=-Wall -O3 -fopenmp -D__DEBUG__

userapp: userapp.c
	gcc ${CFLAG} -o userapp userapp.c -lm

clean:
	rm -f userapp
