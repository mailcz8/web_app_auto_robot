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
url = 'https://www.pythonforbeginners.com/basics/list-comprehensions-in-python'

class LSTCOMP(object):

    def sample1(self, old_list='', opt=2):
        print(old_list, opt)
        if opt == 1:
            new_list = [i for i in old_list if i != 0]
            # new_list = [i for i in old_list if filter(i == 'Mon', old_list)]
        elif opt == 2:
            new_range = [i * i for i in range(5) if i % 2 == 0]
        elif opt == 3:
            new_list = [i for i in range(10)]
            print(new_list)
        elif opt == 4:
            listOfWords = ["this", "is", "a", "list", "of", "words"]
            new_list = [word[0] for word in listOfWords]
            print(new_list)
        else:
            new_list = []
            for i in old_list:
                if filter(i):
                    new_list.append(i)
        return new_list

    def demo_lambda(self):
        # a list contains both even and odd numbers.
        seq = [0, 1, 2, 3, 5, 8, 13]

        # result contains odd numbers of the list
        # using filter function
        # filtered = filter(fun, sequence)
        result = filter(lambda x: x % 2, seq)
        print(list(result))

        # result contains even numbers of the list
        result = filter(lambda x: x % 2 == 0, seq)
        print(list(result))


if __name__ == '__main__':
    num_list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0]
    char_list = ['Sun', "Mon", 'Tues', 'Wed', 'Tur', 'Fri', 'Sat']
    x = LSTCOMP()
    x.sample1(num_list, 1)
    x.sample1(char_list, 4)
    x.demo_lambda()

