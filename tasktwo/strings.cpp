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