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
        # This is a bad practice because does not check and validate injections
        # c.execute("INSERT INTO employees VALUES({}, {}, {})".format(args[0], args[1], args[2]))
        c.execute("INSERT INTO employees VALUES(?, ?, ?)", (args[0], args[1], args[2]))
        conn.commit()

    def insert_entry_remote(self, *args):
        # print(args)
        c = conn.cursor()
        # sample: c.execute("INSERT INTO employees VALUES('Mary', 'Lu', 808080)")
        c.execute("INSERT INTO employees VALUES (?, ?, ?)", (args[0], args[1], args[2]))
        conn.commit()

    def insert_entry_remote_column_name(self, *args):
        # print(args)
        c = conn.cursor()
        # sample: c.execute("INSERT INTO employees VALUES('Mary', 'Lu', 808080)")
        c.execute("INSERT INTO employees VALUES (:first, :last, :pay)",
                  {'first': args[0], 'last': args[1], 'pay': args[2]})
        conn.commit()

    def select_entry(self, query='', option=3):
        c = conn.cursor()
        try:
            c.execute("select * from employees")
            if option == 1:
                res = c.fetchone()
                print("Show one entry =", res)
            elif option == 2:
                count = 3
                res_many = c.fetchmany(count)
                print('select {} entry ='.format(count), len(res_many), res_many)
            else:
                res_all = c.fetchall()
                for i in range(0,len(res_all)):
                    print('select all entry of {} = {}'.format(i+1, res_all[i]))
            conn.commit()
        except:
            print("No table found!!!")

    def drop_table(self, table_name='employees'):
        c = conn.cursor()
        try:
            c.execute("DROP TABLE {}".format(table_name))
            print('{} table dropped.'.format(table_name.upper()))
            conn.commit()
        except:
            print('No table {} found'.format(table_name))

    def close_connection(self):
        print('Close DB connection')
        logging.info('Close DB connection')
        conn.close()


if __name__ == "__main__":
    x = SQALite3()
    x.create_emp_table()
    x.insert_entry_local("First", "Local", 50000)
    # x.select_entry()

    emp1 = emp("King", "Kong", 555000)
    emp2 = emp("Black", "Pony", 80000)
    emp3 = emp("Sunday", "School", 80000)
    emp4 = emp("Pitch", "White", 80000)
    emp5 = emp("Cookie", "Monster", 80000)
    emp6 = emp("Last", "End", 80000)
    x.insert_entry_remote(emp1.fname, emp1.lname, emp1.pay)
    x.insert_entry_remote_column_name(emp2.fname, emp2.lname, emp2.pay)
    x.insert_entry_remote(emp3.fname, emp3.lname, emp3.pay)
    x.insert_entry_remote(emp4.fname, emp4.lname, emp4.pay)
    x.insert_entry_remote(emp5.fname, emp3.lname, emp5.pay)
    x.insert_entry_remote(emp6.fname, emp6.lname, emp6.pay)
    x.select_entry()
    # x.insert_entry_remote(emp2)
    # x.demo_select_entry()

    x.drop_table()
    x.select_entry()
    x.close_connection()


