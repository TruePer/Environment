cmake_minimum_required(VERSION 2.8.12)

set(BOOST_BUILD_PREFIX "${TARGET_DIRECTORY}/boost")
set(BOOST_WORKING_DIR "${CMAKE_CURRENT_SOURCE_DIR}/src")

if(UNIX)
    set(CONFIGURE_COMMAND "bootstrap.sh")
elseif(WIN32)
    set(CONFIGURE_COMMAND "bootstrap.bat")
else()
    message(FATAL_ERROR "Unsupported platform")
endif()

add_custom_target(BoostConfigure
    COMMAND "./${CONFIGURE_COMMAND}"
        "--with-libraries=thread,system,chrono,program_options,filesystem,date_time"
        "--prefix=${BOOST_BUILD_PREFIX}"
    WORKING_DIRECTORY ${BOOST_WORKING_DIR}
    COMMENT "Configure Boost"
)

add_custom_target(BoostBuild
    COMMAND "./b2" "headers"
    COMMAND "./b2"
    WORKING_DIRECTORY ${BOOST_WORKING_DIR}
    DEPENDS BoostConfigure
    COMMENT "Build Boost"
)

add_custom_target(BoostInstall ALL
    COMMAND "./b2" "install"
    WORKING_DIRECTORY ${BOOST_WORKING_DIR}
    DEPENDS BoostBuild
    COMMENT "Install Boost"
)

add_dependencies(install BoostInstall)
