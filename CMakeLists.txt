# CMakeLists.txt
# Date: 2015-05-14
# Author: Karsten Ahnert (karsten.ahnert@gmx.de)
#
# Distributed under the Boost Software License, Version 1.0.
# (See accompanying file LICENSE_1_0.txt or
# copy at http://www.boost.org/LICENSE_1_0.txt)
#


project ( cit )

cmake_minimum_required ( VERSION 2.6 )


set ( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++1y -Wall -Wpedantic -pedantic -Werror" )

if ( "${CMAKE_CXX_COMPILER_ID}" MATCHES "Clang" )
  set ( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -stdlib=libc++" )
endif ()


if ( ${TEST_COVERAGE} )
  message ( STATUS "Build with test coverage support." )
  set ( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} --coverage" )
endif ()
  



include_directories ( include )


add_subdirectory ( examples )


set ( THIRDPARTY_ROOT "${CMAKE_CURRENT_SOURCE_DIR}/third_party" )
set ( GMOCK_ROOT "${THIRDPARTY_ROOT}/gmock" )
set ( GTEST_ROOT "${THIRDPARTY_ROOT}/gmock/gtest" )


if ( IS_DIRECTORY ${GMOCK_ROOT}  AND IS_DIRECTORY ${GTEST_ROOT} )
  
    include_directories ( SYSTEM ${GTEST_ROOT} ${GTEST_ROOT}/include ${GMOCK_ROOT} ${GMOCK_ROOT}/include )
  
    add_library ( gtest ${GTEST_ROOT}/src/gtest-all.cc )
    target_link_libraries ( gtest pthread )
    add_library ( gtest_main ${GTEST_ROOT}/src/gtest_main.cc )
    add_library ( gmock ${GMOCK_ROOT}/src/gmock-all.cc )
  
    enable_testing ( true )
  
    add_subdirectory ( test )

else () 

    if ( NOT IS_DIRECTORY ${GMOCK_ROOT} )
        message ( STATUS "Google C++ Mockin Framework not found in \"${GMOCK_ROOT}\" tests will be disabled !" )
    endif ()

    if ( NOT IS_DIRECTORY ${GTEST_ROOT} )
        message ( STATUS "Google C++ Testing Framework not found in \"${GTEST_ROOT}\" tests will be disabled !" )
    endif ()

endif ()
