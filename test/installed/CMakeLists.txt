cmake_minimum_required(VERSION 3.7)


project(Tester)


find_package(ObjectLibraries REQUIRED)


enable_testing()


add_subdirectory(dir1)
add_subdirectory(dir2)
