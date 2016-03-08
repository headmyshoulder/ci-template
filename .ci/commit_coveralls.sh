set -x
set -e

cd build
# lcov --zerocounters --directory test
lcov --gcov-tool=$CGOV --directory test --base-directory $CIT_ROOT/include/cit --capture --output-file coverage.info
lcov --remove coverage.info '/usr*' '*/third_party*' -o coverage.info
coveralls-lcov coverage.info
