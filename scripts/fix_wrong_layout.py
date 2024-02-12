import sys


en = (
    r"qwertyuiop[]\asdfghjkl;'zxcvbnm,./QWERTYUIOP{}|ASDFGHJKL:"
    r'"'
    r"ZXCVBNM<>?`~@#$^&"
)
ru = (
    r"йцукенгшщзхъ\фывапролджэячсмитьбю.ЙЦУКЕНГШЩЗХЪ/ФЫВАПРОЛДЖЭЯЧСМИТЬБЮ,ёЁ"
    r'"'
    r"№;:?"
)
trans = str.maketrans(en + ru, ru + en)

s = sys.stdin.buffer.read().decode("utf-8")[:-1]
print(s.translate(trans), end="")
