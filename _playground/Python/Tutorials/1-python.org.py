#-------------------------------------------------------------------------------
# 3. An Informal Introduction to Python
def f3():
    """ 
    - 15 // -4 = -4 It is some bug when you devide on negative value it round to top
    Strings:
    - Multi-line string 
    - Two or more string literals (i.e. 'Py' 'thon' = 'Python') next to each other are automatically concatenated.
    - Negative indeces start counting from the right (word[-1])
    - Slice (word[:2] or word[-1:0:-1])  indices as pointing between characters, work for any built-in sequence types 
    - String are immutable. 
    Lists ([]):
    - Lists might contain items of different types, but usually the items all have the same type.
    - Slicing and concatination (+) work
    """
    pass # The pass statement does nothing.


#-------------------------------------------------------------------------------
# 4. More Control Flow Tools
def f4():
    """     
    - for ... else
    - Built-in function range(start, stop[, step]) - generates arithmetic progressions
    - Built-in function enumerate(iterable, start=0) - return an enumerate object
    - 4.7.3. Special parameters: def f(pos1, pos2, /, pos_or_kwd, *, kwd1, kwd2)
    """

    def f4_4(): # break and continue Statements, and else Clauses on Loops
        """Searches for prime numbers"""
        print("\n" + f4_4.__doc__ + "\n" + '-'*80)

        for n in range(2, 10):
            for x in range(2, n):
                if n % x == 0:
                    print(n, 'equals', x, '*', n//x)
                    break
            else:
                # loop fell through without finding a factor
                print(n, 'is a prime number')
    f4_4()

    def f4_6(n):
        """Print a Fibonacci series up to n."""
        print("\n" + f4_6.__doc__ + "\n" + '-'*80)

        a, b = 0, 1
        while a < n:
            print(a, end=' ')
            a, b = b, a+b
        print()
    f4_6(2000)

    # 4.7. More on Defining Functions
    def f4_7_2(kind, *arguments, **keywords):
        """The *arguments and **keywords is a common idiom to allow arbitrary number of arguments"""
        print("\n" + f4_7_2.__doc__ + "\n" + '-'*80)

        # The *arguments will give you all function parameters as a tuple
        # The **keywords will give you all keyword arguments as a dictionary.
        print("-- Do you have any", kind, "?")
        print("-- I'm sorry, we're all out of", kind)
        for arg in arguments:
            print(arg)
        print("-" * 40)
        for kw in keywords:
            print(kw, ":", keywords[kw])

    # 4.7.4. Unpacking Argument Lists
    args = ["It's very runny, sir.", "It's really very, VERY runny, sir."]
    d = {"shopkeeper": "Michael Palin", "client": "John Cleese", "sketch": "Cheese Shop Sketch"}
    f4_7_2("Limburger", *args, **d)

    def f4_7_7(ham: str, eggs: str = 'eggs') -> str:
        """Function annotations"""
        print("\n" + f4_7_7.__doc__ + "\n" + '-'*80)

        print("Annotations:", f4_7_7.__annotations__)
        print("Arguments:", ham, eggs)
        return ham + ' and ' + eggs
    f4_7_7('spam')


# f4()

#-------------------------------------------------------------------------------
# 5. Data Structures
def f5():
    """
    - 5.1.2. Using Lists as Queues: from collections import deque
    - 5.1.4. Nested List Comprehensions: [[row[i] for row in matrix] for i in range(4)]
    - 5.2. The del statement: remove item from list and entire variable
    Sequence Types:
    - List []
    - Tuple ()
    - Set {}
    - Dictionary {key: value}
    5.7.
    - Comparisons can be chained (a < b == c)
    - Sequence objects typically may be compared to other objects with the same sequence type
    - Short-circuit operators (a or b or c): when used as a general value and not as a Boolean, 
      return value is the last evaluated argument.
    """

    def f5_1():
        """List examples"""
        print("\n" + f5_1.__doc__ + "\n" + '-'*80)

        fruits = ['orange', 'apple', 'pear', 'banana', 'kiwi', 'apple', 'banana']
        print(fruits.count('apple'))

        print(fruits.count('tangerine'))

        print(fruits.index('banana'))

        print(fruits.index('banana', 4))  # Find next banana starting a position 4

        fruits.reverse()
        print(fruits)

        fruits.append('grape')
        print(fruits)

        fruits.sort()
        print(fruits)

        print(fruits.pop())

    def f5_1_sort():
        """Using Decorate-Sort-Undecorate approch

        5.1 -> sorted -> Sorting HOW TO"""
        print("\n" + f5_1_sort.__doc__ + "\n" + '-'*80)

        class Student:
            def __init__(self, name, grade, age):
                self.name = name
                self.grade = grade
                self.age = age
            def __repr__(self):
                return repr((self.name, self.grade, self.age))

        student_objects = [
            Student('jane', 'B', 12),
            Student('john', 'A', 15),
            Student('dave', 'B', 10),
        ]

        # Using Decorate-Sort-Undecorate approch
        print(student_objects)
        decorated = [(student.grade, i, student) for i, student in enumerate(student_objects)]
        print(decorated)
        decorated.sort()
        print(decorated)
        print([student for grade, i, student in decorated])               # undecorate

    f5_1_sort()

    def f5_7():
        """5.7. More on Conditions

        When used as a general value and not as a Boolean, the return value of a 
        short-circuit operator is the last evaluated argument.
        """

        string1, string2, string3 = '', 'Trondheim', 'Hammer Dance'
        non_null = string1 or string2 or string3    # non_null = 'Trondheim'
        print(non_null)

    f5_7()

#f5()

#-------------------------------------------------------------------------------
# 6. Modules
def f6():
    """
    Module:
    - __name__ - module name
    - module.version.pyc - “Compiled” Python files
    - -O switch: remote assert statements, -OO: removes both assert statements and __doc__ strings
    Packege:
    - Way of structuring Python’s module namespace by using “dotted module names”: import sound.effects.echo
    - The __init__.py files are required to make Python treat directories containing the file as packages. 
      This prevents directories with a common name, such as string, unintentionally hiding valid modules that occur later on the module search path.
      __all__
    """
    # print(__name__) # module name


    def f6_1():    
        """6.1. More on Modules

        import fibo as fib
        from fibo import fib as fibonacci
        from fibo import *: BAD practice
        """
    f6_1()

    def f6_1_1():
        """6.1.1. Executing modules as scripts

        python fibo.py <arguments>
        """
        if __name__ == "__main__":
            import sys
            print(int(sys.argv[1]))
    f6_1_1()

    def f6_1_2():
     """6.1.2. The Module Search Path

     sys.path is initialized from these locations:
    - The directory containing the input script (or the current directory when no file is specified).
    - PYTHONPATH (a list of directory names, with the same syntax as the shell variable PATH).
    - The installation-dependent default.
    """
    f6_1_2()

    def f6_3():
        """6.3. The dir() Function"""

        import sys
        dir(sys)
    f6_3()


#-------------------------------------------------------------------------------
# 7. Input and Output
def f7():

    def f7_1():
        """7.1. Fancier Output Formatting"""

        # 1. Formatted string literals (f-string)
        a, b = 25, 4
        print(f'a divided by b is {a / b:.2f}')

        table = {'Sjoerd': 4127, 'Jack': 4098, 'Dcab': 7678}
        for name, phone in table.items():
            print(f'{name:10} ==> {phone:10d}')
        # '!a' applies ascii(), '!s' applies str(), and '!r' applies repr()
        animals = 'eels'
        print(f'My hovercraft is full of {animals!r}.')

        # 2. The str.format() method of strings
        yes_votes = 42_572_654
        no_votes = 43_132_495
        percentage = yes_votes / (yes_votes + no_votes)
        print('{:-9} YES votes  {:2.2%}'.format(yes_votes, percentage))
        print('The story of {1}, {0}, and {other}.'.format('Manfred', 'Bill', other='Georg'))
        table = {'Sjoerd': 4127, 'Jack': 4098, 'Dcab': 8637678}
        print('Jack: {0[Jack]:d}; Sjoerd: {0[Sjoerd]:d}; Dcab: {0[Dcab]:d}'.format(table))
        print('Jack: {Jack:d}; Sjoerd: {Sjoerd:d}; Dcab: {Dcab:d}'.format(**table))

        # 3. Template class of string module
        from string import Template
        s = Template('$who likes $what')
        print(s.substitute(who='Tim', what='kung pao'))

        # 4. Manual fomating: using string slicing and concatenation operations
        for x in range(1, 11):
            print(repr(x).rjust(2), repr(x*x).rjust(3), end=' ')
            # Note use of 'end' on previous line
            print(repr(x*x*x).rjust(4))

        # 5. Old string formatting (is not recommended to use as it decrease the code readability)
        import math
        print('The value of pi is approximately %5.3f.' % math.pi)

    f7_1()

    def f7_2():
        """7.2. Reading and Writing Files"""

        f = open('workfile', 'w')
        f.write('This is the first line of the file.\n')
        f.write('Second line of the file\n')
        f.write('This is last line.\n')
        f.closed

        f = open('workfile')
        entire_file = f.read()
        print(entire_file)
        f.closed

        # Using with is much shorter than writing equivalent try-finally blocks
        with open('workfile') as f:
            for line in f:
                print(line, end='')

        # read all the lines of a file in a list
        f = open('workfile')
        print(list(f))
        print(f.tell())
        f.seek(0)
        print(f.readlines())
        f.closed

        # Saving structured data with json
        import json
        f = open('workfile', 'w')
        x = [1, 'simple', 'list']
        json.dump(x, f)

        f = open('workfile', 'r')
        print(json.load(f))

    f7_2()

#f7()

#-------------------------------------------------------------------------------
# 8. Errors and Exceptions
def f8():
    """ """
    try:
        raise Exception('spam', 'eggs')
    except Exception as inst:
        print(type(inst))    # the exception instance
        print(inst.args)     # arguments stored in .args
        print(inst)          # __str__ allows args to be printed directly,
                             # but may be overridden in exception subclasses
        x, y = inst.args     # unpack args
        print('x =', x)
        print('y =', y)
    finally:
        print('Goodbye, world!')

#f8()


#-------------------------------------------------------------------------------
# 9. Classes
def f9():

    print(' 9. Classes '.center(80, '-'))
    class First:
        """Classes

        - Class (shared) and Instance Variables
        - Classes has no access modifiers (public, privat, protected...)
        - Nothing in Python makes it possible to enforce data hiding
        - Data attributes override method attributes with the same name
        - Data attributes can be added by users (dynamic attributes creation)
        Naming convention (for last two) can save a lot of headaches here.
        - First argument of methon (self) if just convention
        - object.__class__ is class of object (also called its type)
        - Multiple Inheritance: depth-first, left-to-right
        - In a class hierarchy with single inheritance, super() can be used to refer to parent classes without naming them explicitly
        - “Private” instance variables don’t exist in Python.
        - Naming mangling rules (__identifier -> _classname__identifier) are designed mostly to avoid accidents
        - Empty class like Pascal “record” or C “struct” and abstract data type
        """
        kind = 'canine'

        def __init__(self, name):
            self.name = name
            self.kind = name

        def f(self):
            print('Hello', self.name, 'World!')

    a = First('A')
    b = First('B')
    b.kind = 'C'
    print(b.kind)
    print(a.kind)
    print(First.kind)
    b.f()

    print(' 9.5. Inheritance '.center(80, '-'))
    class DerivedClass(First):
        def f(self):
            First.f(self)
            print('Extend method f() by', self.__class__)

    c = DerivedClass('C')
    c.f()

    # Two built-in functions that work with inheritance:
    print('isinstance(c, DerivedClass):', isinstance(c, DerivedClass))
    print('issubclass(DerivedClass, First):', issubclass(DerivedClass, First))

    # 9.5.1. Multiple Inheritance: depth-first, left-to-right
    class Second():
        pass
    
    class MultiDerivedClass(First, Second):
        pass

    mdc = MultiDerivedClass('Mak')
    print(mdc.name)
    
    print(' 9.8. Iterators '.center(80, '-'))
    class Reverse:
        """Iterator for looping over a sequence backwards."""
        def __init__(self, data):
            self.data = data
            self.index = len(data)

        def __iter__(self):
            return self

        def __next__(self):
            if self.index == 0:
                raise StopIteration
            self.index = self.index - 1
            return self.data[self.index]

    rev = Reverse('spam')
    for char in rev:
        print(char)

    print(' 9.9. Generators '.center(80, '-'))
    def reverse(data):
        for index in range(len(data)-1, -1, -1):
            yield data[index]

    for char in reverse('golf'):
        print(char)

f9()

#-------------------------------------------------------------------------------
# 10. Brief Tour of the Standard Library
def f10():
    """
    10.1. Operating System Interface: import os; import shutil
    10.2. File Wildcards: import glob - function for making file lists from directory wildcard searches
    10.3. Command Line Arguments: import sys; import argparse
    10.4. Error Output Redirection and Program Termination: 
        The sys module also has attributes for stdin, stdout, and stderr.
        sys.exit()
    10.5. String Pattern Matching: import re - regular expression tools
    10.6. Mathematics: import math; import random; import statistics - SciPy project <https://scipy.org>
    10.7. Internet Access: from urllib.request import urlopen; import smtplib
    10.8. Dates and Times: from datetime import date
    10.9. Data Compression: zlib, gzip, bz2, lzma, zipfile and tarfile modules
    10.10. Performance Measurement: from timeit import Timer;
        profile and pstats modules provide tools for identifying time critical sections in larger blocks of code
    10.11. Quality Control: import doctest - validate the embedded tests
        import unittest - it allows a more comprehensive set of tests to be maintained in a separate file
    10.12. Batteries Included:
        The xmlrpc.client and xmlrpc.server modules make implementing remote procedure calls
        The email package is a library for managing email messages
        The json package provides robust support for parsing this popular data interchange format
        The csv module supports direct reading and writing of files in Comma-Separated Value format
        XML processing is supported by the xml.etree.ElementTree, xml.dom and xml.sax packages
        The sqlite3 module is a wrapper for the SQLite database library
        Internationalization is supported by a number of modules including gettext, locale, and the codecs
    """

#-------------------------------------------------------------------------------
# 11. Brief Tour of the Standard Library — Part II
def f11():
    """
    11.1. Output Formatting: import reprlib; import pprint; import textwrap; import locale
    11.2. Templating: from string import Template
    11.3. Working with Binary Data Record Layouts: import struct - pack() and unpack()
    11.4. Multi-threading: import threading, zipfile
    11.5. Logging: import logging
    11.6. Weak References: import weakref, gc
    11.7. Tools for Working with Lists: 
        from array import array; 
        from collections import deque; 
        import bisect
        from heapq import heapify, heappop, heappush
    11.8. Decimal Floating Point Arithmetic: from decimal import *
    """
