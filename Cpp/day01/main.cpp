#include <iostream>
#include <string>
#include <ostream>
#include <fstream>
#include <vector>

auto part1(const std::vector<int>& input, int target) noexcept {
    size_t input_size = input.size();

    for(int i = 0; i < input_size; i++) {
        for(int j = i; j < input_size; j++) {
            if (input[i] + input[j] == target) {
                return input[i] * input[j];
            }
        }
    }

    return 0;
}

auto part2(const std::vector<int>& input, int target) noexcept {
    size_t input_size = input.size();

    for(int i = 0; i < input_size; i++) {
        for(int j = i; j < input_size; j++) {
            for(int k = j; k < input_size; k++) {
                if(input[i] + input[j] + input[k] == target) {
                    return input[i] * input[j] * input[k];
                }
            }
        }
    } 

    return 0;
}


const int TARGET = 2020;

int main() {
    std::ifstream file {"../../Inputs/day01.txt"};
    std::vector<int> v;
    int input;
    while(file >> input) {
        v.push_back(input);
    }

    std::cout << part1(v, TARGET) << std::endl; 
    std::cout << part2(v, TARGET) << std::endl; 
}
