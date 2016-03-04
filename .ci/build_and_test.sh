set -x
set -e

cd build

export CMAKE_OPTIONS="-DCMAKE_BUILD_TYPE=$BUILD_TYPE"

# if [ -n "COVERALLS_BUILD" ];
# then
#     export CMAKE_OPTIONS="$CMAKE_OPTIONS -DTEST_COVERAGE=ON"
# fi

ldd ../../third_party/boost/stage/lib/libboost_program_options.so
ldd CMakeFiles/example1.dir/example1.cpp.o

cmake .. $CMAKE_OPTIONS
make -j 3 VERBOSE=1



ctest -V



# if [ -n "$RUN_VALGRIND" ];
# then 
#     VALGRIND_CMD="valgrind --leak-check=full --show-reachable=yes --error-exitcode=1 "
#     $VALGRIND_CMD test/cit_tests
# fi
