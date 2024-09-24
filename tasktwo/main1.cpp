#include <iostream>
#include <cmath> // Для функции cos
#include <limits>

void stream_cleaning()
{
	std::cin.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
}

int main() {
    int n;
    double x, y = 0.0;

    // Вводим n и x
    std::cout << "Input n (> 10): ";
    std::cin >> n;

    while (std::cin.fail() || n<=10)
	{
		std::cin.clear();
		stream_cleaning();
		std::cout << "Input error, re-enter the item" << std::endl;
        std::cin >> n;
	}

    
    std::cout << "Input x: ";
    std::cin >> x;

    while (std::cin.fail())
	{
		std::cin.clear();
		stream_cleaning();
		std::cout << "Input error, re-enter the item" << std::endl;
        std::cin >> x;
	}

    // Вычисляем значение y по заданной формуле
    for (int i = 0; i <= n; ++i) {
        y += (n - i) * cos(i * x);
    }

    // Выводим результат
    std::cout << "y = " << y << std::endl;

    return 0;
}