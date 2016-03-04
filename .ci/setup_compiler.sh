set -x
set -e

if [ "$CXX" == "g++" ];
then
    export GCOV=/usr/bin/gcov-$GCC_VERSION
fi


if [ "$CXX" == "clang++" ];
then
    export LIBCXX_REPO="http://llvm.org/svn/llvm-project/libcxx/trunk"
    # export LIBCXX_REPO="http://llvm.org/svn/llvm-project/libcxx/tags/RELEASE_33/final"
    export LIBCXXABI_REPO="http://llvm.org/svn/llvm-project/libcxxabi/trunk"
    # export LIBCXXABI_REPO="http://llvm.org/svn/llvm-project/libcxxabi/tags/RELEASE_351/final"

    # Install libc++
    svn co --quiet $LIBCXX_REPO libcxx
    cd libcxx/lib && bash buildit
    sudo cp ./libc++.so.1.0 /usr/lib/
    sudo mkdir /usr/include/c++/v1
    cd .. && sudo cp -r include/* /usr/include/c++/v1/
    cd /usr/lib && sudo ln -sf libc++.so.1.0 libc++.so
    sudo ln -sf libc++.so.1.0 libc++.so.1 && cd $cwd
  
    # Install libc++abi
    svn co --quiet $LIBCXXABI_REPO libcxxabi
    cd libcxxabi/lib && bash buildit
    sudo cp ./libc++abi.so.1.0 /usr/lib/
    cd .. && sudo cp -r include/* /usr/include/c++/v1/
    cd /usr/lib && sudo ln -sf libc++abi.so.1.0 libc++abi.so
    sudo ln -sf libc++abi.so.1.0 libc++abi.so.1 && cd $cwd
fi


if [ -n "$COVERALLS_BUILD" ];
then
    # gcc 4.9 does not work with lcov 1.10, we need to install lcov 1.11
    wget -O lcov.tar.gz http://downloads.sourceforge.net/ltp/lcov-1.11.tar.gz
    mkdir lcov
    tar xzf lcov.tar.gz -C ./lcov --strip-components=1
    cd lcov
    sudo make install
    cd ..
    rm -Rf lcov lcov.tar.gz
    
    gem install coveralls-lcov
fi

