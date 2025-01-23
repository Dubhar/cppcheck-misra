// This is an example program that violates several misra rules.

#include <iostream>
using namespace std;

int globalVariable = 42;

void printMessage(char* message) {
    cout << message << endl;
}

int main() {
    int *ptr = new int(5);

    printMessage("Hello, world!");

    delete ptr;
    cout << *ptr << endl;

    float myFloat = 5.75f;
    int myInt = (int)myFloat;

    return 0;
}
