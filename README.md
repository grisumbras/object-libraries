# object-libraries

> Helper functions to manage CMake object libraries

It is sometimes desirable to treat some object files as a separate entity,
without linking or archiving them. CMake provides **object libraries** for
that, but using them isn't exactly straightforward. This project attempts to
mitigate the issue.


## Table of Contents

* [Background](#background)
* [Install](#install)
* [Usage](#usage)
* [API](#api)
  + [`add_object_files`](#add_object_files)
  + [`get_underlying_objects`](#get_underlying_objects)
* [Contribute](#contribute)
* [License](#license)


## Background

So, what are the reasons to using object files that are not linked into a
binary? The number one reason is object file reuse. Suppose you have an
executable and a unit test runner, they obviously need to share object files
that contain the code being tested. Another reason is setting special compiler
flags for a subset of object files.

Now, why the need for a dedicated project to create object libraries, after
all, CMake already has a command that does it? Well, have you used a CMake
object library? Was it as convenient and idiomatic as using proper libraries?
This project tries to provide an interface to create object libraries in such
a way, so using them is simple.


## Install

This package requires at least CMake 3.5.  It can be installed from sources
using CMake. First, obtain a copy of the sources via git or otherwise:

```shell
$ git clone https://github.com/grisumbras/object-libraries.git
```

After that, you can either install it, or use it as a subproject of your
project. For the former, enter the project directory, then run CMake to
configure and install.

```shell
$ cd object-libraries
$ cmake -DCMAKE_INSTALL_PREFIX=your/install/prefix .
$ cmake --build . --target install
```

For the latter, no further actions needed.


## Usage

In order to use the _installed_ package, you need to import it inside one of
your `CMakeLists.txt` files:

```cmake
find_package(ObjectLibraries)
```

In order to use the project as a subproject, use `add_subdirectory` command,
but specify the build directory also:

```cmake
add_subdirectory(path/to/object-libraries/sources object-libraries)
```


## API

### add_object_files

`add_object_files(<target> [NO_INCLUDE_CURRENT_DIR] source1 [source2 ...])`

Adds two targets: a backend **object library**, that compiles specified sources
into object files, and a frontend **interface library**, called `<target>`,
that could be used by dependent targets to link with those object files. If
you need to set some properties on object files, you can use standard commands
on the frontend target. By defalt, `<target>` adds current source directory
to the list of include directories of its dependent targets, to disable that
use `NO_INCLUDE_CURRENT_DIR` option. Example usage:

```cmake
add_object_files(foo_objs a.cpp b.cpp)
target_compile_definitions(foo_objs FOO_MACRO)

add_executable(foo main.cpp)
target_link_libraries(foo PRIVATE foo_objs)

add_executable(foo-test test.cpp)
target_link_libraries(foo PRIVATE foo_objs)
```


### get_underlying_objects

`get_underlying_objects(<var> <target>)`

Sets `<var>` to the name of the backend object library corresponding to the
interface library `<target>`, that was created by `add_object_files`.
Usually, you only have to deal with the frontend target, but for the cases,
where that is not enough, you can use this function. Example usage:

```cmake
add_object_files(objs x.cpp)
get_underlying_objects(objs_bkend objs)
# set an option for a single object file, not for the whole linked binary
target_compile_options(objs_bkend -fobscure-option)
```

## License

[BSL-1.0](./LICENSE) (C) Dmitry Arkhipov
