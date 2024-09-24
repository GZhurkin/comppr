#include <stdio.h>
#include <iostream>
#include <numeric>
#include <limits>

// функция для очитски от символов потока ввода и утсановки флага "состояния" потока в 0
void stream_cleaning()
{
	std::cin.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
}

int main() 
{ 
	// Установка локали для корректного отображения русских символов в консоли
	setlocale(LC_ALL, ""); // ставит 1251 в русской винде
	
    int a, b; 
    std::cout << "Input A: "; 
    std::cin >> a; 
    while (std::cin.fail()){
        stream_cleaning();
        std::cout << "Input correct A" << std::endl;
        std::cin >> a; 
        
    }
    std::cout << "Input B: "; 
    std::cin >> b; 
    while (std::cin.fail()){
        stream_cleaning();
        std::cout << "Input correct B" << std::endl;
        std::cin >> b; 
        
    }

    int Pr = a * b;
    bool flag = false; 

    for(int n = 2; n < Pr; ++n)
    { 
        if((n%a == 0) && (n%b == 0)) 
        { 
            std::cout << n << std::endl; 
            flag = true; 
        } 
    } 
    if (!flag) 
        std::cout << "NO ONE" << std::endl; 
    
    return 0; 
}