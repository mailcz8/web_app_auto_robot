#!/usr/bin/python

'''
const solution = (arr) => {
    if (!arr) return "";
    if (arr.length === 0) return "";
    const sum = (arr, idx) => {
        if (idx - 1 < arr.length) {
            if (arr[idx - 1] === -1) return 0;
            return arr[idx - 1] + sum(arr, idx * 2) + sum(arr, idx * 2 + 1);
        }
        return 0;
    };
    const left = sum(arr, 2);
    const right = sum(arr, 3);
    return (left == right) ? "" : (left > right ? "Left" : "Right");
};
'''


def CBT(arr=''):
    result = 0
    if arr == '' or arr == 0:
        print('None')
    else:
        for i in range(0, len(arr)):
            # print(i, arr[i])
            if arr[i-1] == -1:
                return 0
            else:
                result = arr[i-1] + sum(arr, i*2) + sum(arr, i*2+1)

CBT([3, 6, 2, 9, -1, 10])

def solution(n, a, b):
    count = 0
    if n == 0:
        return "No stone to start with"
    while n > max(a, b):
        n = n-a-b
        count += 1
    print(count, n, a, b)
    if count%2==0:
        if n < a:
            return False
        else:
            return True
    else:
        if n > b:
            return True
        else:
            return False
# print(solution(9088911,65,117))
# print(solution(7620085,17,110))
# print(solution(7576302, 48, 99))

def next_palindrome(num=None):
    next_palin = num
    try:
        if isinstance(num, str)==True:
            print("{} is not an integer".format(num))
        else:
            if num < 10:
                next_palin = 11
            else:
                next_num = int(num) + 1
                while next_num != int(str(next_num)[::-1]):
                    next_num += 1
                next_palin = next_num
        print('The {} next palindrome = {}'.format(num, next_palin))
        return next_palin
    except:
        print("{} is not an integer".format(num))

next_palindrome(0)
next_palindrome(10)
next_palindrome(11)
next_palindrome(101)
next_palindrome()
next_palindrome(1000)
next_palindrome(12321)
next_palindrome(48576676)
next_palindrome(11.5)
next_palindrome(-1)
next_palindrome(-1000)
next_palindrome(0.3)
next_palindrome('Sunday')
