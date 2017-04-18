cmake_minimum_required(VERSION 2.8.12)

project(env)

if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE "Release" CACHE STRING "Build type")
    message(STATUS "Build type is not set. ${CMAKE_BUILD_TYPE} build type will be used.")
endif()

if(NOT TARGET_DIRECTORY)
    set(TARGET_DIRECTORY "${CMAKE_SOURCE_DIR}/../deploy" CACHE STRING "Target installation directory")
    message(STATUS "Target directory is not specified. Binaries will be stored at '${TARGET_DIRECTORY}'")
endif()

option(ENABLE_GLOG "Enable Google logger" ON)
option(ENABLE_GTEST "Enable Google test" ON)
option(ENABLE_BOOST "Enable Boost" ON)

add_custom_target(install)

if(ENABLE_GTEST)
    add_subdirectory(gtest)
endif()

if(ENABLE_GLOG)
    add_subdirectory(glog)
endif()

if(ENABLE_BOOST)
    add_subdirectory(boost)
endif()
