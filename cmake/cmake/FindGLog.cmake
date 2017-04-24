# - Try to find Glog
#
# The following variables are optionally searched for defaults
#  GLOG_ROOT:            Base directory where all GLOG components are found
#
# The following are set after configuration is done:
#  GLOG_FOUND
#  GLOG_INCLUDE_DIRS
#  GLOG_LIBRARIES
#  GLOG_LIBRARYRARY_DIRS

include(FindPackageHandleStandardArgs)

    find_path(GLOG_INCLUDE_DIR glog/logging.h
        PATHS ${GLOG_ROOT}/include)

if(MSVC)
    find_library(GLOG_LIBRARY_RELEASE libglog
        PATHS ${GLOG_ROOT}
        PATH_SUFFIXES lib)

    find_library(GLOG_LIBRARY_DEBUG libglogd
        PATHS ${GLOG_ROOT}
        PATH_SUFFIXES lib)

    set(GLOG_LIBRARY optimized ${GLOG_LIBRARY_RELEASE} debug ${GLOG_LIBRARY_DEBUG})
else()
    find_library(GLOG_LIBRARY glog
        PATHS ${GLOG_ROOT}
        PATH_SUFFIXES lib)
endif()

find_package_handle_standard_args(Glog DEFAULT_MSG GLOG_INCLUDE_DIR GLOG_LIBRARY)

if(GLOG_FOUND)
  set(GLOG_INCLUDE_DIRS ${GLOG_INCLUDE_DIR})
  set(GLOG_LIBRARIES ${GLOG_LIBRARY})
  message(STATUS "Found glog")
  mark_as_advanced(GLOG_ROOT GLOG_LIBRARY_RELEASE GLOG_LIBRARY_DEBUG
                                 GLOG_LIBRARY GLOG_INCLUDE_DIR)
endif()
