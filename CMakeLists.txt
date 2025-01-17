cmake_minimum_required(VERSION 3.10)

project(PowerShellLearning)

SET(EXECUTABLE_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/build/bin)

add_custom_target(
    RunPowerShellScript ALL
    COMMAND ${CMAKE_COMMAND} -E echo "Running PowerShell script..."
    COMMAND powershell -ExecutionPolicy Bypass -File ${CMAKE_SOURCE_DIR}/src/14生成仓库代码信息.ps1
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/src
    COMMENT "Executing PowerShell script to generate repository code information"
)