#from http://www.vips.ecs.soton.ac.uk/index.php?title=Speed_and_Memory_Use#PIL_.28and_Pillow.29
import sys
from PIL import Image, ImageFilter, PILLOW_VERSION

# just to confirm we are getting the right version 
# print("pillow.py: PILLOW_VERSION =", PILLOW_VERSION)

im = Image.open(sys.argv[1])

# Crop 100 pixels off all edges.
im = im.crop((100, 100, im.size[0] - 100, im.size[1] - 100))

# Shrink by 10%

# starting with 2.7, Pillow uses a high-quality convolution-based resize for 
# BILINEAR ... the other systems in this benchmark are using affine + bilinear,
# so this is rather unfair. Use NEAREST instead, it gets closest to what
# everyone else is doing
im = im.resize((int (im.size[0] * 0.9), int (im.size[1] * 0.9)), Image.NEAREST)

# sharpen
for xx in range(5, 10):
    for y in range(-16, 16):
        x = xx / 10.0
        filter = ImageFilter.Kernel((3, 3),
                  (-x, -x, -x,
                   -x, y / 8.0, -x,
                   -x, -x, -x))
        im = im.filter(filter)

# write back again
im.save(sys.argv[2])
