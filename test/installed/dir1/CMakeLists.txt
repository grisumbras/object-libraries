add_object_files(foo_objs foo.cpp)
target_compile_definitions(foo_objs INTERFACE FOO_FUNCTION=foo)

get_underlying_objects(foo_objs_bkend foo_objs)
set_target_properties(${foo_objs} PROPERTIES MY_CUSTOM_PROPERTY 1)
