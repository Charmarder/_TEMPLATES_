#-------------------------------------------------------------------------------
# 4. More Control Flow Tools
def f4():

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


f4()

#-------------------------------------------------------------------------------
# 5. Data Structures
def f5():

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

#f5()

#-------------------------------------------------------------------------------
# 6. Modules
def f6():
    print(__name__) # modul name

    def f6_1():
        """6.1. More on Modules

        import fibo as fib
        from fibo import fib as fibonacci
        """

    def f6_1_1():
        """6.1.1. Executing modules as scripts

        python fibo.py <arguments>
        """
        if __name__ == "__main__":
            import sys
            print(int(sys.argv[1]))

    def f6_1_2():
     """6.1.2. The Module Search Path

     sys.path is initialized from these locations:
    - The directory containing the input script (or the current directory when no file is specified).
    - PYTHONPATH (a list of directory names, with the same syntax as the shell variable PATH).
    - The installation-dependent default.
    """

    def f6_3():
        """6.3. The dir() Function"""

        import sys
        dir(sys)

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

#    f7_1()

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

    a = First('A');
    b = First('B');
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

#f9()

