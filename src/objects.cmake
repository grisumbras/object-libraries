function(add_object_files target)
  cmake_parse_arguments(add_object_files NO_INCLUDE_CURRENT_DIR "" "" ${ARGN})

  add_library(${target} INTERFACE)
  add_library(_${target}_impl OBJECT ${add_object_files_UNPARSED_ARGUMENTS})

  set_property(
    TARGET ${target}
    PROPERTY INTERFACE_SOURCES $<TARGET_OBJECTS:_${target}_impl>
  )

  foreach(
    prop
    AUTOUIC_OPTIONS
    COMPILE_DEFINITIONS
    COMPILE_FEATURES
    COMPILE_OPTIONS
    INCLUDE_DIRECTORIES
    LINK_LIBRARIES
    POSITION_INDEPENDENT_CODE
    SYSTEM_INCLUDE_DIRECTORIES
  )
    set_target_properties(
      _${target}_impl
      PROPERTIES ${prop} $<TARGET_PROPERTY:${target},INTERFACE_${prop}>
    )
  endforeach()

  if(NOT add_object_files_NO_INCLUDE_CURRENT_DIR)
    target_include_directories(${target} INTERFACE "${CMAKE_CURRENT_SOURCE_DIR}")
  endif()
endfunction()


function(get_underlying_objects var target)
  set(${var} _${target}_impl PARENT_SCOPE)
endfunction()
