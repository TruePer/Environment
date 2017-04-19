cmake_minimum_required(VERSION 2.8.12)

set(GLOG_SOURCES_DIR "${CMAKE_CURRENT_SOURCE_DIR}/src")
set(GLOG_BUILD_PREFIX "${TARGET_DIRECTORY}/glog")
set(GLOG_WORKING_DIR ${CMAKE_CURRENT_BINARY_DIR})

if(UNIX)
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
elseif(WIN32)
    set(GLOG_VCPROJ_DIR "${GLOG_SOURCES_DIR}/vsprojects/libglog")

    add_custom_command(
        OUTPUT "${GLOG_VCPROJ_DIR}/libglog.vcxproj"
        COMMAND devenv "/Upgrade" "libglog.vcproj"
        WORKING_DIRECTORY ${GLOG_VCPROJ_DIR}
        COMMENT "Upgrade MS Visual Studio project"
        )

    add_custom_target(GlogBuildRelease
        COMMAND msbuild "libglog.vcxproj"
            "/property:OutDir=${GLOG_BUILD_PREFIX}/lib"
            "/property:TargetName=libglog"
            "/property:Configuration=Release"
        WORKING_DIRECTORY ${GLOG_VCPROJ_DIR}
        DEPENDS "${GLOG_VCPROJ_DIR}/libglog.vcxproj"
        COMMENT "GLog release build"
        )

    add_custom_target(GlogBuildDebug
        COMMAND msbuild "libglog.vcxproj"
            "/property:OutDir=${GLOG_BUILD_PREFIX}/lib"
            "/property:TargetName=libglogd"
            "/property:Configuration=Debug"
        WORKING_DIRECTORY ${GLOG_VCPROJ_DIR}
        DEPENDS GlogBuildRelease
        COMMENT "GLog debug build"
        )

    add_custom_target(GlogInstall ALL
        COMMAND ${CMAKE_COMMAND} -E copy_directory
            "${GLOG_SOURCES_DIR}/src/windows/glog"
            "${GLOG_BUILD_PREFIX}/include/glog"
        DEPENDS GlogBuildDebug
        COMMENT "Install GLog"
        )
else()
    message(FATAL_ERROR "Unsupported platform")
endif()

add_dependencies(install GlogInstall)
