#!/usr/bin/env python3
i = 1
from pyquery import PyQuery as pq
file = open("url.txt")
count = len(open("url.txt").readlines())
while i<=count:
  print(i)
  line = file.readline()
  doc=pq(line)
  title=doc('.artical-title').text()
  content=doc('#show-blog-content').text()
  print(line,"\n",title,"\n",content)
  print("#########################")
  i+=1
  #print(doc)
'''
title=doc('.artical-title').text()
content=doc('#show-blog-content').text()
print(title,content)
'''
#$('.artical-title').text()
#$('#show-blog-content').text()