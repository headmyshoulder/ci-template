set -x
set -e

wget https://googlemock.googlecode.com/files/gmock-1.7.0.zip -O /tmp/gmock.zip
unzip -q /tmp/gmock.zip
mv gmock-1.7.0 $THIRD_PARTY_ROOT/gmock



wget http://sourceforge.net/projects/boost/files/boost/1.57.0/boost_1_57_0.tar.bz2/download -O /tmp/boost.tar.bz2
tar jxf /tmp/boost.tar.bz2
mv boost_1_57_0 $BOOST_ROOT
cd $BOOST_ROOT
./bootstrap.sh


if [ -n "$GCC_VERSION" ]; then  
  echo "using gcc : ${GCC_VERSION} : ${CXX} ;" >> project-config.jam
  TOOLSET="gcc-${GCC_VERSION}"
fi

if [ -n "$CLANG_VERSION" ]; then
    echo "using clang : ${CLANG_VERSION} : ${CXX} ;" >> project-config.jam
    TOOLSET="clang-${CLANG_VERSION}"
fi


export OPTIONS=""
if [ -n "$CXXFLAGS" ]; then export
    OPTIONS="$OPTIONS cxxflags="-std=c++14 $CXXFLAGS"
fi
if [ -n "$LDFLAGS" ]; then
    export OPTIONS="$OPTIONS linkflags=$LDFLAGS"
fi


./b2 --with-thread --with-system --with-program_options -d0 toolset=${TOOLSET} $OPTIONS
