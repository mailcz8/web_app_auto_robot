from __future__ import division, absolute_import, print_function

import os
import requests as req
import subprocess as sub

import numpy as np
from numpy.testing import (
     assert_, assert_equal, assert_array_equal, assert_raises, HAS_REFCOUNT
    )

current_path = os.path.dirname(os.path.abspath('.'))
root_path = os.path.dirname(current_path)
result_dir = os.path.join(root_path, 'results')
res_dir = os.path.join(root_path, 'resources')
td_path = os.path.join(res_dir, 'test_data')
test_img_file_path = os.path.join(result_dir, 'test_image.png')

youtub_ref = 'https://www.youtube.com/watch?v=tb8gHvYlCFs'
url = 'https://xkcd.com/353/'
img_url = 'https://imgs.xkcd.com/comics/python.png'
url_httpbin = 'https://httpbin.org/'

def get_api_info(url):
    r = req.get(url)
    print(r.ok, r.status_code, r.history)
    print(dir(r))
    print(r.headers)
    # print(r.text)
    # print(r.content)
# get_api_info(url)

def dl_img(url):
    r = req.get(url)
    with open(test_img_file_path, 'wb') as f:
        f.write(r.content)
    print(r.status_code)
    # sub.run('open {}'.format(test_img_file_path), shell=True, check=True)
    # sub.run('ls {}'.format(test_img_file_path), shell=True, check=True)
    # sub.run('rm {}'.format(test_img_file_path), shell=True, check=True)
# dl_img(img_url)

def http_req_get(url=''):
    url = url+'get'
    payload = {'page' : 2, 'count' : 25}
    # print(url+payload)
    r = req.get(url, params=payload)
    print(r.url)
    # print(r.text)
http_req_get(url_httpbin)

def http_req_post(url=''):
    url = url+'post'
    payload = {'username' : 'jim', 'password' : 'testing'}
    r = req.post(url, data=payload)
    r_dict = r.json()
    print(r_dict['form'])
    print(r.url)
    print(r.text)
# http_req_post(url_httpbin)

def http_reg_basic_auth():
    payload = ('jim', 'testing')
    url = 'https://httpbin.org/basic-auth/jim/testing'
    try:
        r = req.get(url, auth=payload, timeout=1)
        print(r.status_code)
        print(r.text)
        print(r.raise_for_status())
    except Exception as e:
        print("Something is WRONG!!!", e)
http_reg_basic_auth()

def http_reg_delay_timeout(x=0, timeout=5):
    url = 'https://httpbin.org/delay/'+str(x)
    print("Expected delay = {}; system timeout at: {}".format(x, timeout))
    if x > int(timeout):
        print("Test passed")
    else: print('Test failed')
    r = req.get(url, timeout=int(timeout))
    print(r.status_code)
    print(r.text)
http_reg_delay_timeout(3)