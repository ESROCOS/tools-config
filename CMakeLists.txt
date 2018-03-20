cmake_minimum_required(VERSION 2.6)

project(esrocos_config)

install(DIRECTORY ${CMAKE_SOURCE_DIR}/templates/
	DESTINATION ${CMAKE_INSTALL_PREFIX}/templates/)

install(DIRECTORY ${CMAKE_SOURCE_DIR}/cmake_modules/
	DESTINATION ${CMAKE_INSTALL_PREFIX}/cmake_modules/)

install(DIRECTORY ${CMAKE_SOURCE_DIR}/cmake_macros/
	DESTINATION ${CMAKE_INSTALL_PREFIX}/cmake_modules/)

message(STATUS "installed tools")
