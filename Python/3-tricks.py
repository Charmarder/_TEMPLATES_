#-------------------------------------------------------------------------------
# Reversing a String in Python
x = "MindmajixTraining"
print( "Reverse is" , x[: : -1])

#-------------------------------------------------------------------------------
# Check the memory usage of  an object
import sys
x = 10
print(sys.getsizeof(x))

#-------------------------------------------------------------------------------
# Find the most frequent value in a list
test = [1, 2, 3, 9, 2, 7, 3, 5, 9, 9, 9]
print(max(set(test), key = test.count))

#-------------------------------------------------------------------------------
from collections import Counter
def is_anagram(str1, str2): return Counter(str1) == Counter(str2)
print(is_anagram('majix', 'magic'))
print(is_anagram('majix', 'xijam'))

#-------------------------------------------------------------------------------
# Print the file path of imported modules
import os;
import socket;
print(os)
print(socket)