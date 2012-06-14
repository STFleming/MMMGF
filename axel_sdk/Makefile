# Makefile for AXEL Cluster Manager System
# by Brittle 2009

#### Directories ####

#### Compilers ####

CC=gcc
DEBUG=-D__CONSOLE__ -D__DEBUG__
CFLAGS=-Wall -O3 -Iinc $(DEBUG)
LDFLAGS=-lexpat -lcurl -lidn -lssl -lcrypto -lldap -lrt -lssl -lcrypto -ldl -lz

#### Source Files ####

COMMON=inc/axel_common.h
COM_SRCS=\
		 axel_util.c \
		 fpga_util.c
COM_OBJS=$(COM_SRCS:%c=%o)
COM_LIB=lib/libaxel.a

RM_TARGET=axel_rm
RM_SRCS=\
		 $(RM_TARGET).c
RM_OBJS=$(RM_SRCS:%c=%o)

HN_TARGET=axel_hn
HN_SRCS=\
		 $(HN_TARGET).c
HN_OBJS=$(HN_SRCS:%c=%o)

AL_TARGET=axel_al
AL_SRCS=\
		 $(AL_TARGET).c
AL_OBJS=$(AL_SRCS:%c=%o)

RT_TARGET=axel_rt
RT_SRCS=\
		 $(RT_TARGET).c
RT_OBJS=$(RT_SRCS:%c=%o)

#### Actions ####

#all: $(RT_TARGET) $(RM_TARGET) $(HN_TARGET) $(AL_TARGET) $(COM_LIB)
all: $(COM_LIB)

## common library ##
$(COM_LIB): $(COM_OBJS)
	ar -cvq $(COM_LIB) $(COM_OBJS)
	gcc -shared -Wl,-soname,libaxel.so.1 -o lib/libaxel.so.1.0 $(COM_OBJS)

$(COM_OBJS):%.o: src/%.c inc/%.h $(COMMON)
	$(CC) $(CFLAGS) -fPIC -c $<
#	$(CC) $(CFLAGS) -fPIC -c $<

## Resource Manager ##
$(RM_TARGET): $(RM_OBJS) $(COM_OBJS) $(COMMON)
	$(CC) $(CFLAGS) -o $(RM_TARGET) $(RM_OBJS) $(COM_OBJS) $(LDFLAGS)

$(RM_OBJS):%.o: src/%.c inc/%.h $(COMMON)
	$(CC) $(CFLAGS) -c $<

$(HN_TARGET): $(HN_OBJS) $(COM_OBJS) $(COMMON)
	$(CC) $(CFLAGS) -o $(HN_TARGET) $(HN_OBJS) $(COM_OBJS) $(LDFLAGS)

$(HN_OBJS):%.o: src/%.c inc/%.h $(COMMON)
	$(CC) $(CFLAGS) -c $<

$(AL_TARGET): $(AL_OBJS) $(COM_OBJS) $(COMMON)
	$(CC) $(CFLAGS) -o $(AL_TARGET) $(AL_OBJS) $(COM_OBJS) $(LDFLAGS)

$(AL_OBJS):%.o: src/%.c inc/%.h $(COMMON)
	$(CC) $(CFLAGS) -c $<

$(RT_TARGET): $(RT_OBJS) $(COM_OBJS) $(COMMON)
	$(CC) $(CFLAGS) -o $(RT_TARGET) $(RT_OBJS) $(COM_OBJS) $(LDFLAGS)

$(RT_OBJS):%.o: src/%.c inc/%.h $(COMMON)
	$(CC) $(CFLAGS) -c $<

clean:
	rm -f $(RM_TARGET) $(HN_TARGET) $(AL_TARGET) $(RT_TARGET)

realclean:
	rm -f $(COM_OBJS) $(COM_LIB) lib/libaxel.so.1 lib/libaxel.so.1.0
	rm -f $(RM_OBJS) $(RM_TARGET)
	rm -f $(HN_OBJS) $(HN_TARGET)
	rm -f $(AL_OBJS) $(AL_TARGET)
	rm -f $(RT_OBJS) $(RT_TARGET)
