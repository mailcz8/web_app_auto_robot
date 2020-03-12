#!/usr/bin/python
import subprocess as sub
import sys, os
'''ref https://www.youtube.com/watch?v=2Fp1N6dof0Y'''

current_path = os.path.dirname(os.path.realpath(__file__))
root_path = os.path.dirname(current_path)
results_path = os.path.join(root_path,'results')
output_file_path = os.path.join(results_path,'output.txt')

class Get_Prompt_Info():
    def __init__(self):
        self.default_comm = ['ls', '-al']

    def basic_opt(self, comm=None):
        print(type(comm), comm)
        if comm == None:
            comm = self.default_comm
        print('current comm = ', type(comm), comm)
        # info = sub.run(comm)
        # print("info 1 =", info.args, info.returncode, info.stdout)
        info = sub.run(comm, stdout=sub.PIPE, text=True)
        data = info.stdout.split('\n')
        for i in data:
            if 'sql' in i:
                print(i)

    def subpro_opt_to_file(self, comm=None):
        if comm == None:
            comm = ['ls', '-al']
        with open(output_file_path, 'w') as f:
            p1 = sub.run(comm, stdout=f, text=True, check=True)
        # data = info.stdout.split('\n')

    def subpro_error(self, comm=None):
        print(sys.version_info)
        if comm == None:
            comm = ['ls', '-al', 'dne']
        # data = info.stdout.split('\n')
        try:
            p1 = sub.run(comm, capture_output=True, shell=True, text=True, check=True)
            if p1.returncode == 0:
                print(p1.stdout)
        except:
            print("Something is wrong, please check")

if __name__ == '__main__':
    comm = ['ls', '-al']
    x = Get_Prompt_Info()
    x.basic_opt(comm)
    x.subpro_opt_to_file(comm)

