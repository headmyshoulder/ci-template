add_executable ( example1 example1.cpp )

message ( STATUS )
message ( STATUS "${Boost_PROGRAM_OPTIONS_LIBRARY}" )

target_link_libraries ( example1 ${Boost_PROGRAM_OPTIONS_LIBRARY} )