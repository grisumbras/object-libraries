if(NOT BUILD_TESTING)
  return()
endif()


configure_file(
  runner-subdir.cmake.in
  runner-subdir.cmake
  @ONLY
)


configure_file(
  runner-installed.cmake.in
  runner-installed.cmake
  @ONLY
)


add_test(NAME subdir COMMAND "${CMAKE_COMMAND}" -P runner-subdir.cmake)
add_test(NAME installed COMMAND "${CMAKE_COMMAND}" -P runner-installed.cmake)
