path = '/tmp/lorem'
lorem = """
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque suscipit tincidunt finibus. Quisque aliquet quam nec erat pharetra, nec sollicitudin tellus ultricies. Etiam vestibulum quam elit, sed pulvinar nisl vestibulum ac. Integer eget nibh quis sapien laoreet interdum. Vivamus luctus ipsum erat, efficitur malesuada lorem cursus nec. Duis et arcu at metus dictum mollis vitae vel quam. Sed nec nibh mollis, finibus mauris vitae, vestibulum mi. Praesent tempor sapien ac nisl laoreet fermentum. Sed interdum lorem ullamcorper vulputate posuere.
"""

with open(path, 'w+') as fp:
    for i in range(4086):
        fp.write(lorem)

for i in range(4086):
    with open(path) as fp:
        s = fp.read()

