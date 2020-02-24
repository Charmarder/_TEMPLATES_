#-------------------------------------------------------------------------------
# Faverr.com interview questions
def favver1 ():
    """
    Stack s = [2, 4, 6, 1, 5] (top at the end: 5), 
    Realize functions: pop(), push(), top() getMinimum() all with complexity O(1). 
    Which will be space complexity for each? = O(n)
    """
    s=[4,2,6,1,5]
    min=[4,2,1]

    def push(i):
        if (len(min) == 0 or min[-1] > i):
            min.append(i)
        s.append(i)
    def pop():
        i = s.pop()
        if (len(min) != 0 and i == min[-1]):
            min.pop()
        return i
    def getMinimum():
        if (len(min)): return min[-1]
    def top():
        if len(s): return s[-1]

    push(0)
    print(s); print(min)
    print(getMinimum())
    pop()
    pop()
    print(s); print(min)
    pop()
    pop()
    print(s); print(min)
    print(getMinimum())
    pop()
    print(getMinimum())
    print(top())

# favver1()

def favver2():
    """
    Function find Duplicate(words: array[string], blacklist: array[]) -> duplicates{}. 
    Return counts of duplicate words
    """
    None

def favver3():
    """
    Write function findDuplicate(words: array[string]), using time-cost function (1s) 
    isInBlackList(words: array[string]): bool, which gets data from another service.
    """
    None

from typing import List
from queue import Queue
def favver4():
    """
    Count male and female managers in the organization tree in two ways using recursion and interactive approaches. 
    What are cons and props on each?

    """
    # define organization tree
    tree = {'id': 0, 'children': [
        {'id': 1, 'children': [
            {'id': 4, 'children': []},
            {'id': 5, 'children': []}
        ]},
        {'id': 2, 'children': []},
        {'id': 3, 'children': [
            {'id': 6, 'children': [
                {'id': 7, 'children': []},
                {'id': 8, 'children': []},
                {'id': 9, 'children': []},
            ]}
        ]},
    ]}

    # recursively
    def recursively(root: dict) -> List[int]:
        res = []
        children = root['children']
        if (children):
            res.append(root['id'])
            for child in children: 
                res += recursively(child)
            return res
        else:
            return []

    managers = recursively(tree)
    print('recursively', managers)

    # iteratively       
    def iterativelyMy(root):
        res, stack = [], []
        while stack or root:
            if root:
                stack.append([root, 0])
                root = root['children'][0] if root['children'] else None
            else:
                item = stack[-1]
                item[1] += 1
                if item[1] >= len(item[0]['children']) - 1:
                    item = stack.pop()
                    if item[0]['children']: res.append(item[0]['id'])
                root = item[0]['children'][item[1]] if len(item[0]['children']) > 1 else None
        return res
    managers = iterativelyMy(tree)
    print('iterativelyMy', managers)

    def iterativelyDFS(root):
        res, stack = [], []
        stack.append(root)
        while stack:
            node = stack.pop()
            if node['children']: res.append(node['id'])
            for child in node['children']:
                stack.append(child)
        return res
    managers = iterativelyDFS(tree)
    print('iterativelyDFS (stack)', managers)

    def iterativelyBFS(root):
        res, queue = [], Queue()
        queue.put(root)
        while not queue.empty():
            node = queue.get()
            if node['children']: res.append(node['id'])
            for child in node['children']:
                queue.put(child)
        return res
    managers = iterativelyBFS(tree)
    print('iterativelyBFS (queue)', managers)

# favver4()

#-------------------------------------------------------------------------------
# Google interview question
def get_increasing_list():
    """ Possible values for each position of result sublist
        [1, 2, 3]
        [1, 2, 4]
        [1, 2, 5]
        [1, 3, 4]
        [1, 3, 5]
        [1, 4, 5]
        [2, 3, 4]
        [2, 3, 5]
        [2, 4, 5]
        [3, 4, 5]
        
    https://www.careercup.com/question?id=5710755664494592
    """
    def method1(l, n):
        """Like stack approach"""

        print('-' * 80)
        q = list(range(n))
        print('q', q)
        print(l[:n], '---')

        visited = []
        while len(q) != 0:
            num = q.pop()
#            print('q.pop', num)
            if n-len(q) == len(l)-num:
                continue

            for i in range(num + 1, len(l)):
                if len(q) == n:
                    break
                q.append(i)
#                print('q', q)
                if len(q) == n: # and q[:n] not in visited:
                    print (list(map(lambda x: l[x], q)), '---')
                    visited.append(q[:n])

        print(len(visited))

    method1([1,2,3,4,5,6], 3)

    def method2(l=[1,2,3,4,5,6], n = 3):
        """
        """
        print('-' * 80)

        # possible values for each items in result sublist
        p = []
        for i in range(n):
            end = -n+1+i if -n+1+i < 0 else None    # this is ternary operator (one-line version of the if-else)
            p.append(l[i:end])
        print(p)

        q = [0 for i in p]
        last = [len(p[0]) for i in p]
        x = 0
        while q < last:
            print([p[i][j] for i, j in enumerate(q)])

            for i in range(x+1, len(p[0])):
                q[n-1] += 1
                print([p[i][j] for i, j in enumerate(q)])

            # find index of element for increment
            for y in reversed(range(0, n)):
                if q[y]+1 < len(p[0]): break

            x = q[y]+1  # move pointer

            # create new sublist
            for i in range(y, n): q[i] = x

    method2()

get_increasing_list()


#-------------------------------------------------------------------------------
# Speed test of map with lambda and for statements
def speed_test_map_and_for():
    """list comprehension is about 1.39 x faster than map in this test case"""

    def with_map():
        ranked_users = range(10 ** 6)
        list(map(lambda x: {'name': x[1], 'rank': x[0]}, enumerate(ranked_users)))

    def by_comprehension():
        ranked_users = range(10 ** 6)
        [{'name': x, 'rank': i} for i, x in enumerate(ranked_users)]

    from timeit import timeit
    time_with_map = timeit(with_map, number=10)
    time_with_comprehension = timeit(by_comprehension, number=10)

    print('list comprehension is about %.2f x faster than map in this test case' % (time_with_map/time_with_comprehension))
