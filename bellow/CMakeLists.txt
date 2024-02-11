cmake_minimum_required(VERSION 3.28)
project(bellow)

set(CMAKE_CXX_STANDARD 17)

add_library(bellow STATIC library.cpp
        money/click/click.cpp
        money/click/click.h
        money/create/signature.cpp
        money/create/signature.h)
