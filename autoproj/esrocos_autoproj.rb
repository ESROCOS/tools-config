require 'autoproj'

module Esrocos

    # Call for a cmake_package to set the build options needed to build 
    # packages that contain TASTE models
    def Esrocos.set_taste_package(pkg)
        puts "Setting options to build TASTE models for #{pkg.name}"
        # Set build not parallel to avoid conflict with TASTE build
        pkg.parallel_build_level = 1
    end

    # Build a cmake_package with the Gaisler RTEMS toolchain.
    #  - sets the CMake build directory to build_<target>
    #  - passes the options -DCMAKE_TOOLCHAIN_FILE=... and -DRCC_TARGET=... to CMake
    def Esrocos.build_rtems_gailser(pkg, target='leon3')
        puts "Configure #{pkg.name} to build with the Gaisler RTEMS toolchain for #{target}"
        pkg.builddir = "build_#{target}"
        pkg.define("CMAKE_TOOLCHAIN_FILE", File.join(Autoproj.root_dir, 'install', 'cmake_toolchains', 'toolchain-rtems-gaisler.cmake'))
        pkg.define("RCC_TARGET", target)
    end

end
