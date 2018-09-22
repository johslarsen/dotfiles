#!/usr/bin/env python2
import os
import re
import unittest

if __name__ == "__main__":

	mydir = os.path.dirname(os.path.realpath(__file__))

	re_unittest = re.compile("class[\s]+([_a-zA-Z][_a-zA-Z0-9]*)\(unittest.TestCase\)")

	imports = []
	for root, dirs, files in os.walk(mydir):
		for filename in files:
			if not filename.lower().endswith(".py"):
				continue

			module = ((root+"/")[len(mydir)+1:]).replace("/", ".") + filename[0:-3]
			testcases = []
			with open(root+"/"+filename) as f:
				for line in f.readlines():
					m = re_unittest.match(line)
					if m is None:
						continue

					testcases.append(m.group(1))
			if len(testcases) > 0:
				imports.append((module, testcases))

	for module_name, testcases in imports:
		module = __import__(module_name, fromlist=testcases)
		namespace_to_add= {class_name: module.__dict__[class_name] for class_name in testcases}
		globals().update(namespace_to_add)

	unittest.main()
