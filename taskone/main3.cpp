#include <iostream> 
#include "libmain.h"
#define MAX_SIZE_STREAM 32767 // значение максимального количества символов которое может быть в потоке
#define M 15

int main() 
{ 
    std::cout << "Input array M(15)" << std::endl; 
    int* arrM = new int[M];
    inputArr(arrM, M); 
    
    int result = smI(arrM, M);
    std::cout << "Summ: " << result << std::endl; // вывод результата
    
    delete[] arrM; 
	
    return 0; 
}