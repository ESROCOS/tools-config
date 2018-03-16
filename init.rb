# Write in this file customization code that will get executed before 
# autoproj is loaded.

# Set the path to 'make'
# Autobuild.commands['make'] = '/path/to/ccmake'

# Set the parallel build level (defaults to the number of CPUs)
# Autobuild.parallel_build_level = 10

# Uncomment to initialize the environment variables to default values. This is
# useful to ensure that the build is completely self-contained, but leads to
# miss external dependencies installed in non-standard locations.
#
# set_initial_env
#
# Additionally, you can set up your own custom environment with calls to env_add
# and env_set:
#
# env_add 'PATH', "/path/to/my/tool"
# env_set 'CMAKE_PREFIX_PATH', "/opt/boost;/opt/xerces"
# env_set 'CMAKE_INSTALL_PATH', "/opt/orocos"
#
# NOTE: Variables set like this are exported in the generated 'env.sh' script.
#

require 'autoproj/gitorious'
#Autoproj.gitorious_server_configuration('GITORIOUS', 'gitorious.org')
Autoproj.gitorious_server_configuration('GITHUB', 'github.com', :http_url => 'https://github.com')
#Autoproj.gitorious_server_configuration('GITLAB', 'git.hb.dfki.de', :http_url => 'https://git.hb.dfki.de')

Autoproj.env_inherit 'CMAKE_PREFIX_PATH'

Autoproj.env_set 'PKG_CONFIG_PATH', "$AUTOPROJ_CURRENT_ROOT/install/pkgconfig"

Autoproj.env_set 'CPLUS_INCLUDE_PATH', "$AUTOPROJ_CURRENT_ROOT/install/include"

Autoproj.env_set 'C_INCLUDE_PATH', "$AUTOPROJ_CURRENT_ROOT/install/include"

Autoproj.env_set 'CPATH', "$AUTOPROJ_CURRENT_ROOT/install/include"

# Autoproj changes PYTHONUSERBASE, but we need access to Python packages installed at system level 
# (e.g., packages installed by TASTE at the default location), so we add the default user-site to 
# PYTHONPATH.
default_python3_user_base = `env -i python3 -m site --user-site`.chop
Autoproj.env_set 'PYTHONPATH', default_python3_user_base

Autoproj.env_set 'ESROCOS_TEMPLATES', ENV["AUTOPROJ_CURRENT_ROOT"]+"/autoproj/templates"

Autoproj.env_set 'ESROCOS_CMAKE', ENV["AUTOPROJ_CURRENT_ROOT"]+"/autoproj/esrocos.cmake"

def esrocos_package(name, workspace: Autoproj.workspace)
    package_common(:cmake, name, workspace: workspace) do |pkg|
      pkg.depends_on 'cmake'
      common_make_based_package_setup(pkg)

      yield(pkg) if block_given?
 
      pkg.post_install do
          Autobuild::Subprocess.run(
                              pkg, "install",
                              "esrocos_build_project",
                              :working_directory => pkg.srcdir)
      end
    end    
end
