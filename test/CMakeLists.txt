add_executable ( ci_tests
  api.cpp
  )

target_link_libraries ( ci_tests gtest gtest_main )

add_test( NAME ci_tests COMMAND ci_tests )
