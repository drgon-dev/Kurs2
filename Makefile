TARGET		:= programm
COMPILER    	:= cursed
SOURCES		:= ./

LIBS = -lfl -Wno-implicit

MFILES := $(foreach dir,$(SOURCES), $(wildcard $(dir)*.curs))
LFILES := $(foreach dir,$(SOURCES), $(wildcard $(dir)*.l))
YFILES := $(foreach dir,$(SOURCES), $(wildcard $(dir)*.y))

CC      = $-gcc
CFLAGS  = -o
FLEX    = $-flex
FFLAGS  = -o
BISON   = $-bison
BFLAGS  = -d -o

all: $(YFILES) $(LFILES) $(MFILES)
	$(BISON) $(BFLAGS) file_b.c $(YFILES)
	$(FLEX) $(FFLAGS) file_f.c $(LFILES)
	$(CC) $(CFLAGS) $(COMPILER) file_b.c file_f.c $(LIBS)
	./$(COMPILER) <$(MFILES)> $(TARGET).c
	$(CC) -O0 -pg $(CFLAGS) ./curs ./$(TARGET).c
	./curs
	gprof ./curs gmon.out > analysis.txt
	gedit analysis.txt &

clean:
	@rm -rf *.c *.h curs $(COMPILER) *.out analysis.txt
