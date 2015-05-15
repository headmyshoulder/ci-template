set -x
set -e

cd build
export CMAKE_OPTIONS="-DCMAKE_BUILD_TYPE=$BUILD_TYPE"
if [ -n "$MASTER_BUILD" ];
then
    export CMAKE_OPTIONS="$CMAKE_OPTIONS -DTEST_COVERAGE=ON"
fi
cmake .. $CMAKE_OPTIONS
make

# clang is broken
# if [ "$CXX" == "clang++" ];
# then
#   exit 0;
# fi

ctest -V

if [ "$TRAVIS_OS_NAME" != "linux" ];
then
  exit 0;
fi

if [ -n "$RUN_VALGRIND" ];
then 
    VALGRIND_CMD="valgrind --leak-check=full --show-reachable=yes --error-exitcode=1 "
    $VALGRIND_CMD test/api_tests
fi
