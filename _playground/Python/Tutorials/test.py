class A:  
    def __init__(self):  
        self.name = 'John'  
        self.age = 23  
  
    def getName(self):  
        return self.name  
  
class B:  
    def __init__(self):  
        self.name = 'Richard'  
        self.id = '32'  
  
    def getName(self):  
        return self.name  
  
  
class C(A, B):  
    def __init__(self):  
        A.__init__(self)
        B.__init__(self)  
  
    def getName(self):  
        return (self.age, self.id, self.name)
  
C1 = C()  
print(dir(A))
print(dir(C1))
print(C1.getName())


a = 2
b = 3
c = 2

if a == c and b != a or b == c:
   print("if block: executed")
   c = 3

if c == 2:
   print("if block: not executed")
