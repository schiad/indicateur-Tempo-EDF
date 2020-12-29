# Simple test for NeoPixels on Raspberry Pi
import time
import board
import neopixel
import os
import sys

# Choose an open pin connected to the Data In of the NeoPixel strip, i.e. board.D18
# NeoPixels must be connected to D10, D12, D18 or D21 to work.
pixel_pin = board.D18

# The number of NeoPixels
num_pixels = 8

# The order of the pixel colors - RGB or GRB. Some NeoPixels have red and green reversed!
# For RGBW NeoPixels, simply change the ORDER to RGBW or GRBW.
ORDER = neopixel.GRB
ROUGE = (10, 0, 0)
OFF = (0, 0, 0)
ND = (0, 0, 0)
VERT = (0, 10, 0)
BLEU = (0, 0, 10)
CYAN = (0, 10, 10)
ORANGE = (10, 10, 0)
VIOLET = (10, 0, 10)
BLANC = (10, 10, 10)

pixels = neopixel.NeoPixel(
    pixel_pin, num_pixels, brightness=1, auto_write=False, pixel_order=ORDER
)

pixels.fill(VERT)
pixels.show()
time.sleep(0.01)

st = 'argv' + str(len(sys.argv)) + '.'
print(st)
#print(sys.argv[1])
#print(sys.argv[2])

if (len(sys.argv) == 9):
	i = 0;
	while i < 9:
		print("...")
		print(i)
		print(sys.argv[i])
		if (sys.argv[i].find("BLEU") > -1):
			pixels[i-1] = BLEU
		elif (sys.argv[i].find("ROUGE") > -1):
			pixels[i-1] = ROUGE
		elif (sys.argv[i].find("BLANC") > -1):
			pixels[i-1] = BLANC
		else:
			pixels[i-1] = VERT
		i += 1
else:
	pixels[0] = ROUGE
pixels.show()

