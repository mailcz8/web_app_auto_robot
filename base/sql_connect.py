#!/usr/bin/python
import sqlite3
import time
import os

'''
Course info: https://www.youtube.com/watch?v=RSl87lqOXDE
'''
root_path = os.path.dirname(os.path.abspath('.'))
result_dir = os.path.join(root_path, 'results')
res_dir = os.path.join(root_path, 'resources')
td_path = os.path.join(res_dir, 'test_data')

class SQALite3():
    def connect():
        file_path = os.path.join(td_path, 'employee.db')
        # in memory DB
        # conn = sqlite3.connect(':memory:')
        # DB in feil
        conn = sqlite3.connect(file_path)

    def print_demo():
        print("This is ", SQALite3.__class__, SQALite3.__name__)


if __name__ == "__main__":
    x = SQALite3
    x.print_demo()
    x.connect()

