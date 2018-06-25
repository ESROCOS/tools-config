# H2020 ESROCOS Project
# Company: GMV Aerospace & Defence S.A.U.
# Licence: GPLv2

# CMake toolchain file for the rcc (RTEMS GCC) toolchain from Gaisler
# In order to select the compiler options, define the variable RTEMS_TARGET
# by passing the option "-DRTEMS_TARGET=<target>" to cmake, where 
# <target> is one of the valid options for "-qbsp=<target>" defined in 
# the RCC manual. Alternatively, set target to "OTHER" to manage the 
# compiler flags manually.


# Set the following definitions according to the local installation

# Base directory of the rcc install
#set(RTEMS_BASE "/opt/rcc-1.3-rc4")
set(RTEMS_BASE "/opt/rtems-5.1-2018.03.08")

# Tool name prefix
#set(RTEMS_PREFIX "sparc-gaisler-rtems5-")
set(RTEMS_PREFIX "sparc-rtems5-")

# Use -qbsp flag (it's available in rcc-1.3, but not in rtems-5.1)
#set(USE_BSP_FLAGS TRUE)
set(USE_BSP_FLAGS FALSE)


# Use CMake for Generic system
set(CMAKE_SYSTEM_NAME Generic)

# Compiler paths
set(CMAKE_C_COMPILER "${RTEMS_BASE}/bin/${RTEMS_PREFIX}gcc")
set(CMAKE_CXX_COMPILER "${RTEMS_BASE}/bin/${RTEMS_PREFIX}g++")

# Compile flags for RTEMS
# -qrtems: 
# -ffunction-sections -fdata-sections: place functions and data items in individual sections, to allow for optimizations
# -Wl,--gc-sections: remove unused code
set(RTEMS_FLAGS "-qrtems -ffunction-sections -fdata-sections -Wl,--gc-sections")

# Detect if this is the toplevel invocation of CMake, where the options 
# -DCMAKE_TOOLCHAIN_FILE=... -DRTEMS_TARGET=... should be specified
if(CMAKE_TOOLCHAIN_FILE)

    # Check if option RTEMS_TARGET defined
    if(NOT RTEMS_TARGET)
        message(WARNING "RTEMS Gaisler toolchain - option RTEMS_TARGET is not defined - using default options for LEON3")
        set(RTEMS_TARGET "leon3")
    endif()

    # Compiler flags for the different BSPs supported by the toolchain 
    string(TOLOWER ${RTEMS_TARGET} RTEMS_TARGET_LOWER)
    if(RTEMS_TARGET_LOWER STREQUAL "leon2")
        message(STATUS "RTEMS Gaisler toolchain - selected target LEON2 generic")
        set(CPU_FLAGS "-mcpu=leon")
        set(BSP_FLAGS "-qbsp=leon2")
        set(SPEC_FLAGS "")
    elseif(RTEMS_TARGET_LOWER STREQUAL "at697f")
        message(STATUS "RTEMS Gaisler toolchain - selected target AT697F")
        set(CPU_FLAGS "-mcpu=leon -mfix-at697f")
        set(BSP_FLAGS "-qbsp=at697f")
        set(SPEC_FLAGS "")
    elseif(RTEMS_TARGET_LOWER STREQUAL "erc32")
        message(STATUS "RTEMS Gaisler toolchain - selected target ERC32")
        set(CPU_FLAGS "-mcpu=v7")
        set(BSP_FLAGS "-qbsp=erc32")
        set(SPEC_FLAGS "")
    elseif(RTEMS_TARGET_LOWER STREQUAL "leon3")
        message(STATUS "RTEMS Gaisler toolchain - selected LEON3/4 generic default")
        set(CPU_FLAGS "-mcpu=leon3")
        set(BSP_FLAGS "-qbsp=leon3")
        set(SPEC_FLAGS "-B${RTEMS_BASE}/sparc-rtems5/leon3/lib -specs bsp_specs")
    elseif(RTEMS_TARGET_LOWER STREQUAL "leon3std")
        message(STATUS "RTEMS Gaisler toolchain - selected LEON3/4 generic")
        set(CPU_FLAGS "-mcpu=leon3")
        set(BSP_FLAGS "-qbsp=leon3std")
        set(SPEC_FLAGS "-B${RTEMS_BASE}/sparc-rtems5/leon3/lib -specs bsp_specs")
    elseif(RTEMS_TARGET_LOWER STREQUAL "leon3_sf")
        message(STATUS "RTEMS Gaisler toolchain - selected LEON3/4 with soft float")
        set(CPU_FLAGS "-mcpu=leon3 -msoft_float")
        set(BSP_FLAGS "-qbsp=leon3_sf")
        set(SPEC_FLAGS "-B${RTEMS_BASE}/sparc-rtems5/leon3/lib -specs bsp_specs")
    elseif(RTEMS_TARGET_LOWER STREQUAL "leon3_smp")
        message(STATUS "RTEMS Gaisler toolchain - selected LEON3/4 with RTEMS SMP")
        set(CPU_FLAGS "-mcpu=leon3")
        set(BSP_FLAGS "-qbsp=leon3_smp")
        set(SPEC_FLAGS "-B${RTEMS_BASE}/sparc-rtems5/leon3/lib -specs bsp_specs")
    elseif(RTEMS_TARGET_LOWER STREQUAL "leon3_mp")
        message(STATUS "RTEMS Gaisler toolchain - selected LEON3/4 with RTEMS multiprocessor executable (AMP)")
        set(CPU_FLAGS "-mcpu=leon3")
        set(BSP_FLAGS "-qbsp=leon3_mp")
        set(SPEC_FLAGS "-B${RTEMS_BASE}/sparc-rtems5/leon3/lib -specs bsp_specs")
    elseif(RTEMS_TARGET_LOWER STREQUAL "gr712rc")
        message(STATUS "RTEMS Gaisler toolchain - selected GR712RC LEON3/4")
        set(CPU_FLAGS "-mcpu=leon3 -mfix-gr712rc")
        set(BSP_FLAGS "-qbsp=gr712rc")
        set(SPEC_FLAGS "-B${RTEMS_BASE}/sparc-rtems5/gr712rc/lib -specs bsp_specs")
    elseif(RTEMS_TARGET_LOWER STREQUAL "gr712rc_smp")
        message(STATUS "RTEMS Gaisler toolchain - selected GR712RC LEON3/4 with RTEMS SMP")
        set(CPU_FLAGS "-mcpu=leon3 -mfix-gr712rc")
        set(BSP_FLAGS "-qbsp=gr712rc_smp")
        set(SPEC_FLAGS "-B${RTEMS_BASE}/sparc-rtems5/gr712rc/lib -specs bsp_specs")
    elseif(RTEMS_TARGET_LOWER STREQUAL "gr740")
        message(STATUS "RTEMS Gaisler toolchain - selected GR740 LEON3/4")
        set(CPU_FLAGS "-mcpu=leon3")
        set(BSP_FLAGS "-qbsp=gr740")
        set(SPEC_FLAGS "-B${RTEMS_BASE}/sparc-rtems5/gr740/lib -specs bsp_specs")
    elseif(RTEMS_TARGET_LOWER STREQUAL "gr740_smp")
        message(STATUS "RTEMS Gaisler toolchain - selected GR740 LEON3/4 with RTEMS SMP")
        set(CPU_FLAGS "-mcpu=leon3")
        set(BSP_FLAGS "-qbsp=gr740_smp")
        set(SPEC_FLAGS "-B${RTEMS_BASE}/sparc-rtems5/gr740/lib -specs bsp_specs")
    elseif(RTEMS_TARGET_LOWER STREQUAL "ut699")
        message(STATUS "RTEMS Gaisler toolchain - selected UT699")
        set(CPU_FLAGS "-mcpu=leon -mfix-ut699")
        set(BSP_FLAGS "-qbsp=ut699")
        set(SPEC_FLAGS "")
    elseif(RTEMS_TARGET_LOWER STREQUAL "ut700")
        message(STATUS "RTEMS Gaisler toolchain - selected UT700/UT699E")
        set(CPU_FLAGS "-mcpu=leon3 -mfix-ut700")
        set(BSP_FLAGS "-qbsp=ut700")
        set(SPEC_FLAGS "")
    elseif(RTEMS_TARGET STREQUAL "custom")
        message(STATUS "RTEMS Gaisler toolchain - selected CUSTOM BSP")
        message(STATUS "Compiler options for CPU must be set separately")
        set(CPU_FLAGS "")
        set(BSP_FLAGS "-qbsp=CUSTOM")
        set(SPEC_FLAGS "")
    elseif(RTEMS_TARGET STREQUAL "other")
        message(STATUS "RTEMS Gaisler toolchain - selected target OTHER")
        message(STATUS "Compiler options for CPU and BSP must be set separately")
    else()
        message(WARNING "RTEMS Gaisler toolchain - no target defined (no CPU or BSP options set)")
    endif()
endif()

# Append -qbsp option if needed
set(CMAKE_C_FLAGS "${RTEMS_FLAGS} ${SPEC_FLAGS} ${CPU_FLAGS}")
if(USE_BSP_FLAGS)
	set(CMAKE_C_FLAGS "${BSP_FLAGS} ${CMAKE_C_FLAGS}")
endif()

# Apply same options to C++
set(CMAKE_CXX_FLAGS ${CMAKE_C_FLAGS})

# Options and rules for CMake to find resources
set(CMAKE_FIND_ROOT_PATH ${RTEMS_BASE})
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

