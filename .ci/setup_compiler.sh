set -x
set -e

if [ "$CXX" == "g++" ];
then
    export GCOV=/usr/bin/gcov-$GCC_VERSION
fi




if [ "$LIBCXX" == "on" ]; then

    cd $THIRD_PARTY_ROOT

    if   [[ "${COMPILER}" == "clang++-3.5" ]]; then LLVM_VERSION="3.5.2"
    elif [[ "${COMPILER}" == "clang++-3.6" ]]; then LLVM_VERSION="3.6.2";
    elif [[ "${COMPILER}" == "clang++-3.7" ]]; then LLVM_VERSION="3.7.0";
    else                                            LLVM_VERSION="trunk"; fi
    
    if [[ "${LLVM_VERSION}" != "trunk" ]]; then
        LLVM_URL="http://llvm.org/releases/${LLVM_VERSION}/llvm-${LLVM_VERSION}.src.tar.xz"
        LIBCXX_URL="http://llvm.org/releases/${LLVM_VERSION}/libcxx-${LLVM_VERSION}.src.tar.xz"
        LIBCXXABI_URL="http://llvm.org/releases/${LLVM_VERSION}/libcxxabi-${LLVM_VERSION}.src.tar.xz"
        TAR_FLAGS="-xJ"
    else
        LLVM_URL="https://github.com/llvm-mirror/llvm/archive/master.tar.gz"
        LIBCXX_URL="https://github.com/llvm-mirror/libcxx/archive/master.tar.gz"
        LIBCXXABI_URL="https://github.com/llvm-mirror/libcxxabi/archive/master.tar.gz"
        TAR_FLAGS="-xz"
    fi

    mkdir -p llvm llvm/build llvm/projects/libcxx llvm/projects/libcxxabi
    travis_retry wget --quiet -O - ${LLVM_URL} | tar --strip-components=1 ${TAR_FLAGS} -C llvm
    travis_retry wget --quiet -O - ${LIBCXX_URL} | tar --strip-components=1 ${TAR_FLAGS} -C llvm/projects/libcxx
    travis_retry wget --quiet -O - ${LIBCXXABI_URL} | tar --strip-components=1 ${TAR_FLAGS} -C llvm/projects/libcxxabi
    (cd llvm/build && cmake .. -DCMAKE_INSTALL_PREFIX=${DEPS_DIR}/llvm/install -DCMAKE_CXX_COMPILER=clang++)
    (cd llvm/build/projects/libcxx && make install -j2)
    (cd llvm/build/projects/libcxxabi && make install -j2)
    export CXXFLAGS="-isystem ${THIRD_PARTY_ROOT}/llvm/install/include/c++/v1"
    export LDFLAGS="-L ${THIRD_PARTY_ROOT}/llvm/install/lib -l c++ -l c++abi"
    export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${THIRD_PARTY_ROOT}/llvm/install/lib"
fi


if [ -n "$COVERALLS_BUILD" ];
then

    # gcc 4.9 does not work with lcov 1.10, we need to install lcov 1.11
    cd $THIRD_PARTY_ROOT
    curl http://ftp.uk.debian.org/debian/pool/main/l/lcov/lcov_1.11.orig.tar.gz -O
    tar xfz lcov_1.11.orig.tar.gz
    mkdir -p lcov && make -C lcov-1.11/ install PREFIX=$THIRD_PARTY_ROOT/lcov
    ls $THIRD_PARTY_ROOT/lcov/usr/bin
    export PATH=$THIRD_PARTY_ROOT/lcov/usr/bin:$PATH
    rm -Rf lcov-1.11/ lcov_1.11.orig.tar.gz
    
    gem install coveralls-lcov
fi

