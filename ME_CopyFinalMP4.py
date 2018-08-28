# finds latest mp4's in 'ae_outgoing' folders (and subfolders like archive), ignoring leading numerals ('02_outgoing' etc) and copies these files to destination.
# this only works if the final output is in the correct folder. if they've had audio added the final video will be in a diff location.

# USAGE :: python3.7 ./ME_CopyFinalMP4.py src_dir dest_dir

# checks for the latest file in that folder (it ignores file names, so if someone accidentally drops in a wrong part, it'll take that)
# creates new file name based on folder path, checks if the latest file matches, if not, shows a warning with old and new file name
# checks the src folder for any existing content
# if there's existing content, it first checks if the file name exists(without version nr), if it does, it compares the files to make sure they're the same.
# if there's a new version, it deletes the old one, and copies the new one
# creates CSV with copied files

import os
import sys
import re
import shutil
import sys
import filecmp
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

def progress_percentage(perc, width=None):
    # This will only work for python 3.3+ due to use of
    # os.get_terminal_size the print function etc.
    
    FULL_BLOCK = '█'
    # this is a gradient of incompleteness
    INCOMPLETE_BLOCK_GRAD = ['░', '▒', '▓']
    
    assert(isinstance(perc, float))
    assert(0. <= perc <= 100.)
    # if width unset use full terminal
    if width is None:
        width = os.get_terminal_size().columns
    # progress bar is block_widget separator perc_widget : ####### 30%
    max_perc_widget = '[100.00%]' # 100% is max
    separator = ' '
    blocks_widget_width = width - len(separator) - len(max_perc_widget)
    assert(blocks_widget_width >= 10) # not very meaningful if not
    perc_per_block = 100.0/blocks_widget_width
    # epsilon is the sensitivity of rendering a gradient block
    epsilon = 1e-6
    # number of blocks that should be represented as complete
    full_blocks = int((perc + epsilon)/perc_per_block)
    # the rest are "incomplete"
    empty_blocks = blocks_widget_width - full_blocks
    
    # build blocks widget
    blocks_widget = ([FULL_BLOCK] * full_blocks)
    blocks_widget.extend([INCOMPLETE_BLOCK_GRAD[0]] * empty_blocks)
    # marginal case - remainder due to how granular our blocks are
    remainder = perc - full_blocks*perc_per_block
    # epsilon needed for rounding errors (check would be != 0.)
    # based on reminder modify first empty block shading
    # depending on remainder
    if remainder > epsilon:
        grad_index = int((len(INCOMPLETE_BLOCK_GRAD) * remainder)/perc_per_block)
        blocks_widget[full_blocks] = INCOMPLETE_BLOCK_GRAD[grad_index]
    
    # build perc widget
    str_perc = '%.2f' % perc
    # -1 because the percentage sign is not included
    perc_widget = '[%s%%]' % str_perc.ljust(len(max_perc_widget) - 3)

    # form progressbar
    progress_bar = '%s%s%s' % (''.join(blocks_widget), separator, perc_widget)
    # return progressbar as string
    return ''.join(progress_bar)


def copy_progress(copied, total):
    print('\r' + progress_percentage(100*copied/total, width=30), end='')


def copyfile(src, dst, *, follow_symlinks=True):
    """Copy data from src to dst.
        
    If follow_symlinks is not set and src is a symbolic link, a new
    symlink will be created instead of copying the file it points to.
    
    """
    if shutil._samefile(src, dst):
        raise shutil.SameFileError("{!r} and {!r} are the same file".format(src, dst))
    
    for fn in [src, dst]:
        try:
            st = os.stat(fn)
        except OSError:
            # File most likely does not exist
            pass
        else:
            # XXX What about other special files? (sockets, devices...)
            if shutil.stat.S_ISFIFO(st.st_mode):
                raise shutil.SpecialFileError("`%s` is a named pipe" % fn)

    if not follow_symlinks and os.path.islink(src):
        os.symlink(os.readlink(src), dst)
    else:
        size = os.stat(src).st_size
        with open(src, 'rb') as fsrc:
            with open(dst, 'wb') as fdst:
                copyfileobj(fsrc, fdst, callback=copy_progress, total=size)
    return dst


def copyfileobj(fsrc, fdst, callback, total, length=16*1024):
    copied = 0
    while True:
        buf = fsrc.read(length)
        if not buf:
            break
        fdst.write(buf)
        copied += len(buf)
        callback(copied, total=total)


def copy_with_progress(src, dst, *, follow_symlinks=True):
    if os.path.isdir(dst):
        dst = os.path.join(dst, os.path.basename(src))
    copyfile(src, dst, follow_symlinks=follow_symlinks)
    shutil.copymode(src, dst)
    shutil.copystat(src, dst)
    return dst

def generateFileName (filePath, ext, verNR):
    courseRegEx = r'01_MASTER_BUILD\/[\w\d\s()_-]{0,}'
    unitRegEx = r'unit_[\w\d\s()_-]{0,}'
    lessonRegEx = r'lesson_[0-9]{0,}'
    partRegEx = r'part_[\w\d\s()_-]{0,}'
    
    course = str.replace(re.search(courseRegEx,filePath,re.IGNORECASE)[0], '01_MASTER_BUILD/', '')
    unit = str.replace(re.search(unitRegEx,filePath,re.IGNORECASE)[0], 'unit_', 'u')
    part = str.replace(re.search(partRegEx,filePath,re.IGNORECASE)[0], 'part_', 'p')
    lesson = str.replace(re.search(lessonRegEx,filePath,re.IGNORECASE)[0], 'lesson_', 'l')
    
    newFileName = course+"_"+unit+"_"+lesson+"_"+part+"_"+verNR+"."+ext
    
    if "p01" in part:
        newFileName = "LOGO_"+newFileName

    return newFileName


walk_dir = sys.argv[1]
copyDest_dir = sys.argv[2]


#walk_dir = '/Volumes/mindful_rack/Courses/01_MASTER_BUILD/aat-l2/unit_02'
#copyDest_dir = '/Volumes/mindful_rack/Courses/temp/'

outFolder = 'ae_outgoing'
outFolderRegEx = r'\/[\d\w\s]{0,}ae_outgoing'
filenameRegEx = r'_v[\d\w\s]{0,}\.mp4'
versionNRRegEx = r'v[0-9]{0,}'

folderDict = {}
existingVidArray = []

print('- - - - - - - - -')
print('Checking existing files')

# check target dir for files
for root, subdirs, files in os.walk(copyDest_dir):
    for filename in files:
        file_path = os.path.join(root, filename)

        if "mp4" in file_path:
            foundVideo = FoundVideo(file_path, re.split(outFolderRegEx,root)[0], filename, "mp4", os.path.getmtime(file_path), datetime.fromtimestamp(os.path.getmtime(file_path)).strftime('%Y-%m-%d %H:%M:%S'))
            existingVidArray.append(foundVideo)

print('- - - - - - - - -')
print('Checking existing files Complete')


print('')
print('- - - - - - - - -')
print('Checking new files')

for root, subdirs, files in os.walk(walk_dir):

        for filename in files:
            file_path = os.path.join(root, filename)
            
            if outFolder in file_path:
                if "mp4" in file_path:
                    foundVideo = FoundVideo(file_path, re.split(outFolderRegEx,root)[0], filename, "mp4", os.path.getmtime(file_path), datetime.fromtimestamp(os.path.getmtime(file_path)).strftime('%Y-%m-%d %H:%M:%S'))
                    
                    if foundVideo.path in folderDict:
                        folderDict[foundVideo.path].append(foundVideo)
                    else:
                        folderDict[foundVideo.path] = []
                        folderDict[foundVideo.path].append(foundVideo)

print('- - - - - - - - -')
print('Checking new files Complete')

for key in folderDict:
    print('')
    toCopyArray = []
    modified_date = 0
    
    # find newest date. could be optimised by sorting by date
    for foundVideo in folderDict[key]:
        if foundVideo.modified_date > modified_date:
            modified_date = foundVideo.modified_date
    # select newest file, and add to array ready to copy
    for foundVideo in folderDict[key]:
        if foundVideo.modified_date is modified_date:
            toCopyArray.append(foundVideo)
    # create new filename based on folder
    for foundVideo in toCopyArray:
#        print(foundVideo.path)
        foundVideo.newFilename = generateFileName(foundVideo.path, foundVideo.ext, re.search(versionNRRegEx,foundVideo.filename,re.IGNORECASE)[0])
        if str.replace(foundVideo.newFilename.lower(), 'logo_', '') not in foundVideo.filename.lower():
            print("!!! WARNING !!! File name does NOT match folder path ::", foundVideo.filename, ">>", foundVideo.newFilename)

    # compare files with existing files
    if len(existingVidArray) > 0:
        matchedFile = 0
        for foundVideo in toCopyArray:
            for existingVideo in existingVidArray:
                if os.path.isfile(existingVideo.full_path):
                    fileOrig = re.split(filenameRegEx,existingVideo.filename)[0]
                    fileNew = re.split(filenameRegEx,foundVideo.filename)[0]
                    fileNewRenamed = re.split(filenameRegEx,foundVideo.newFilename)[0]
                    if fileOrig in fileNew:
                        matchedFile = 1
                        if filecmp.cmp(foundVideo.full_path, existingVideo.full_path):
                            if existingVideo.filename not in foundVideo.filename:
                                # contents of the files are the same, but filename isn't. not sure if this should delete the old file though, as it could be a mistake (accidental duplicate)
    #                            copy_with_progress(foundVideo.full_path, os.path.join(copyDest_dir, foundVideo.filename))
                                print('- file contents same, keeping renamed file -', foundVideo.filename, '>>', existingVideo.filename)
                            else:
                                print('                files are the same, do nothing', fileOrig)
                        else:
                            if foundVideo.modified_date > existingVideo.modified_date:
                                copy_with_progress(foundVideo.full_path, os.path.join(copyDest_dir, foundVideo.newFilename))
                                print (' ## Found new version - Copied :: ', foundVideo.filename, '>>', foundVideo.newFilename)
                                os.remove(existingVideo.full_path)
                                print (' ## Found new version - DELETED OLD :: ', existingVideo.filename)
                            else:
                                if os.path.exists(os.path.join(copyDest_dir, foundVideo.filename)):
                                    print (' ## Found alternate - OLDER - version - FILE EXISTS :: ', foundVideo.filename, '::', foundVideo.modified_date_readable)
                                else:
                                    copy_with_progress(foundVideo.full_path, os.path.join(copyDest_dir, foundVideo.newFilename))
                                    print (' ## Found alternate - OLDER - version - Copied :: ', foundVideo.filename, '>>', foundVideo.newFilename)
                                print (' ## retained newer file', existingVideo.filename, '::', existingVideo.modified_date_readable)
                    elif fileOrig in fileNewRenamed:
                        matchedFile = 1
                        if filecmp.cmp(foundVideo.full_path, existingVideo.full_path):
                            if existingVideo.filename not in foundVideo.filename:
                                # contents of the files are the same, but filename isn't. not sure if this should delete the old file though, as it could be a mistake (accidental duplicate)
                                #                            copy_with_progress(foundVideo.full_path, os.path.join(copyDest_dir, foundVideo.filename))
                                print('- file contents same, keeping renamed file -', foundVideo.filename, '>>', existingVideo.filename)
                            else:
                                print('                files are the same, do nothing', fileOrig)
                        else:
                            if foundVideo.modified_date > existingVideo.modified_date:
                                copy_with_progress(foundVideo.full_path, os.path.join(copyDest_dir, foundVideo.newFilename))
                                print (' ## Found new version - Copied :: ', foundVideo.filename, '>>', foundVideo.newFilename)
                                os.remove(existingVideo.full_path)
                                print (' ## Found new version - DELETED OLD :: ', existingVideo.filename)
                            else:
                                if os.path.exists(os.path.join(copyDest_dir, foundVideo.filename)):
                                    print (' ## Found alternate - OLDER - version - FILE EXISTS :: ', foundVideo.filename, '::', foundVideo.modified_date_readable)
                                else:
                                    copy_with_progress(foundVideo.full_path, os.path.join(copyDest_dir, foundVideo.newFilename))
                                    print (' ## Found alternate - OLDER - version - Copied :: ', foundVideo.filename, '>>', foundVideo.newFilename)
                                print (' ## retained newer file', existingVideo.filename, '::', existingVideo.modified_date_readable)
                    else:
                        if filecmp.cmp(foundVideo.full_path, existingVideo.full_path):
                            matchedFile = 1
                            if existingVideo.filename not in foundVideo.filename:
                                # contents of the files are the same, but filename isn't. not sure if this should delete the old file though, as it could be a mistake (accidental duplicate)
    #                            copy_with_progress(foundVideo.full_path, os.path.join(copyDest_dir, foundVideo.filename))
                                print('- file contents same, keeping renamed file -', foundVideo.filename, '>>', existingVideo.filename)
                            else:
                                print('                files are the same, do nothing', fileOrig)
                                    
        if matchedFile == 0:
            copy_with_progress(foundVideo.full_path, os.path.join(copyDest_dir, foundVideo.newFilename))
            print (' ## Existing files found, no matches - Copied :: ', foundVideo.filename, '>>', foundVideo.newFilename)
#    Destination folder is empty
    else:
        for foundVideo in toCopyArray:
            copy_with_progress(foundVideo.full_path, os.path.join(copyDest_dir, foundVideo.newFilename))
            print (' ## no old files found. Copied :: ', foundVideo.filename, '>>', foundVideo.newFilename)

print('- - - - - - - - -')
print('Copying new files Complete')

print('')
print('- - - - - - - - -')
print('Create CSV')



# create csv from files in target dir
tempExistingVidArray = []
for root, subdirs, files in os.walk(copyDest_dir):
    for filename in sorted(files):
        file_path = os.path.join(root, filename)
        
        if "mp4" in file_path:
            foundVideo = FoundVideo(file_path, re.split(outFolderRegEx,root)[0], filename, "mp4", os.path.getmtime(file_path), datetime.fromtimestamp(os.path.getmtime(file_path)).strftime('%Y-%m-%d %H:%M:%S'))
            tempExistingVidArray.append(foundVideo)
    with open(copyDest_dir + '/contents.csv', 'w') as fw:
        writer = csv.writer(fw, delimiter=',')
        writer.writerow(["Filename", "Modified Date"])
        for foundVideo in tempExistingVidArray:
            writer.writerow([foundVideo.filename, foundVideo.modified_date_readable])

print('- - - - - - - - -')
print('Create CSV Complete')
