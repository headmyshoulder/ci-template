/*
 * main.cpp
 * Date: 2015-05-14
 * Author: Karsten Ahnert (karsten.ahnert@gmx.de)
 * Copyright: Karsten Ahnert
 *
 *
 */

#include <cit/api.hpp>

#include <gtest/gtest.h>

TEST( api_tests , foo1 )
{
    EXPECT_EQ( 20 , cit::foo1( 10 ) );
}