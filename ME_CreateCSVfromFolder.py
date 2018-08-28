# USAGE :: python3.7 ./ME_CreateCSVfromFolder.py src_dir -R (for recursive)
# Outputs CSV with all MP4's
# Use -R flag to list all mp4's in subfolders as well. default is only top level

import os
import sys
import csv

from datetime import datetime

class FoundVideo(object):
    full_path = ""
    path = ""
    filename = ""
    ext = ""
    modified_date = 0
    modified_date_readable = 0
    newFilename = ""
    
    # The class "constructor" - It's actually an initializer
    def __init__(self, full_path, path, filename, ext, modified_date, modified_date_readable):
        self.full_path = full_path
        self.path = path
        self.filename = filename
        self.ext = ext
        self.modified_date = modified_date
        self.modified_date_readable = modified_date_readable
        self.newFilename = ""

walk_dir = sys.argv[1]
if len(sys.argv) > 2:
    recursiveFlag = sys.argv[2]
else:
    recursiveFlag = False

recursive = False

if recursiveFlag == "-R":
    recursive = True


# create csv from files in target dir
tempExistingVidArray = []

if recursive is True:
    for root, subdirs, files in os.walk(walk_dir):
        for filename in sorted(files):
            file_path = os.path.join(root, filename)
            
            if "mp4" in file_path:
                foundVideo = FoundVideo(file_path, "", filename, "mp4", os.path.getmtime(file_path), datetime.fromtimestamp(os.path.getmtime(file_path)).strftime('%Y-%m-%d %H:%M:%S'))
                tempExistingVidArray.append(foundVideo)
        with open(walk_dir + '/contents.csv', 'w') as fw:
            writer = csv.writer(fw, delimiter=',')
            writer.writerow(["Filename", "Modified Date"])
            for foundVideo in tempExistingVidArray:
                writer.writerow([foundVideo.filename, foundVideo.modified_date_readable])
else:
    for root, subdirs, files in [next(os.walk(walk_dir))]:
        for filename in sorted(files):
            file_path = os.path.join(root, filename)
            
            if "mp4" in file_path:
                foundVideo = FoundVideo(file_path, "", filename, "mp4", os.path.getmtime(file_path), datetime.fromtimestamp(os.path.getmtime(file_path)).strftime('%Y-%m-%d %H:%M:%S'))
                tempExistingVidArray.append(foundVideo)
        with open(walk_dir + '/contents.csv', 'w') as fw:
            writer = csv.writer(fw, delimiter=',')
            writer.writerow(["Filename", "Modified Date"])
            for foundVideo in tempExistingVidArray:
                writer.writerow([foundVideo.filename, foundVideo.modified_date_readable])

print('- - - - - - - - -')
print('Create CSV Complete')
