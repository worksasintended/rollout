cmake_minimum_required(VERSION 3.0)

configure_file( jsoncpp-download/CMakeLists.txt.in jsoncpp-download/CMakeLists.txt)
execute_process( COMMAND ${CMAKE_COMMAND} -G ${CMAKE_GENERATOR} . WORKING_DIRECTORY jsoncpp-download)
execute_process( COMMAND ${CMAKE_COMMAND} --build . WORKING_DIRECTORY jsoncpp-download )
add_executable(bin_run main.cpp)

target_link_libraries( bin_run wt wthttp boost_system )
target_link_libraries( bin_run ${CMAKE_BINARY_DIR}/jsoncpp-build/src/lib_json/libjsoncpp.a )
target_include_directories( bin_run PRIVATE ${CMAKE_BINARY_DIR}/jsoncpp-src/include )
