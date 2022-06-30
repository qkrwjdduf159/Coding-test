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

##  자연수 N이 주어졌을 때, 1부터 N까지 한 줄에 하나씩 출력하는 프로그램을 작성하시오.
a = input()
a = int(a)
for i in range(a):
    print(i+1)

## 자연수 N이 주어졌을 때, N부터 1까지 한 줄에 하나씩 출력하는 프로그램을 작성하시오.
a = input()
a = int(a)
for i in range(a):
    print(a - i)

## 두 정수 A와 B를 입력받은 다음, A+B를 출력하는 프로그램을 작성하시오.
a = input()
a = int(a)
for i in range(a):
    a, b = input().split()
    a, b = int(a), int(b)
    print(f'Case #{i+1}: {a+b}')

## 두 정수 A와 B를 입력받은 다음, A+B를 출력하는 프로그램을 작성하시오.
a = input()
a = int(a)
for i in range(a):
    a, b = input().split()
    a, b = int(a), int(b)
    print(f'Case #{i+1}: {a} + {b} = {a+b}')

## 첫째 줄에는 별 1개, 둘째 줄에는 별 2개, N번째 줄에는 별 N개를 찍는 문제
a = int(input())
for i in range(1,a+1):
    print('*' * i)

## 첫째 줄에는 별 1개, 둘째 줄에는 별 2개, N번째 줄에는 별 N개를 찍는 문제
## 하지만, 오른쪽을 기준으로 정렬한 별(예제 참고)을 출력하시오.첫째 줄에는 별 1개, 둘째 줄에는 별 2개, N번째 줄에는 별 N개를 찍는 문제
## 하지만, 오른쪽을 기준으로 정렬한 별(예제 참고)을 출력하시오.
a = int(input())
for i in range(a):
    print(' ' *(a-i-1)+'*'*(i+1))

## 정수 N개로 이루어진 수열 A와 정수 X가 주어진다. 이때, A에서 X보다 작은 수를 모두 출력하는 프로그램을 작성하시오.
a, b = input().split()
a, b = int(a), int(b)
seq = input()
seq = seq.split()
answer = []
for i in seq:
    if int(i) < b:
        print(int(i), end = ' ')

## 두 정수 A와 B를 입력받은 다음, A+B를 출력하는 프로그램을 작성하시오.
while 1:
    a, b = input().split()
    a, b = int(a), int(b)
    if ((a==0) & (b==0)):
        break
    else:
        print(a+b)

# 두 정수 A와 B를 입력받은 다음, A+B를 출력하는 프로그램을 작성하시오.
while 1:
    try:
        a, b = input().split()
        a, b = int(a), int(b)
        print(a + b)
    except:
        break
#0보다 크거나 같고, 99보다 작거나 같은 정수가 주어질 때 다음과 같은 연산을 할 수 있다. 먼저 주어진 수가 10보다 작다면 앞에 0을 붙여 두 자리 수로 만들고, 각 자리의 숫자를 더한다. 
#그 다음, 주어진 수의 가장 오른쪽 자리 수와 앞에서 구한 합의 가장 오른쪽 자리 수를 이어 붙이면 새로운 수를 만들 수 있다. 다음 예를 보자.
#26부터 시작한다. 2+6 = 8이다. 새로운 수는 68이다. 6+8 = 14이다. 새로운 수는 84이다. 8+4 = 12이다. 새로운 수는 42이다. 4+2 = 6이다. 새로운 수는 26이다.
#위의 예는 4번만에 원래 수로 돌아올 수 있다. 따라서 26의 사이클의 길이는 4이다.
#N이 주어졌을 때, N의 사이클의 길이를 구하는 프로그램을 작성하시오.1
a = input()
num = 0
while a != b:
    if int(a) < 10:
        a = a+'0'
    