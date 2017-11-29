include(${CMAKE_CURRENT_SOURCE_DIR}/objects.cmake)


set(export_dir lib/cmake/${PROJECT_NAME})


install(
  FILES objects.cmake
  RENAME ${PROJECT_NAME}Config.cmake
  DESTINATION ${export_dir}
)


install(FILES objects.cmake DESTINATION ${export_dir})
