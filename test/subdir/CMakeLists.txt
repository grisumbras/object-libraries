cmake_minimum_required(VERSION 3.7)


project(Tester)


set(BUILD_TESTING OFF)
add_subdirectory("${project_root}" object-libraries)
set(BUILD_TESTING ON)


enable_testing()


add_subdirectory(dir1)
add_subdirectory(dir2)
