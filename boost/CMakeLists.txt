cmake_minimum_required(VERSION 2.8.12)

set(BOOST_BUILD_PREFIX "${TARGET_DIRECTORY}/boost")
set(BOOST_WORKING_DIR "${CMAKE_CURRENT_SOURCE_DIR}/src")

if(UNIX)
    set(CONFIGURE_COMMAND "bootstrap.sh")
    set(BOOST_BUILD_COMMAND "b2")
elseif(WIN32)
    set(CONFIGURE_COMMAND "bootstrap.bat")
    set(BOOST_BUILD_COMMAND "b2.exe")
else()
    message(FATAL_ERROR "Unsupported platform")
endif()

add_custom_command(
    OUTPUT ${BOOST_WORKING_DIR}/${BOOST_BUILD_COMMAND}
    COMMAND ${CONFIGURE_COMMAND}
    WORKING_DIRECTORY ${BOOST_WORKING_DIR}
    COMMENT "Configure Boost"
)

add_custom_target(BoostBuild ALL
    COMMAND ${BOOST_BUILD_COMMAND} headers
    COMMAND ${BOOST_BUILD_COMMAND} install
        "--with-thread"
        "--with-system"
        "--with-chrono"
        "--with-program_options"
        "--with-filesystem"
        "--with-date_time"
        "--prefix=${BOOST_BUILD_PREFIX}"
    WORKING_DIRECTORY ${BOOST_WORKING_DIR}
    DEPENDS ${BOOST_WORKING_DIR}/${BOOST_BUILD_COMMAND}
    COMMENT "Build Boost"
)

add_dependencies(install BoostBuild)
