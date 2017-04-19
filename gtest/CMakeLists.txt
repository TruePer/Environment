cmake_minimum_required(VERSION 2.8.12)

set(BUILD_SHARED_LIBS ON)

add_custom_target(ConfigureRelease
    COMMAND ${CMAKE_COMMAND}
        "-G \"${CMAKE_GENERATOR}\""
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
        "-G \"${CMAKE_GENERATOR}\""
        "${CMAKE_CURRENT_SOURCE_DIR}/build"
        "-DCMAKE_BUILD_TYPE=Debug"
        "-DCMAKE_INSTALL_PREFIX=${TARGET_DIRECTORY}/gtest"
        DEPENDS BuildRelease
    )

add_custom_target(BuildDebug ALL
    COMMAND ${CMAKE_MAKE_PROGRAM} all install
    DEPENDS ConfigureDebug
    )

