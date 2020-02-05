
file_name = 'output.xml'

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

get_keywords('Go To')