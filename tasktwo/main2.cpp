#include <iostream>
#include <sstream>
#include <string>

void inputString(std::string &str) {
    std::cout << "Input string before point: ";
    std::getline(std::cin, str);
}

void outputString(const std::string &str) {
    std::cout << "Result: " << str << std::endl;
}

std::string removeWordsStartingWithA(const std::string &str) {
    std::istringstream stream(str);
    std::string word;
    std::string result;

    while (stream >> word) {
        if (!word.empty() && word[0] != 'a' && word[0] != 'A') {
            result += word + " ";
        }
    }

    // Убираем последний пробел, если он есть
    if (!result.empty()) {
        result.pop_back();
    }

    return result;
}

int main() {
    std::string input;
    inputString(input);
    
    // Удаляем все слова, начинающиеся с 'а' или 'А'
    std::string output = removeWordsStartingWithA(input);

    // Выводим результат
    outputString(output);

    return 0;
}
