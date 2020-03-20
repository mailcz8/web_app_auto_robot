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

print(solution(9088911,65,117))
print(solution(7620085,17,110))
print(solution(7576302, 48, 99))