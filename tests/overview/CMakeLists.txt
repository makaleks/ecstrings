set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}/overview")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/overview")

add_library(provider SHARED provider.c provider.h)
add_executable(overview overview.c provider.h)

target_link_libraries(overview provider)
target_link_libraries(overview ecstrings_static)

add_test(NAME overview-test COMMAND overview)
