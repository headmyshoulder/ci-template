/*
 * main.cpp
 * Date: 2015-05-14
 * Author: Karsten Ahnert (karsten.ahnert@gmx.de)
 * Copyright: Karsten Ahnert
 *
 *
 */

#include <cit/api.hpp>


#include <iostream>

using namespace std;


int main( int argc , char *argv[] )
{
    cout << cit::foo1( 10 ) << endl;
    cout << cit::foo2( 10 ) << endl;
    return 0;
}
