# Struct size verification test
add_executable(test_struct_sizes test_struct_sizes.c)
target_link_libraries(test_struct_sizes caresens_air)
add_test(NAME struct_sizes COMMAND test_struct_sizes)

# Math utilities test
add_executable(test_math_utils test_math_utils.c)
target_link_libraries(test_math_utils caresens_air m)
add_test(NAME math_utils COMMAND test_math_utils)
