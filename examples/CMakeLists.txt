add_executable ( example1 example1.cpp )


if ( "${CMAKE_CXX_COMPILER_ID}" MATCHES "Clang" )

  message ( STATUS "CLING CLANG CLONG" )
  target_link_libraries ( example1 ${Boost_PROGRAM_OPTIONS_LIBRARY} c++ c++abi )

else ()

  target_link_libraries ( example1 ${Boost_PROGRAM_OPTIONS_LIBRARY} )

endif ()