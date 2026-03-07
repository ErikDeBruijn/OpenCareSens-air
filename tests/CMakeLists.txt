# Struct size verification test
add_executable(test_struct_sizes test_struct_sizes.c)
target_link_libraries(test_struct_sizes caresens_air)
add_test(NAME struct_sizes COMMAND test_struct_sizes)

# Math utilities test
add_executable(test_math_utils test_math_utils.c)
target_link_libraries(test_math_utils caresens_air m)
add_test(NAME math_utils COMMAND test_math_utils)

# Signal processing test
add_executable(test_signal_processing test_signal_processing.c)
target_link_libraries(test_signal_processing caresens_air m)
add_test(NAME signal_processing COMMAND test_signal_processing)

# Error detection (check_error) test
add_executable(test_check_error test_check_error.c)
target_link_libraries(test_check_error caresens_air m)
add_test(NAME check_error COMMAND test_check_error)
