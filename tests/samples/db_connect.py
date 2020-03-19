#!/usr/bin/python
import sqlite3
import time
import os
from employee import EmployeeDB as emp
import logging

'''
Title: Python SQLite Tutorial: Complete Overview - Creating a Database, Table, and Running Queries
Course info: https://www.youtube.com/watch?v=RSl87lqOXDE
'''
root_path = os.path.dirname(os.path.dirname(os.path.abspath('.')))
result_dir = os.path.join(root_path, 'results')
res_dir = os.path.join(root_path, 'resources')
db_file_path = os.path.join(res_dir, 'test_data', 'employee.db')
# print(root_path, os.path.isfile(db_file_path))
# conn = sqlite3.connect(db_file_path)
# create DB in memory for testing
conn = sqlite3.connect(':memory:')

class SQALite3(object):

    def __init__(self):
        pass

    def create_emp_table(self):
        print("This is:", SQALite3.__class__, SQALite3.__name__)
        # in memory DB
        # conn = sqlite3.connect(':memory:')
        # DB in file
        # conn = sqlite3.connect(file_path)
        c = conn.cursor()
        conn.execute('''CREATE TABLE employees (
                    first text,
                    last text,
                    pay integer
                    )''')
        conn.commit()

    def insert_entry_local(self, *args):
        print('insert_entry_local = ', len(args), type(args), args, args[0], args[1], args[2])
        c = conn.cursor()
        # c.execute("INSERT INTO employees VALUES ('King', 'Foot', 50000)")
        # c.execute("INSERT INTO employees VALUES({}, {}, {})".format(args[0], args[1], args[2]))
        c.execute("INSERT INTO employees VALUES(?, ?, ?)", (args[0], args[1], args[2]))
        conn.commit()

    def insert_entry_remote(self, *args):
        print(args)
        c = conn.cursor()
        # sample: c.execute("INSERT INTO employees VALUES('Mary', 'Lu', 808080)")
        c.execute("INSERT INTO employees VALUES (?, ?, ?)", (args[0], args[1], args[2]))
        c.execute("INSERT INTO employees VALUES (:first, :last, :pay)", {'first':args[0], 'last':args[1], 'pay':args[2]})
        conn.commit()

    def select_entry(self, query=''):
        c = conn.cursor()
        c.execute("select * from employees")
        res = c.fetchone()
        res_many = c.fetchmany(5)
        res_all = c.fetchall()
        print('select_entry =', res_many)
        conn.commit()

    def drop_table(self):
        c = conn.cursor()
        c.execute("DROP TABLE employees")
        conn.commit()

    def close_connection(self):
        logging.info('Close DB connection')
        conn.close()


if __name__ == "__main__":
    x = SQALite3()
    x.create_emp_table()
    x.insert_entry_local("King", "Foot", 50000)
    x.select_entry()

    emp1 = emp("King", "Kong", 555000)
    emp2 = emp("Black", "Pony", 80000)
    x.insert_entry_remote(emp1.fname, emp1.lname, emp1.pay)
    x.insert_entry_remote(emp2.fname, emp2.lname, emp2.pay)
    x.select_entry()
    # x.insert_entry_remote(emp2)
    # x.demo_select_entry()

    # x.drop_table()
    # x.select_entry()
    x.close_connection()


