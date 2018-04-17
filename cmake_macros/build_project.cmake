execute_process(
  COMMAND esrocos_build_project
  WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
  OUTPUT_VARIABLE build_out
  ERROR_VARIABLE build_err
)
