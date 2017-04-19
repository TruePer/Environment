cmake_minimum_required(VERSION 2.8.12)

if("${CMAKE_BUILD_TYPE}" STREQUAL "Debug")
    set(GTEST_LIB_SUFFIX "d")
endif()

set(GTEST_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/../src/googletest")

include_directories(
    ${GTEST_SOURCE_DIR}/include
    ${GTEST_SOURCE_DIR}
    )

add_library("gtest${GTEST_LIB_SUFFIX}" ${GTEST_SOURCE_DIR}/src/gtest-all.cc)
add_library("gtest_main${GTEST_LIB_SUFFIX}" ${GTEST_SOURCE_DIR}/src/gtest_main.cc)

install(TARGETS "gtest${GTEST_LIB_SUFFIX}" "gtest_main${GTEST_LIB_SUFFIX}"
  DESTINATION lib)
install(DIRECTORY ${GTEST_SOURCE_DIR}/include/gtest
  DESTINATION include)
