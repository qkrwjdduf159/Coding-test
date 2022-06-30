## N개의 정수가 주어진다. 이때, 최솟값과 최댓값을 구하는 프로그램을 작성하시오.
a = int(input())
input_list = input().split()
input_list = [int(i) for i in input_list]
print(min(input_list),max(input_list))


## 9개의 서로 다른 자연수가 주어질 때, 이들 중 최댓값을 찾고 그 최댓값이 몇 번째 수인지를 구하는 프로그램을 작성하시오.
# 예를 들어, 서로 다른 9개의 자연수
# 3, 29, 38, 12, 57, 74, 40, 85, 61
# 이 주어지면, 이들 중 최댓값은 85이고, 이 값은 8번째 수이다.
input_list = []
while 1:
    try:
        a = int(input())
        input_list.append(a)
    except:
        break
print(max(input_list))
print(input_list.index(max(input_list))+1)

## 세 개의 자연수 A, B, C가 주어질 때 A × B × C를 계산한 결과에 0부터 9까지 각각의 숫자가 몇 번씩 쓰였는지를 구하는 프로그램을 작성하시오.
## 예를 들어 A = 150, B = 266, C = 427 이라면 A × B × C = 150 × 266 × 427 = 17037300 이 되고, 계산한 결과 17037300 에는 0이 3번, 1이 1번, 3이 2번, 7이 2번 쓰였다.
input_list = []
A = int(input())
B = int(input())
C = int(input())
final_value = str(A * B * C)
for i in range(10):
    print(final_value.count(str(i)))

## 두 자연수 A와 B가 있을 때, A%B는 A를 B로 나눈 나머지 이다. 예를 들어, 7, 14, 27, 38을 3으로 나눈 나머지는 1, 2, 0, 2이다. 
## 수 10개를 입력받은 뒤, 이를 42로 나눈 나머지를 구한다. 그 다음 서로 다른 값이 몇 개 있는지 출력하는 프로그램을 작성하시오.
나머지_리스트 = []
while 1:
    try:
        a = int(input())
        나머지 = a%42
        if 나머지 not in 나머지_리스트:
            나머지_리스트.append(나머지)
    except:
        break
print(len(나머지_리스트))
    
## 세준이는 기말고사를 망쳤다. 세준이는 점수를 조작해서 집에 가져가기로 했다. 일단 세준이는 자기 점수 중에 최댓값을 골랐다. 이 값을 M이라고 한다. 그리고 나서 모든 점수를 점수/M*100으로 고쳤다.
## 예를 들어, 세준이의 최고점이 70이고, 수학점수가 50이었으면 수학점수는 50/70*100이 되어 71.43점이 된다.
## 세준이의 성적을 위의 방법대로 새로 계산했을 때, 새로운 평균을 구하는 프로그램을 작성하시오.
a = int(input())
score = input().split()
score = [int(i) for i in score]
num = 0
for i in score:
    i = i/max(score) *100
    num += i
print(num/a)

## "OOXXOXXOOO"와 같은 OX퀴즈의 결과가 있다. O는 문제를 맞은 것이고, X는 문제를 틀린 것이다. 문제를 맞은 경우 그 문제의 점수는 그 문제까지 연속된 O의 개수가 된다. 예를 들어, 10번 문제의 점수는 3이 된다.
## "OOXXOXXOOO"의 점수는 1+2+0+0+1+0+0+1+2+3 = 10점이다.
## OX퀴즈의 결과가 주어졌을 때, 점수를 구하는 프로그램을 작성하시오.
a = int(input())
for i in range(a):
    input_case = list(input())
    for i in range(len(input_case)):
        if ((i==0) & (input_case[i] == 'O')):
            input_case[i] = '1'
        elif((i==0) & (input_case[i] == 'X')):
            input_case[i] = '0'
        else:
            if input_case[i] == 'X':
                input_case[i] = '0'
            elif ((input_case[i] == 'O') & (input_case[i-1] == '0')):
                input_case[i] = '1'
            else:
                if input_case[i-1] != '0':
                    input_case[i] = str(int(input_case[i-1]) + 1)
    b = 0
    for i in input_case:
        b += int(i)
    input_case
    print(b)

## 대학생 새내기들의 90%는 자신이 반에서 평균은 넘는다고 생각한다. 당신은 그들에게 슬픈 진실을 알려줘야 한다.
a = int(input())
for i in range(a):
    information = input().split()
    information = [int(i) for i in information]
    mean_value = sum(information[1:])/information[0]
    over_value = 0
    for i in range(information[0]):
        if mean_value < information[i+1]:
            over_value += 1
        else:
            pass
    print("{:.3f}%".format(round((over_value/information[0]) * 100, 3)))