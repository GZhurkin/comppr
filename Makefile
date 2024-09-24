all: taskone tasktwo taskthree

taskone: lmain main1.i main1.s main1 mainr2 mainr3 optim1.s optim2.s optim3.s first.h second.h main2 main3

# Часть 1
# Поэтапная компиляция
main1.i: main1.cpp
	g++ -E -o main1.i main1.cpp
main1.s: main1.cpp
	g++ -S -o main1.s main1.cpp
main1.o: main1.cpp
	g++ -c -o main1.o main1.cpp
main1: main1.o
	g++ main1.o -o main1.exe

# Оптимизация
optim1.s: main1.cpp
	g++ -S -O1 -o optim1.s main1.cpp
optim2.s: main1.cpp
	g++ -S -O2 -o optim2.s main1.cpp
optim3.s: main1.cpp
	g++ -S -O3 -o optim3.s main1.cpp

# Часть 2
# Раздельная компиляция
main2.o: main1.cpp
	g++ -c -o main2.o main2.cpp
main3.o: main3.cpp
	g++ -c -o main3.o main3.cpp
first.o: first.cpp
	g++ -c -o first.o first.cpp
second.o: second.cpp
	g++ -c -o second.o second.cpp
mainr2: main2.o first.o second.o
	g++ -o mainr2.exe main2.o first.o second.o
mainr3: main3.o first.o second.o
	g++ -o mainr3.exe main2.o first.o second.o

# Часть 3
# Создание статической библиотеки
libmain.a: first.o second.o
	ar crs main.a first.o second.o
main2: main2.o libmain.a
	g++ -o main2 main2.o -L. -lmain
main3: main3.o libmain.a
	g++ -o main3 main3.o -L. -lmain

tasktwo: main1 main2 main3

# Часть 1
main1: main1.cpp
	g++ -g main1.cpp -o main1.exe
# Часть 2
main2: main2.cpp
	g++ -g main2.cpp -o main2.exe
# Часть 3
strings.o: strings.cpp
	g++ -g -c strings.cpp
msin3.o: main3.cpp
	g++ -g -c main3.cpp
libstring.a: strings.o
	ar crs libstring.a strings.o
main3: main3.o libstring.a
	g++ -g -o main3 main.o -L. -libstring

taskthree: main

main.o: main.cpp
	g++ -c -o main.o main.cpp
arrayLib.o: arrayLib.cpp arrayLib.h
	g++ -c -o arrayLib.o arrayLib.cpp
matrixLib.o: matrixLib.cpp matrixLib.h
	g++ -c -o matrixLib.o matrixLib.cpp
loadLib.o: loadLib.cpp loadLib.h
	g++ -c -o loadLib.o loadLib.cpp
arrayLib.dll: arrayLib.o
	g++ -o arrayLib.dll arrayLib.o
matrixLib.dll: matrixLib.o
	g++ -o matrixLib.dll matrixLib.o
loadLib.dll: loadLib.o
	g++ -o loadLib.dll loadLib.o
main.exe: main.o loadLib.dll
	g++ -o main.exe main.o -L./ -lloadLib

# Отчистка
.PHONY: clean
clean:
	del *.o
	del *.s
	del *.l
	del *.a
	del *.exe