/*
 * api.hpp
 * Date: 2015-05-14
 * Author: Karsten Ahnert (karsten.ahnert@gmx.de)
 * Copyright: Karsten Ahnert
 *
 *
 */

#ifndef API_HPP_INCLUDED
#define API_HPP_INCLUDED


namespace cit {
    
inline int foo1( int a )
{
    int* p = nullptr;
    if( a > 5 )
    {
        p = new int;
        *p = 5;
    }
    else
    {
        *p = 10;
    }
    int x = a * (*p) * 2;
    delete p;
    
    return x;
}

inline int foo2( int a )
{
    return a * 3;
}
    
}






#endif // API_HPP_INCLUDED
