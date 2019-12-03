#-------------------------------------------------------------------------------
# https://www.careercup.com/question?id=5710755664494592

def get_increasing_list():
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

    def method2(l=[1,2,3,4,5], n = 3):
        """Posible values for each position of result sublist

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
        """
        print('-' * 80)

        # posible values for each items in result sublist
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

            # find index of element for incriment
            for y in reversed(range(0, n)):
                if q[y]+1 < len(p[0]): break

            x = q[y]+1  # move pointer

            # create new sublist
            for i in range(y, n): q[i] = x

    method2()

get_increasing_list()


#-------------------------------------------------------------------------------
# Speed test of map with lambda and for statments
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


