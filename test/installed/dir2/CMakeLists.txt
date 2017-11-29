add_executable(exe1 main.cpp)
target_link_libraries(exe1 PRIVATE foo_objs)

add_executable(exe2 main.cpp)
target_link_libraries(exe2 PRIVATE foo_objs)


add_test(exe1 exe1)
add_test(exe1 exe2)
