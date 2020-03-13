from __future__ import division, absolute_import, print_function

import os
import requests as req
import numpy as np
from numpy.testing import (
     assert_, assert_equal, assert_array_equal, assert_raises, HAS_REFCOUNT
    )

current_path = os.path.dirname(os.path.abspath('.'))
root_path = os.path.dirname(current_path)
print(root_path)
result_dir = os.path.join(root_path, 'results')
res_dir = os.path.join(root_path, 'resources')
td_path = os.path.join(res_dir, 'test_data')
test_img_file_path = os.path.join(result_dir, 'test_image.png')

url = 'https://xkcd.com/353/'
img_url = 'https://imgs.xkcd.com/comics/python.png'

def get_api_info(url):
    r = req.get(url)
    print(dir(r))
    print(r.text)
    print(r.content)
# get_api_info(url)

def dl_img(url):
    r = req.get(url)
    with open(test_img_file_path, 'wb') as f:
        f.write(r.content)
dl_img(img_url)
