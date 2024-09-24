#include <stdio.h>
#include <iostream>
#include <numeric>
#include <limits>

// функция для очитски от символов потока ввода и утсановки флага "состояния" потока в 0
void stream_cleaning()
{
	std::cin.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
}

int inputArr(int* arr, int n)
{	
	std::cout << "int inputArr(int* arr, int n)" << std::endl;
	for (int i=0; i < n; )
	{
		int tmp{};
		std::cin >> tmp;
		if (std::cin.fail())
		{
			std::cin.clear();
			stream_cleaning();
			std::cout << "Input error, re-enter the item" << std::endl;
		}
		else {			
			stream_cleaning();
			arr[i] = tmp;
			++i;
		}
	}
	return 0;
}

void printArr(int* arr, int n)
{
	for (int i = 0; i < n; ++i)
		std::cout << arr[i] << '\t';
}