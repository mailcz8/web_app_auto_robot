import os
import time
import re

cur_dir = os.path.abspath('.')
repl_dir = os.path.dirname(os.path.dirname(cur_dir))
result_dir = os.path.join(repl_dir,'results')
file_name = 'output.xml'
file_name = os.path.join(result_dir,file_name)

def get_foldr_content(f_path):
    folder_info = os.walk(f_path)
    print(folder_info)
    for a, b, c in folder_info:
        print(a, b, c)
get_foldr_content(result_dir)

def find_end(f_name):
    f = open(f_name, 'r')
    k = f.readlines()
    new_lst = []
    for i in range(0, len(k)):
        if "<kw name=" in k[i]:
            re = k[i].strip('<kw name="').split('" library=')[0]
            start = True
            # print(type(re), len(re), re)
            if 'End Web Test' not in re:
                new_lst.append(re.strip('>\n'))
            else:
                break
    return new_lst

def get_keywords(begin_line):
    data = find_end(file_name)
    start_line = 0
    final_data = []
    for i in range(0,len(data)):
        if begin_line == data[i]:
            start_line = i
            break
    for i in range(start_line,len(data)):
        print(data[i])

# get_keywords('Go To')