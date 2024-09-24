#include <iostream>
#include "first.h"
#include "second.h"

const size_t A{30};
const size_t B{15};

int main() 
{
    std::cout << "Input array A(30)" << std::endl;
    int* arrA = new int[A]; 
    inputArr(arrA, A);
    
    std::cout << "Input array B(15)" << std::endl;
    int* arrB = new int[B];
    inputArr(arrB, B);
    twoArr(arrA, A, arrB, B);

    // Освобождение памяти
    delete[] arrA; 
    delete[] arrB; 

    return 0;
}

// Вариант 1
// g++ -c first.cpp -o fisrt.o
// g++ -c second.cpp -o second.o
// g++ -c mainone.cpp -o mainone.o
// g++ .\mainone.o .\first.o .\second.o -o main.exe


// Вариант 2
// g++ -c first.cpp -o fisrt.o
// g++ -c second.cpp -o second.o
// g++ .\mainone.сpp .\first.o .\second.o -o main.exe