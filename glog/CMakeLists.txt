cmake_minimum_required(VERSION 2.8.12)

if(UNIX)
    set(GLOG_SOURCES_DIR "${CMAKE_CURRENT_SOURCE_DIR}/src")
    set(GLOG_BUILD_PREFIX "${TARGET_DIRECTORY}/glog")
    set(GLOG_WORKING_DIR ${CMAKE_CURRENT_BINARY_DIR})

    add_custom_target(GlogConfigure ALL
        COMMAND "${GLOG_SOURCES_DIR}/configure"
        "--prefix=${GLOG_BUILD_PREFIX}"
        WORKING_DIRECTORY ${GLOG_SOURCES_DIR}
        COMMENT "Configure GLog"
        )

    add_custom_target(GlogBuild
        COMMAND ${CMAKE_MAKE_PROGRAM}
        WORKING_DIRECTORY ${GLOG_SOURCES_DIR}
        DEPENDS GlogConfigure
        COMMENT "Build GLog"
        )

    add_custom_target(GlogInstall ALL
        COMMAND ${CMAKE_MAKE_PROGRAM} install
        WORKING_DIRECTORY ${GLOG_SOURCES_DIR}
        DEPENDS GlogBuild
        COMMENT "Install GLog"
        )
else()
    message(FATAL_ERROR "Unsupported platform")
endif()

add_dependencies(install GlogInstall)
