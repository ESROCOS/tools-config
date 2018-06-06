# H2020 ESROCOS Project
# Company: GMV Aerospace & Defence S.A.U.
# Licence: GPLv2

# CMake toolchain file for the rcc (RTEMS GCC) toolchain from Gaisler
# In order to select the compiler options, define the variable RCC_TARGET
# by passing the option "-DRCC_TARGET=<target>" to cmake, where 
# <target> is one of the valid options for "-qbsp=<target>" defined in 
# the RCC manual. Alternatively, set target to "OTHER" to manage the 
# compiler flags manually.


# Set the following definitions according to the local installation
# Base directory of the rcc install
set(RCC_BASE "/opt/rcc-1.3-rc4")
# Tool name prefix
set(RCC_PREFIX "sparc-gaisler-rtems5-")


# Use CMake for Generic system
set(CMAKE_SYSTEM_NAME Generic)

# Compiler paths
set(CMAKE_C_COMPILER "${RCC_BASE}/bin/${RCC_PREFIX}gcc")
set(CMAKE_CXX_COMPILER "${RCC_BASE}/bin/${RCC_PREFIX}g++")

# Detect if this is the toplevel invocation of CMake, where the options 
# -DCMAKE_TOOLCHAIN_FILE=... -DRCC_TARGET=... should be specified
if(CMAKE_TOOLCHAIN_FILE)

    # Check if option RCC_TARGET defined
    if(NOT RCC_TARGET)
        message(WARNING "RTEMS Gaisler toolchain - option RCC_TARGET is not defined - using default options for LEON3")
        set(RCC_TARGET "leon3")
    endif()

    # Compiler flags for the different BSPs supported by the toolchain 
    string(TOLOWER ${RCC_TARGET} RCC_TARGET_LOWER)
    if(RCC_TARGET_LOWER STREQUAL "leon2")
        message(STATUS "RTEMS Gaisler toolchain - selected target LEON2 generic")
        set(CMAKE_C_FLAGS "-qbsp=leon2 -mcpu=leon")
        set(CMAKE_CXX_FLAGS ${CMAKE_C_FLAGS})
    elseif(RCC_TARGET_LOWER STREQUAL "at697f")
        message(STATUS "RTEMS Gaisler toolchain - selected target AT697F")
        set(CMAKE_C_FLAGS "-qbsp=at697f -mcpu=leon -mfix-at697f")
        set(CMAKE_CXX_FLAGS ${CMAKE_C_FLAGS})
    elseif(RCC_TARGET_LOWER STREQUAL "erc32")
        message(STATUS "RTEMS Gaisler toolchain - selected target ERC32")
        set(CMAKE_C_FLAGS "-qbsp=erc32 -mcpu=v7")
        set(CMAKE_CXX_FLAGS ${CMAKE_C_FLAGS})
    elseif(RCC_TARGET_LOWER STREQUAL "leon3")
        message(STATUS "RTEMS Gaisler toolchain - selected LEON3/4 generic default")
        set(CMAKE_C_FLAGS "-qbsp=leon3 -mcpu=leon3")
        set(CMAKE_CXX_FLAGS ${CMAKE_C_FLAGS})
    elseif(RCC_TARGET_LOWER STREQUAL "leon3std")
        message(STATUS "RTEMS Gaisler toolchain - selected LEON3/4 generic")
        set(CMAKE_C_FLAGS "-qbsp=leon3std -mcpu=leon3")
        set(CMAKE_CXX_FLAGS ${CMAKE_C_FLAGS})
    elseif(RCC_TARGET_LOWER STREQUAL "leon3_sf")
        message(STATUS "RTEMS Gaisler toolchain - selected LEON3/4 with soft float")
        set(CMAKE_C_FLAGS "-qbsp=leon3_sf -mcpu=leon3 -msoft_float")
        set(CMAKE_CXX_FLAGS ${CMAKE_C_FLAGS})
    elseif(RCC_TARGET_LOWER STREQUAL "leon3_smp")
        message(STATUS "RTEMS Gaisler toolchain - selected LEON3/4 with RTEMS SMP")
        set(CMAKE_C_FLAGS "-qbsp=leon3_smp -mcpu=leon3")
        set(CMAKE_CXX_FLAGS ${CMAKE_C_FLAGS})
    elseif(RCC_TARGET_LOWER STREQUAL "leon3_mp")
        message(STATUS "RTEMS Gaisler toolchain - selected LEON3/4 with RTEMS multiprocessor executable (AMP)")
        set(CMAKE_C_FLAGS "-qbsp=leon3_mp -mcpu=leon3")
        set(CMAKE_CXX_FLAGS ${CMAKE_C_FLAGS})
    elseif(RCC_TARGET_LOWER STREQUAL "gr712rc")
        message(STATUS "RTEMS Gaisler toolchain - selected GR712RC LEON3/4")
        set(CMAKE_C_FLAGS "-qbsp=gr712rc -mcpu=leon3 -mfix-gr712rc")
        set(CMAKE_CXX_FLAGS ${CMAKE_C_FLAGS})
    elseif(RCC_TARGET_LOWER STREQUAL "gr712rc_smp")
        message(STATUS "RTEMS Gaisler toolchain - selected GR712RC LEON3/4 with RTEMS SMP")
        set(CMAKE_C_FLAGS "-qbsp=gr712rc_smp -mcpu=leon3 -mfix-gr712rc")
        set(CMAKE_CXX_FLAGS ${CMAKE_C_FLAGS})
    elseif(RCC_TARGET_LOWER STREQUAL "gr740")
        message(STATUS "RTEMS Gaisler toolchain - selected GR740 LEON3/4")
        set(CMAKE_C_FLAGS "-qbsp=gr740 -mcpu=leon3")
        set(CMAKE_CXX_FLAGS ${CMAKE_C_FLAGS})
    elseif(RCC_TARGET_LOWER STREQUAL "gr740_smp")
        message(STATUS "RTEMS Gaisler toolchain - selected GR740 LEON3/4 with RTEMS SMP")
        set(CMAKE_C_FLAGS "-qbsp=gr740_smp -mcpu=leon3")
        set(CMAKE_CXX_FLAGS ${CMAKE_C_FLAGS})
    elseif(RCC_TARGET_LOWER STREQUAL "ut699")
        message(STATUS "RTEMS Gaisler toolchain - selected UT699")
        set(CMAKE_C_FLAGS "-qbsp=ut699 -mcpu=leon -mfix-ut699")
        set(CMAKE_CXX_FLAGS ${CMAKE_C_FLAGS})
    elseif(RCC_TARGET_LOWER STREQUAL "ut700")
        message(STATUS "RTEMS Gaisler toolchain - selected UT700/UT699E")
        set(CMAKE_C_FLAGS "-qbsp=ut700 -mcpu=leon3 -mfix-ut700")
        set(CMAKE_CXX_FLAGS ${CMAKE_C_FLAGS})
    elseif(RCC_TARGET STREQUAL "custom")
        message(STATUS "RTEMS Gaisler toolchain - selected CUSTOM BSP")
        message(STATUS "Compiler options for CPU must be set separately")
        set(CMAKE_C_FLAGS "-qbsp=CUSTOM")
        set(CMAKE_CXX_FLAGS ${CMAKE_C_FLAGS})
    elseif(RCC_TARGET STREQUAL "other")
        message(STATUS "RTEMS Gaisler toolchain - selected target OTHER")
        message(STATUS "Compiler options for CPU and BSP must be set separately")
    else()
        message(WARNING "RTEMS Gaisler toolchain - no target defined (no CPU or BSP options set)")
    endif()
endif()

# Options and rules for CMake to find resources
set(CMAKE_FIND_ROOT_PATH ${RCC_BASE})
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

