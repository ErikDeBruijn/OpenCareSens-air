cmake_minimum_required(VERSION 3.10)
project(OpenCareSensAir C)

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)

# ARM cross-compilation option (for Android NDK)
option(CROSS_COMPILE_ARM "Cross compile for ARM" OFF)
if(CROSS_COMPILE_ARM)
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -mfloat-abi=softfp -mfpu=vfpv3-d16")
endif()

# Static library
add_library(caresens_air STATIC
    src/calibration.c
    src/math_utils.c
)
target_include_directories(caresens_air PUBLIC src)

# Tests
enable_testing()
add_subdirectory(tests)
