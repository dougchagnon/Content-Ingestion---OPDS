#!/usr/bin/python
 
import sys,os
import zipfile

from lxml import etree

NSMAP = { 
   'html': 'http://www.w3.org/1999/xhtml' 
}
 
def dir_crawl(file_path):
    return_files = []
    for path, subdirs, files in os.walk(file_path):
        for name in files:
            if '.epub' in name:
                rel_path = os.path.join(path, name)
                return_files.append(rel_path)
    return return_files
 
epubs_list = dir_crawl('.')
 
#print "Found %s files..." % len(epubs_list)

for epub_path in epubs_list:
    zf = zipfile.ZipFile(epub_path)
    html_files=[f for f in zf.namelist() if '.html' in f]
    
    for filename in html_files:
        try:
            data = zf.read(filename)
        except KeyError:
            print 'ERROR: Did not find %s in zip file' % filename
        else:
            xml = etree.fromstring(data)
            
            nav_contents = xml.xpath('html:body/html:nav', namespaces=NSMAP)
            if len(nav_contents) > 0:
               print data