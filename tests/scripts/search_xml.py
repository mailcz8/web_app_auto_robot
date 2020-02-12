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
    for dir, fn, c in folder_info:
        print(a)
        # print(b)
        # print(c[0], c)
        # break
# get_foldr_content(result_dir)

def apple(name):
    return 'xyz' + name
apple("Aldne")

def find_end_with_re(fname, start_point=None, end_point=None):
    f = open(file_name, '+r')
    end_point = 'End Web Test'
    new_list = []
    new_str = ''
    for line in f.readlines():
        if re.search(r'{}'.format('<kw name="'), line):
            new_list.append(line)
            new_str += line
    return new_str
this_str = find_end_with_re(file_name).split('\n')
# print(this_str[0:5])

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