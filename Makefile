# Основная цель
all: taskone tasktwo taskthree 

# Задача 1: taskone
taskone: libmain.a main1.i main1.s main1.exe mainr2.exe mainr3.exe optim1.s optim2.s optim3.s main2.exe main3.exe

# Часть 1: Поэтапная компиляция
main1.i: taskone/main1.cpp 
	g++ -E -o main1.i taskone/main1.cpp 

main1.s: taskone/main1.cpp 
	g++ -S -o main1.s taskone/main1.cpp 

main1.o: taskone/main1.cpp 
	g++ -c -o main1.o taskone/main1.cpp 

main1.exe: main1.o 
	g++ main1.o -o main1.exe 

# Оптимизация
optim1.s: taskone/main1.cpp 
	g++ -S -O1 -o optim1.s taskone/main1.cpp 

optim2.s: taskone/main1.cpp 
	g++ -S -O2 -o optim2.s taskone/main1.cpp 

optim3.s: taskone/main1.cpp 
	g++ -S -O3 -o optim3.s taskone/main1.cpp 

# Часть 2: Раздельная компиляция
main2.o: taskone/main2.cpp 
	g++ -c -o main2.o taskone/main2.cpp 

main3.o: taskone/main3.cpp 
	g++ -c -o main3.o taskone/main3.cpp 

first.o: taskone/first.cpp 
	g++ -c -o first.o taskone/first.cpp 

second.o: taskone/second.cpp 
	g++ -c -o second.o taskone/second.cpp 

mainr2.exe: main2.o first.o second.o 
	g++ -o mainr2.exe main2.o first.o second.o 

mainr3.exe: main3.o first.o second.o 
	g++ -o mainr3.exe main3.o first.o second.o 

# Часть 3: Создание статической библиотеки
libmain.a: first.o second.o 
	ar crs libmain.a first.o second.o 

# Использование библиотеки в других mains
main2.exe: main2.o libmain.a 
	g++ -o main2.exe main2.o -L. -lmain 

main3.exe: main3.o libmain.a 
	g++ -o main3.exe main3.o -L. -lmain 

# Задача 2: tasktwo
tasktwo: main1_tasktwo.exe main2_tasktwo.exe main3_tasktwo.exe

# Часть 1 для задачи 2
main1_tasktwo.exe: tasktwo/main1.cpp 
	g++ -g tasktwo/main1.cpp -o main1_tasktwo.exe 

# Часть 2 для задачи 2
main2_tasktwo.exe: tasktwo/main2.cpp 
	g++ -g tasktwo/main2.cpp -o main2_tasktwo.exe 

# Часть 3 для задачи 2
strings.o: tasktwo/strings.cpp 
	g++ -g -c tasktwo/strings.cpp 

main3b.o: tasktwo/main3b.cpp 
	g++ -g -c tasktwo/main3b.cpp 

libstring.a: strings.o 
	ar crs libstring.a strings.o 

main3_tasktwo.exe: main3b.o libstring.a 
	g++ -g -o main3_tasktwo.exe main3b.o -L. -lstring 

# Задача 3: taskthree
taskthree: main_taskthree.exe

main_taskthree.o: taskthree/main.cpp 
	g++ -c -o main_taskthree.o taskthree/main.cpp 

arrayLib.o: taskthree/arrayLib.cpp taskthree/arrayLib.h 
	g++ -c -o arrayLib.o taskthree/arrayLib.cpp 

matrixLib.o: taskthree/matrixLib.cpp taskthree/matrixLib.h 
	g++ -c -o matrixLib.o taskthree/matrixLib.cpp 

loadLib.o: taskthree/loadLib.cpp taskthree/loadLib.h 
	g++ -c -o loadLib.o taskthree/loadLib.cpp 

arrayLib.dll: arrayLib.o 
	g++ -shared -o arrayLib.dll arrayLib.o 

matrixLib.dll: matrixLib.o 
	g++ -shared -o matrixLib.dll matrixLib.o 

loadLib.dll: loadLib.o 
	g++ -shared -o loadLib.dll loadLib.o 

main_taskthree.exe: main_taskthree.o loadLib.dll matrixLib.dll arrayLib.dll
	g++ -o main_taskthree.exe main_taskthree.o -L./ -lloadLib 

# Отчистка
.PHONY: clean
clean:
	del *.i *.o *.s *.a *.exe *.dll