'''
2 * 1 = 2
2 * 2 = 4
2 * 3 = 6
2 * 4 = 8
2 * 5 = 10
2 * 6 = 12
2 * 7 = 14
2 * 8 = 16
2 * 9 = 18
'''
a = input()
for i in range(1,10):
    print(f"{int(a)} * {i} = {int(int(a)*i)}")

## 두 정수 A와 B를 입력받은 다음, A+B를 출력하는 프로그램을 작성하시오.
num = input()
num = int(num)

for i in range(num):
    a, b = input().split()
    a, b = int(a), int(b)
    print(a+b)

## n이 주어졌을 때, 1부터 n까지 합을 구하는 프로그램을 작성하시오.
num = input()
num = int(num)
number = 0
for i in  range(1,num+1):
    number += i
print(number)

## 각 테스트케이스마다 A+B를 한 줄에 하나씩 순서대로 출력한다.
import sys

num = sys.stdin.readline()
num = int(num)
for i in range(num):
    a, b = sys.stdin.readline().split()
    a, b = int(a), int(b)

    print(a+b)