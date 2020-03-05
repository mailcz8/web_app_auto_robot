#!/usr/bin/python

'''
Course info: https://www.youtube.com/watch?v=RSl87lqOXDE
'''


class Employee:
    raise_amt = 1.04
    def __init__(self, fname, lname, pay):
        self.fname = fname
        self.lname = lname
        self.email = self.fname + self.lname + '@gmail.com'
        self.pay = pay

    def full_name(self):
        return '{} {}'.format(self.fname, self.lname)

    def apply_raise(self):
        self.pay = self.pay * self.raise_amt
        return self.pay

class Developer(Employee):
    raise_amt = 1.5

    def __init__(self, fname, lname, pay, prog_lang):
        super().__init__(fname, lname, pay)
        # the following init call is ok, but not the best
        # Employee.__init__(self, fname, lname, pay)
        self.prog_lang = prog_lang

    # def apply_raise(self):
    #     raise_amt = 1.5
    #     self.pay = self.pay * raise_amt
    #     # return self.pay


class Manager(Employee):
    def __init__(self, fname, lname, pay, employees=None):
        super().__init__(fname, lname, pay)
        if employees is None:
            self.employees = []
        else:
            self.employees = employees

    def add_emp(self, emp):
        if emp not in self.employees:
            self.employees.append(emp)

    def remove_emp(self, emp):
        if emp  in self.employees:
            self.employees.remove(emp)

    def print_emps(self):
        for emp in self.employees:
            print('-->', emp.full_name())

if __name__ == "__main__":
    emp1 = Employee("Joe", "Smith", 50000)
    emp2 = Employee("Black", "Pony", 80000)
    print(emp1.email, emp2.full_name(), emp2.apply_raise())

    dev1 = Developer("Uno", "DevOne", 150000, "Python")
    dev2 = Developer("Toto", "DevTwo", 200000, 'Java')

    emp1_pay, emp1_after_raise = emp1.pay, emp1.apply_raise()
    # dev1_pay, dev1_after_raise, dev1_prog_lang = dev1.pay, dev1.apply_raise()
    # print('emp1:', emp1_pay, emp1_after_raise, '; raise = ', abs(emp1_pay-emp1_after_raise))
    # print('org: dev1: 150000 156000.0 ; raise =  6000.0')
    # print('dev1:', dev1_pay, dev1_after_raise, '; raise = ', abs(dev1_pay-dev1_after_raise))

    mgr1 = Manager('Sue', "Smith", 900000, [dev1])
    print('mgr info: {0}; {1}'.format(mgr1.full_name(), mgr1.email))
    mgr1.print_emps()
    print('Add emp:', dev2.full_name(), mgr1.add_emp(dev2))
    mgr1.print_emps()