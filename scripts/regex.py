from re import compile as re_compile
from os import path

data_path = path.join(path.dirname(__file__), 'data', 'howto')

variants = [re_compile(x) for x in(
    '([a-zA-Z][a-zA-Z0-9]*)://([^ /]+)(/[^ ]*)?',
    '([^ @]+)@([^ @]+)',
    '([0-9][0-9]?)/([0-9][0-9]?)/([0-9][0-9]([0-9][0-9])?)',
    '([a-zA-Z][a-zA-Z0-9]*)://([^ /]+)(/[^ ]*)?|([^ @]+)@([^ @]+)',
)]

with open(data_path) as fp:
    data = fp.read()

output = [None] * len(variants)

for i, rex in enumerate(variants):
    output[i] = len(rex.findall(data))

if output != [17817, 15427, 673, 33241]:
    exit(-1)
