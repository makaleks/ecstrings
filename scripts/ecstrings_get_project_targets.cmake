# https://cmake.org/cmake/help/latest/command/cmake_parse_arguments.html

function (_ecstrings_get_project_layout_final_constants)
    set(arg_options     "")
    set(
        arg_values
        "CHECK_INCLUDE_DIRECTORY_RELATIVE_PATH"
        "CHECK_STATIC_LIBRARY_RELATIVE_PATH"
        "CHECK_SHARED_LIBRARY_RELATIVE_PATH"
    )
    set(arg_multivalues "")
    cmake_parse_arguments(
        ECSTRINGS "${arg_options}" "${arg_values}" "${arg_multivalues}" ${ARGN}
    )

    set(
        include_directory_relative_path
        "include"
    )
    if (
        DEFINED ECSTRINGS_CHECK_INCLUDE_DIRECTORY_RELATIVE_PATH
        AND NOT "${ECSTRINGS_CHECK_INCLUDE_DIRECTORY_RELATIVE_PATH}"
            STREQUAL "${include_directory_relative_path}"
    )
        message(
            FATAL_ERROR "Include directory path settings are not concordant."
        )
    endif()
    set(
        _ECSTRINGS_INCLUDE_DIRECTORY_RELATIVE_PATH
        ${include_directory_relative_path}
        PARENT_SCOPE
    )

    set(
        static_library_relative_path
        "ecstrings/lib/${CMAKE_STATIC_LIBRARY_PREFIX}ecstrings${CMAKE_STATIC_LIBRARY_SUFFIX}"
    )
    if (
        DEFINED ECSTRINGS_CHECK_STATIC_LIBRARY_RELATIVE_PATH
        AND NOT "${ECSTRINGS_CHECK_STATIC_LIBRARY_RELATIVE_PATH}"
            STREQUAL "${static_library_relative_path}"
    )
        message(
            FATAL_ERROR "Static library path settings are not concordant."
            "\nGot ${ECSTRINGS_CHECK_STATIC_LIBRARY_RELATIVE_PATH}"
            "\nNed ${static_library_relative_path}"
        )
    endif()
    set(
        _ECSTRINGS_STATIC_LIBRARY_RELATIVE_PATH
        ${static_library_relative_path}
        PARENT_SCOPE
    )

    set(
        shared_library_relative_path
        "ecstrings/lib/${CMAKE_SHARED_LIBRARY_PREFIX}ecstrings${CMAKE_SHARED_LIBRARY_SUFFIX}"
    )
    if (
        DEFINED ECSTRINGS_CHECK_SHARED_LIBRARY_RELATIVE_PATH
        AND NOT "${ECSTRINGS_CHECK_SHARED_LIBRARY_RELATIVE_PATH}"
            STREQUAL "${shared_library_relative_path}"
    )
        message(
            FATAL_ERROR "Shared library path settings are not concordant."
        )
    endif()
    set(
        _ECSTRINGS_SHARED_LIBRARY_RELATIVE_PATH
        ${shared_library_relative_path}
        PARENT_SCOPE
    )
endfunction ()

function (ecstrings_get_project_targets)
    set(arg_options     "")
    set(arg_values      "SOURCE_DIR" "BINARY_DIR" "CUSTOM_PREFIX")
    set(arg_multivalues "")
    cmake_parse_arguments(
        ECSTRINGS "${arg_options}" "${arg_values}" "${arg_multivalues}" ${ARGN}
    )

    if (
        DEFINED ENV{OVERRIDE_THIRD_PARTY_SOURCE_DIR}
        AND DEFINED ENV{OVERRIDE_THIRD_PARTY_BINARY_DIR}
    )
        set(ECSTRINGS_SOURCE_DIR $ENV{OVERRIDE_THIRD_PARTY_SOURCE_DIR})
        set(ECSTRINGS_BINARY_DIR $ENV{OVERRIDE_THIRD_PARTY_BINARY_DIR})
        set(
            CMD
"${CMAKE_COMMAND} -E env \
OVERRIDE_THIRD_PARTY_SOURCE_DIR=$ENV{OVERRIDE_THIRD_PARTY_SOURCE_DIR} \
OVERRIDE_THIRD_PARTY_BINARY_DIR=$ENV{OVERRIDE_THIRD_PARTY_BINARY_DIR} \
${CMAKE_COMMAND}"
        )
    else ()
        set(CMD "${CMAKE_COMMAND}")
    endif()

    ExternalProject_Add(ecstrings_dependency
        CMAKE_COMMAND   "${CMD}"
        SOURCE_DIR      "${ECSTRINGS_SOURCE_DIR}"
        PREFIX          "ecstrings_dependency"
        INSTALL_COMMAND ""
        BINARY_DIR      ${ECSTRINGS_BINARY_DIR}
    )
    ExternalProject_Get_Property(ecstrings_dependency SOURCE_DIR BINARY_DIR)

    _ecstrings_get_project_layout_final_constants()

    set(
        "${CUSTOM_PREFIX}ecstrings_include_directory"
        "${SOURCE_DIR}/${_ECSTRINGS_INCLUDE_DIRECTORY_RELATIVE_PATH}"
        PARENT_SCOPE
    )

    set(ecstrings_static_target_name "${CUSTOM_PREFIX}ecstrings_static")
    set(ecstrings_shared_target_name "${CUSTOM_PREFIX}ecstrings_shared")

    add_library(${ecstrings_static_target_name} STATIC IMPORTED GLOBAL)
    add_library(${ecstrings_shared_target_name} SHARED IMPORTED GLOBAL)

    set_target_properties(
        ${ecstrings_static_target_name} PROPERTIES IMPORTED_LOCATION
        "${BINARY_DIR}/${_ECSTRINGS_STATIC_LIBRARY_RELATIVE_PATH}"
    )
    set_target_properties(
        ${ecstrings_shared_target_name} PROPERTIES IMPORTED_LOCATION
        "${BINARY_DIR}/${_ECSTRINGS_SHARED_LIBRARY_RELATIVE_PATH}"
    )

    set(
        ${ecstrings_static_target_name} ${ecstrings_static_target_name} PARENT_SCOPE
    )
    set(
        ${ecstrings_shared_target_name} ${ecstrings_static_target_name} PARENT_SCOPE
    )
endfunction ()
