#include <iostream>
#include <string>
#include <unordered_set>
#include <cctype>
#include "libstring.h"

int main() {
    std::string input;
    std::cout << "Input string: ";
    inputString(input);

    std::unordered_set<char> seen; // Хранит уже встреченные буквы
    std::string result; // Результирующая строка

    for (char c : input) {
        char lowerC = std::tolower(c); // Приводим символ к нижнему регистру
        // Проверяем, является ли символ буквой
        if (isalpha(lowerC)) {
            // Если буква не встречалась, добавляем её в результат
            if (seen.find(lowerC) == seen.end()) {
                seen.insert(lowerC);
                result += c; // Добавляем оригинальный символ
            }
        } else {
            // Добавляем символы, которые не являются буквами
            result += c;
        }
    }

    std::cout << "Result: " << std::endl;
    outputString(result);
    return 0;
}
