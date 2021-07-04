cmake_minimum_required(VERSION 3.12)
project("ecstrings" LANGUAGES C)
#set(CMAKE_C_STANDARD 99)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

include("scripts/ecstrings_get_project_targets.cmake")
_ecstrings_get_project_layout_final_constants()
set(include_dir ${_ECSTRINGS_INCLUDE_DIRECTORY_RELATIVE_PATH}) # "include"

include_directories("${include_dir}")

include("output_layout.cmake")

add_subdirectory("include")
add_subdirectory("src")

enable_testing()
add_subdirectory("tests")
