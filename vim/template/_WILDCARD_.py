#:%s/#CLASS#/\=ToCamel(RPath('%:t:r'))/g
#!/usr/bin/env python2
import unittest

class #CLASS#(object):

	def __init__(self):
		#CURSOR#

class Test#CLASS#(unittest.TestCase):

	def setUp(self):
		pass

	def tearDown(self):
		pass


if __name__ == "__main__":
	unittest.main()
