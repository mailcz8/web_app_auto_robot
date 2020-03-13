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

web_ref = 'List Comprehensions'
url = ''

class LSTCOMP(object):

    def sample1(self, opt=1):
        if opt == 1:
            new_list = [expression(i) for i in old_list if filter(i)]
        else:
            new_list = []
            for i in old_list:
                if filter(i):
                    new_list.append(expressions(i))
        return new_list


if __name__ == '__main__':
    x = LSTCOMP()
    x.sample1()