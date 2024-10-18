import ctypes

# Load the shared object file
my_module = ctypes.CDLL('./bomb.cpython-311-x86_64-linux-gnu.so')

# Define the return type and argument types for main if needed
my_module.main.restype = ctypes.c_int  # If main returns an int

# Call the main function
result = my_module.main()