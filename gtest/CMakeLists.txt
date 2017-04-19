cmake_minimum_required(VERSION 2.8.12)

set(BUILD_SHARED_LIBS ON)

if(WIN32)
    set(GENERATOR_PARAMETER "-G \"${CMAKE_GENERATOR}\"")
endif()

add_custom_target(ConfigureRelease
    COMMAND ${CMAKE_COMMAND}
        ${GENERATOR_PARAMETER}
        "${CMAKE_CURRENT_SOURCE_DIR}/build"
        "-DCMAKE_BUILD_TYPE=Release"
        "-DCMAKE_INSTALL_PREFIX=${TARGET_DIRECTORY}/gtest"
    )

add_custom_target(BuildRelease
    COMMAND ${CMAKE_MAKE_PROGRAM} all install
    DEPENDS ConfigureRelease
    )

add_custom_target(ConfigureDebug
    COMMAND ${CMAKE_COMMAND}
        ${GENERATOR_PARAMETER}
        "${CMAKE_CURRENT_SOURCE_DIR}/build"
        "-DCMAKE_BUILD_TYPE=Debug"
        "-DCMAKE_INSTALL_PREFIX=${TARGET_DIRECTORY}/gtest"
        DEPENDS BuildRelease
    )

add_custom_target(BuildDebug ALL
    COMMAND ${CMAKE_MAKE_PROGRAM} all install
    DEPENDS ConfigureDebug
    )

add_dependencies(install BuildDebug)

