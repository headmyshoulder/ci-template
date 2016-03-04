set -x
set -e

wget https://googlemock.googlecode.com/files/gmock-1.7.0.zip -O /tmp/gmock.zip
unzip -q /tmp/gmock.zip
mv gmock-1.7.0 $THIRD_PARTY_ROOT/gmock



wget http://sourceforge.net/projects/boost/files/boost/1.57.0/boost_1_57_0.tar.bz2/download -O /tmp/boost.tar.bz2
tar jxf /tmp/boost.tar.bz2
mv boost_1_57_0 $THIRD_PARTY_ROOT/boost
export BOOST_ROOT="${THIRD_PARTY_ROOT}/boost"
cd $BOOST_ROOT
./bootstrap.sh

echo "using gcc ; " >> project-config.jam
echo "using gcc : 4.9 : g++-4.9 ;" >> project-config.jam
echo "using gcc : 5.0 : g++-5.0 ;" >> project-config.jam
echo "using gcc : 5.1 : g++-5.1 ;" >> project-config.jam
echo "using gcc : 5.2 : g++-5.2 ;" >> project-config.jam
echo "using gcc : 5.3 : g++-5.3 ;" >> project-config.jam
echo "using gcc : 6.0 : g++-6.0 ;" >> project-config.jam
echo "\n\n" >> project-config.jam
echo "using clang : 3.5 : clang++3.5 ;" >> project-config.jam
echo "using clang : 3.6 : clang++3.6 ;" >> project-config.jam
echo "using clang : 3.7 : clang++3.7 ;" >> project-config.jam
echo "using clang : 3.8 : clang++3.8 ;" >> project-config.jam


ADDITIONAL_FLAGS="-std=c+14"
if [ "$LIBCXX" == "on" ]; then
  ADDITIONAL_FLAGS="${ADDITIONAL_FLAGS} -stdlib=libc++"
fi
./b2 --with-thread --with-system --with-program_options -d0 --toolset=$CXX --cxxflags=""
