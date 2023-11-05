project(Sudoku++ C CXX)
cmake_minimum_required(VERSION 3.3.2)

include(cmake/App.cmake)

set(SOURCES "src/main.cpp"
            "src/UI/MyWindow.h"
            "src/UI/MyWindow.cpp")

add_app("${SOURCES}")