#!/usr/bin/env python
import os 
import rawpy
import datetime
import time
import dateutil.parser
from exifread import process_file #, exif_log, __version__


dir_path = os.path.dirname(os.path.realpath(__file__))

allImages = os.listdir(dir_path); # , "*.NEF").filter()
allImages = filter(lambda x: x.endswith(".NEF"), allImages )

imageDatesDict = {}


# => "SubSecTimeDigitized"


for img in allImages:
	path = dir_path + "/" + img
	with open(str(path), 'rb') as img_file:
#	with rawpy.imread(path) as raw:
#		print(img + " " +  )
	
#	data = process_file(path, stop_tag="DateTimeOriginal", details=true, strict=false, debug=true)
		data = process_file(img_file)
	
		if not data:
			print("No EXIF information found")
			continue
		
		print(img + " -> " + str(data["EXIF DateTimeOriginal"]))
		
		#print(type(data["EXIF DateTimeOriginal"]))
		#print(type(data["EXIF DateTimeOriginal"].values))
		
		#date = datetime.datetime(data["EXIF DateTimeOriginal"].values)
		date = dateutil.parser.parse(data["EXIF DateTimeOriginal"].values)
		print(data["EXIF SubSecTime"].values)
		
		
		milliseconds =  int(data["EXIF SubSecTime"].values) * 10 # todo: allways factor 10 ? or depending on camery model ? whtas the case of faster cameras ?
		
		date = date +  datetime.timedelta(milliseconds=milliseconds)
		#EXIF SubSecTime
		
		#date.
		#fulldate = fulldate + datetime.timedelta(milliseconds=500)
		
		print(date)
		print(type(date))
		imageDatesDict[path] = date
		


