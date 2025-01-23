# CppCheck MISRA

A docker container that utilizes cppcheck's addon to check sourcecode for MISRA compliance.

## Usage

```shell
docker build -t cppcheck-misra:latest .
docker run --rm -v "$(pwd)/src:/src" -w /src cppcheck-misra:latest 
```
