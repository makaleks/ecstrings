set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}/lib")
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_ARCHIVE_OUTPUT_DIRECTORY}/lib")

list(APPEND sources "ecstrings.c")

add_library(ecstrings_objects OBJECT ${sources})

if (WIN32)
    set(PLATFORM_NAME "'WIN'")
    # https://docs.microsoft.com/en-us/cpp/build/reference/compiler-options-listed-by-category
    list(APPEND c_flags
        "/WX" "/W4"
    )
else()
    set(PLATFORM_NAME "'POSX'")
    list(APPEND c_flags
        # It is impossible to include all GCC warnings
        # https://stackoverflow.com/a/11720263
        "-Werror" "-Wall" "-Wextra" "-pedantic"
    )
endif()

target_compile_options(ecstrings_objects PRIVATE ${c_flags})

add_library(ecstrings_static STATIC $<TARGET_OBJECTS:ecstrings_objects>)
add_library(ecstrings_shared SHARED $<TARGET_OBJECTS:ecstrings_objects>)

# Project name already contains 'lib' prefix
set_target_properties(
    ecstrings_static ecstrings_shared
    PROPERTIES
    OUTPUT_NAME "ecstrings"
)

file(
    RELATIVE_PATH STATIC_LIB_RELATIVE_PATH
    ${PROJECT_BINARY_DIR}
    "${CMAKE_ARCHIVE_OUTPUT_DIRECTORY}/${CMAKE_STATIC_LIBRARY_PREFIX}ecstrings${CMAKE_STATIC_LIBRARY_SUFFIX}"
)
file(
    RELATIVE_PATH SHARED_LIB_RELATIVE_PATH
    ${PROJECT_BINARY_DIR}
    "${CMAKE_ARCHIVE_OUTPUT_DIRECTORY}/${CMAKE_SHARED_LIBRARY_PREFIX}ecstrings${CMAKE_SHARED_LIBRARY_SUFFIX}"
)
_ecstrings_get_project_layout_final_constants(
    CHECK_STATIC_LIBRARY_RELATIVE_PATH ${STATIC_LIB_RELATIVE_PATH}
    CHECK_SHARED_LIBRARY_RELATIVE_PATH ${SHARED_LIB_RELATIVE_PATH}
)
