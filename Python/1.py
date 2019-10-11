def get_increasing_list(l, n):
    q = list(range(n))
    print(l[:n])
    visited = []
    while len(q) != 0:
        num = q.pop()
        for i in range(num + 1, len(l)):
            q.append(i)
            if len(q) >= n and q[:n] not in visited:
                print (list(map(lambda x: l[x], q)))
                visited.append(q[:n])

#    print(visited)

get_increasing_list([1,2,3,4,5], 3)
