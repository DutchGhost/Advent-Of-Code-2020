#include <fstream>
#include <iostream>
#include <ostream>
#include <ranges>
#include <string>
#include <vector>

template <typename T>
concept Add = requires(T x) {
    x + x;
};

template <typename T>
concept Mul = requires(T x) {
    x *x;
};

using namespace std::ranges::views;

template <typename T>
requires Add<T> && Mul<T>
auto part1(const std::vector<T> &input, T target) noexcept {
    auto idx = 0;
    for (auto a : input) {
        idx += 1;
        auto selection =
            input | drop(idx) |
            filter([a, target](int b) { return a + b == target; }) |
            transform([a](int b) { return a * b; });
        for (auto answer : selection)
            return answer;
    }
}

auto part2(const std::vector<int> &input, int target) noexcept {
    size_t input_size = input.size();

    for (int i = 0; i < input_size; i++) {
        for (int j = i; j < input_size; j++) {
            for (int k = j; k < input_size; k++) {
                if (input[i] + input[j] + input[k] == target) {
                    return input[i] * input[j] * input[k];
                }
            }
        }
    }

    return 0;
}

const int TARGET = 2020;

int main() {
    std::ifstream file{"../../Inputs/day01.txt"};
    std::vector<int> v;
    int input;
    while (file >> input) {
        v.push_back(input);
    }

    std::cout << part1(v, TARGET) << std::endl;
    std::cout << part2(v, TARGET) << std::endl;
}
