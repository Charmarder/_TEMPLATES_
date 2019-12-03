def f1():
    print('1:', 2**38)

def f2():
    s =("g fmnc wms bgblr rpylqjyrc gr zw fylb. rfyrq ufyr amknsrcpq ypc dmp. bmgle gr gl zw fylb gq glcddgagclr ylb rfyr'q "
        "ufw rfgq rcvr gq qm jmle. sqgle qrpgle.kyicrpylq() gq pcamkkclbcb. lmu ynnjw ml rfc spj.")

    r = [];
    for c in s:
        if c != ' ':
            r.append(chr(ord(c)+2))
        else:
            r.append(c)

    print('2:', ''.join(r))

#f1()
#f2()

