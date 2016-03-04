/*
 * main.cpp
 * Date: 2015-05-14
 * Author: Karsten Ahnert (karsten.ahnert@gmx.de)
 * Copyright: Karsten Ahnert
 *
 *
 */

#include <cit/api.hpp>

#include <boost/program_options.hpp>

#include <iostream>

namespace po = boost::program_options;



inline auto get_options( void )
{
    po::options_description options( "Options" );
    options.add_options()
    ( "normalize" , po::value< bool >() , "normalize the input data" )
    ;
    return options;
}

int main( int argc , char *argv[] )
{
    auto options = get_options();
    
    po::options_description cmdline_options;
    cmdline_options.add( options );
    
    po::variables_map vm;
    try
    {
        po::store( po::command_line_parser( argc , argv ).options( cmdline_options ).run() , vm );
        po::notify( vm );
    }
    catch( std::exception& e )
    {
        std::cerr << "Error " << e.what() << "\n\n";
        std::cerr << cmdline_options << "\n";
        return -1;
    }


    std::cout << cit::foo1( 10 ) << std::endl;
    std::cout << cit::foo2( 10 ) << std::endl;
    return 0;
}
