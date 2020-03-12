#!/usr/bin/python3

import requests
import time
import os

'''
Course info: https://www.youtube.com/watch?v=tb8gHvYlCFs
'''
root_path = os.path.dirname(os.path.abspath('.'))
result_dir = os.path.join(root_path, 'results')
res_dir = os.path.join(root_path, 'resources')
td_path = os.path.join(res_dir, 'test_data')

class API_lib(object):
    def __init__(self):
        print("Class info: ", API_lib.__class__, API_lib.__name__)
        self.r = requests

    def api_get(self, url=''):
        print(url)
        r = self.r.get(url)
        print(r)

if __name__ == "__main__":
    test_url = 'https://xkcd.com/353/'
    x = API_lib()
    x.api_get(test_url)


