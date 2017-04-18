cmake_minimum_required(VERSION 2.8.12)

set(BUILD_SHARED_LIBS ON)
set(CMAKE_INSTALL_PREFIX "${TARGET_DIRECTORY}/gtest" CACHE STRING "GTest install path" FORCE)
add_subdirectory(src/googletest)
