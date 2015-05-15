add_executable ( cit_tests
  api.cpp
  )

target_link_libraries ( cit_tests gtest gtest_main )

add_test( NAME cit_tests COMMAND cit_tests )
