#!/usr/bin/env python
import os
import sys
import shutil

def flatten(inDir, outDir):
	counter = 1;

	for d in os.listdir(inDir):
		subDir = os.path.join(inDir, d)		
		for root, dirnames, filenames in os.walk(subDir):
			for f in filenames:
				srcFile = os.path.join(inDir, d, f)
				desFile = os.path.join(outDir, f);
				shutil.move(srcFile, desFile)
				print "%d mv %s" % (counter, f)
				counter += 1

	
if __name__ == "__main__":
	flatten(sys.argv[1], sys.argv[2])

    
