#!/usr/bin/python
import sqlite3
import time
import os
from employee import Employee

'''
Title: Python SQLite Tutorial: Complete Overview - Creating a Database, Table, and Running Queries
Course info: https://www.youtube.com/watch?v=RSl87lqOXDE
'''
root_path = os.path.dirname(os.path.dirname(os.path.abspath('.')))
result_dir = os.path.join(root_path, 'results')
res_dir = os.path.join(root_path, 'resources')
db_file_path = os.path.join(res_dir, 'test_data', 'employee.db')
# print(root_path, os.path.isfile(db_file_path))
conn = sqlite3.connect(db_file_path)

class SQALite3(object):

    def first_create_table(self):
        print("This is:", SQALite3.__class__, SQALite3.__name__)
        # in memory DB
        # conn = sqlite3.connect(':memory:')
        # DB in file
        # conn = sqlite3.connect(file_path)
        c = conn.cursor()
        c.execute('''CREATE TABLE employees (
                    first text,
                    last text,
                    pay integer
                    )''')
        conn.commit()
        conn.close()

    def insert_entry(self, query=''):
        print("This is ", SQALite3.__class__, SQALite3.__name__)
        c = conn.cursor()
        # sample: c.execute("INSERT INTO employees VALUES('Mary', 'Lu', 808080)")
        sample: c.execute("INSERT INTO employees VALUES('{}', '{}', {)".format())
        conn.commit()
        conn.close()

    def select_entry(self, query=''):
        print("This is ", SQALite3.__class__, SQALite3.__name__)
        c = conn.cursor()
        c.execute("select * from employees")
        res = c.fetchone()
        res_many = c.fetchmany(5)
        # print(res_many)
        # res_all = c.fetchall()
        print(c.fetchall)
        conn.commit()
        conn.close()

if __name__ == "__main__":
    x = SQALite3()
    # x.first_demo()
    # x.demo_insert_entry()
    x.demo_select_entry()
    emp1 = Employee("Joe", "Smith", 50000)
    emp2 = Employee("Black", "Pony", 80000)


