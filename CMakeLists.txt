cmake_minimum_required(VERSION 2.6)
set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/modules")
include(${CMAKE_CURRENT_SOURCE_DIR}/modules/esrocos.cmake)

configure_file(modules/esrocos-config.cmake.in esrocos-config.cmake @ONLY)
install(FILES
	modules/FindCUnit.cmake
	modules/FindGcov.cmake
	modules/FindLcov.cmake
	modules/Findcodecov.cmake
	modules/esrocos.cmake
	${CMAKE_CURRENT_BINARY_DIR}/esrocos-config.cmake
	DESTINATION share/esrocos/cmake)

install(DIRECTORY ${CMAKE_SOURCE_DIR}/templates/
	DESTINATION ${CMAKE_INSTALL_PREFIX}/templates/)

