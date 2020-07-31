from PIL import Image
import sys

y_max = 20;
x_max = round(y_max * 1200/1697)
print("mapping 1200x1697 to %dx%d." % (x_max, y_max) )

for i in range(10):
    im = Image.open('%s-a4-1200x1697.jpg' % i)
    f = open('%s.pixel' % i, 'w')


    pixel = ''
    x_step = im.size[0] / x_max;
    y_step = im.size[1] / y_max;
    for y in range(y_max):
        for x in range(x_max):
            color = im.getpixel((x*x_step, y*y_step))
            if (color[0] < 200 and color[1] < 200 and color[2] < 200):
                pixel = '1' + pixel
                f.write('1')
            else:
                pixel = '0' + pixel
                f.write('0')
            #print(color)
        f.write("\n")

    print("%d = %X" % (i, int(pixel, 2)))
    f.close()

