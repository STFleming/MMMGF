all: userapp

CFLAG=

userapp: userapp.cu
	nvcc ${CFLAG} -o userapp userapp.cu

clean:
	rm -f userapp userapp.linkinfo
