cmake_minimum_required(VERSION 2.6)

project(esrocos_config)

install(DIRECTORY ${CMAKE_SOURCE_DIR}/templates/
	DESTINATION ${CMAKE_INSTALL_PREFIX}/templates/)

install(DIRECTORY ${CMAKE_SOURCE_DIR}/cmake_modules/
	DESTINATION ${CMAKE_INSTALL_PREFIX}/cmake_modules/)

install(DIRECTORY ${CMAKE_SOURCE_DIR}/cmake_macros/
	DESTINATION ${CMAKE_INSTALL_PREFIX}/cmake_macros/)

install(DIRECTORY ${CMAKE_SOURCE_DIR}/cmake_toolchains/
	DESTINATION ${CMAKE_INSTALL_PREFIX}/cmake_toolchains/)

install(DIRECTORY ${CMAKE_SOURCE_DIR}/autoproj/
	DESTINATION ${CMAKE_INSTALL_PREFIX}/autoproj/)

message(STATUS "installed tools")
