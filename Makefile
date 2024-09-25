# Компилятор и флаги
CXX = g++
CXXFLAGS = -g -Wall
AR = ar
ARFLAGS = crs

# Папки
TASKONE_SRC = taskone
TASKTWO_SRC = tasktwo
TASKTHREE_SRC = taskthree
BUILD_DIR = build

# Цели по умолчанию
all: taskone tasktwo taskthree

# Создаем папку для сборки, если она не существует
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

# Задача 1 (taskone)
taskone: $(BUILD_DIR)/taskone/main1.exe $(BUILD_DIR)/taskone/mainr2.exe $(BUILD_DIR)/taskone/mainr3.exe

# Поэтапная компиляция (часть 1)
$(BUILD_DIR)/taskone/main1.o: $(TASKONE_SRC)/main1.cpp | $(BUILD_DIR)
	$(CXX) -c -o $@ $(CXXFLAGS) $(TASKONE_SRC)/main1.cpp

$(BUILD_DIR)/taskone/main1.exe: $(BUILD_DIR)/taskone/main1.o | $(BUILD_DIR)
	$(CXX) -o $@ $(BUILD_DIR)/taskone/main1.o

# Оптимизация (часть 1)
$(BUILD_DIR)/taskone/optim1.s: $(TASKONE_SRC)/main1.cpp | $(BUILD_DIR)
	$(CXX) -S -O1 -o $@ $(TASKONE_SRC)/main1.cpp

$(BUILD_DIR)/taskone/optim2.s: $(TASKONE_SRC)/main1.cpp | $(BUILD_DIR)
	$(CXX) -S -O2 -o $@ $(TASKONE_SRC)/main1.cpp

$(BUILD_DIR)/taskone/optim3.s: $(TASKONE_SRC)/main1.cpp | $(BUILD_DIR)
	$(CXX) -S -O3 -o $@ $(TASKONE_SRC)/main1.cpp

# Раздельная компиляция (часть 2)
$(BUILD_DIR)/taskone/main2.o: $(TASKONE_SRC)/main2.cpp | $(BUILD_DIR)
	$(CXX) -c -o $@ $(CXXFLAGS) $(TASKONE_SRC)/main2.cpp

$(BUILD_DIR)/taskone/main3.o: $(TASKONE_SRC)/main3.cpp | $(BUILD_DIR)
	$(CXX) -c -o $@ $(CXXFLAGS) $(TASKONE_SRC)/main3.cpp

$(BUILD_DIR)/taskone/first.o: $(TASKONE_SRC)/first.cpp | $(BUILD_DIR)
	$(CXX) -c -o $@ $(CXXFLAGS) $(TASKONE_SRC)/first.cpp

$(BUILD_DIR)/taskone/second.o: $(TASKONE_SRC)/second.cpp | $(BUILD_DIR)
	$(CXX) -c -o $@ $(CXXFLAGS) $(TASKONE_SRC)/second.cpp

$(BUILD_DIR)/taskone/mainr2.exe: $(BUILD_DIR)/taskone/main2.o $(BUILD_DIR)/taskone/first.o $(BUILD_DIR)/taskone/second.o | $(BUILD_DIR)
	$(CXX) -o $@ $^

$(BUILD_DIR)/taskone/mainr3.exe: $(BUILD_DIR)/taskone/main3.o $(BUILD_DIR)/taskone/first.o $(BUILD_DIR)/taskone/second.o | $(BUILD_DIR)
	$(CXX) -o $@ $^

# Создание статической библиотеки (часть 3)
$(BUILD_DIR)/taskone/libmain.a: $(BUILD_DIR)/taskone/first.o $(BUILD_DIR)/taskone/second.o | $(BUILD_DIR)
	$(AR) $(ARFLAGS) $@ $^

$(BUILD_DIR)/taskone/main2: $(BUILD_DIR)/taskone/main2.o $(BUILD_DIR)/taskone/libmain.a | $(BUILD_DIR)
	$(CXX) -o $@ $(BUILD_DIR)/taskone/main2.o -L$(BUILD_DIR)/taskone -lmain

$(BUILD_DIR)/taskone/main3: $(BUILD_DIR)/taskone/main3.o $(BUILD_DIR)/taskone/libmain.a | $(BUILD_DIR)
	$(CXX) -o $@ $(BUILD_DIR)/taskone/main3.o -L$(BUILD_DIR)/taskone -lmain


# Задача 2 (tasktwo)
tasktwo: $(BUILD_DIR)/tasktwo/main1.exe $(BUILD_DIR)/tasktwo/main2.exe $(BUILD_DIR)/tasktwo/main3.exe

$(BUILD_DIR)/tasktwo/main1.exe: $(TASKTWO_SRC)/main1.cpp | $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -o $@ $(TASKTWO_SRC)/main1.cpp

$(BUILD_DIR)/tasktwo/main2.exe: $(TASKTWO_SRC)/main2.cpp | $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -o $@ $(TASKTWO_SRC)/main2.cpp

$(BUILD_DIR)/tasktwo/strings.o: $(TASKTWO_SRC)/strings.cpp | $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -c -o $@ $(TASKTWO_SRC)/strings.cpp

$(BUILD_DIR)/tasktwo/main3.o: $(TASKTWO_SRC)/main3.cpp | $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -c -o $@ $(TASKTWO_SRC)/main3.cpp

$(BUILD_DIR)/tasktwo/libstring.a: $(BUILD_DIR)/tasktwo/strings.o | $(BUILD_DIR)
	$(AR) $(ARFLAGS) $@ $^

$(BUILD_DIR)/tasktwo/main3.exe: $(BUILD_DIR)/tasktwo/main3.o $(BUILD_DIR)/tasktwo/libstring.a | $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -o $@ $^


# Задача 3 (taskthree)
taskthree: $(BUILD_DIR)/taskthree/main.exe

$(BUILD_DIR)/taskthree/main.o: $(TASKTHREE_SRC)/main.cpp | $(BUILD_DIR)
	$(CXX) -c -o $@ $(CXXFLAGS) $(TASKTHREE_SRC)/main.cpp

$(BUILD_DIR)/taskthree/arrayLib.o: $(TASKTHREE_SRC)/arrayLib.cpp $(TASKTHREE_SRC)/arrayLib.h | $(BUILD_DIR)
	$(CXX) -c -o $@ $(CXXFLAGS) $(TASKTHREE_SRC)/arrayLib.cpp

$(BUILD_DIR)/taskthree/matrixLib.o: $(TASKTHREE_SRC)/matrixLib.cpp $(TASKTHREE_SRC)/matrixLib.h | $(BUILD_DIR)
	$(CXX) -c -o $@ $(CXXFLAGS) $(TASKTHREE_SRC)/matrixLib.cpp

$(BUILD_DIR)/taskthree/loadLib.o: $(TASKTHREE_SRC)/loadLib.cpp $(TASKTHREE_SRC)/loadLib.h | $(BUILD_DIR)
	$(CXX) -c -o $@ $(CXXFLAGS) $(TASKTHREE_SRC)/loadLib.cpp

# Создание динамических библиотек
$(BUILD_DIR)/taskthree/arrayLib.dll: $(BUILD_DIR)/taskthree/arrayLib.o | $(BUILD_DIR)
	$(CXX) -shared -o $@ $(BUILD_DIR)/taskthree/arrayLib.o

$(BUILD_DIR)/taskthree/matrixLib.dll: $(BUILD_DIR)/taskthree/matrixLib.o | $(BUILD_DIR)
	$(CXX) -shared -o $@ $(BUILD_DIR)/taskthree/matrixLib.o

$(BUILD_DIR)/taskthree/loadLib.dll: $(BUILD_DIR)/taskthree/loadLib.o | $(BUILD_DIR)
	$(CXX) -shared -o $@ $(BUILD_DIR)/taskthree/loadLib.o

$(BUILD_DIR)/taskthree/main.exe: $(BUILD_DIR)/taskthree/main.o $(BUILD_DIR)/taskthree/loadLib.dll | $(BUILD_DIR)
	$(CXX) -o $@ $(BUILD_DIR)/taskthree/main.o -L$(BUILD_DIR)/taskthree -lloadLib

# Очистка
.PHONY: clean
clean:
	rm -rf $(BUILD_DIR)