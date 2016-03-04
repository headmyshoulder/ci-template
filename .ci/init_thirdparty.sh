set -x
set -e

wget https://googlemock.googlecode.com/files/gmock-1.7.0.zip -O /tmp/gmock.zip
unzip -q /tmp/gmock.zip
mv gmock-1.7.0 $THIRD_PARTY_ROOT/gmock



wget http://sourceforge.net/projects/boost/files/boost/1.57.0/boost_1_57_0.tar.bz2/download -O /tmp/boost.tar.bz2
tar jxf /tmp/boost.tar.bz2
mv boost_1_57_0 $THIRD_PARTY_ROOT/boost
export BOOST_ROOT="$THIRD_PARTY_ROOT/boost"
cd $BOOST_ROOT
./bootstrap.sh
./b2 --with-thread --with-system --with-program_options -d0
