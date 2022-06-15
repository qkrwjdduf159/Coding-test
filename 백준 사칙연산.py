### 1. Hello World!를 출력하시오.
print('Hello World!')

### 2. 두 줄에 걸쳐 "강한친구 대한육군"을 한 줄에 한 번씩 출력한다.
print('강한친구 대한육군')
print('강한친구 대한육군')

### 3. 고양이를 출력한다.
print("\\    /\\\n )  ( \')\n(  /  )\n \\(__)|")

### 4. 개를 출력한다.
print('|\\_/|\n|q p|   /}\n( 0 )"""\\\n|"^"`    |\n||_/=\\\\__|')

### 5. 두 정수 A와 B를 입력받은 다음, A+B를 출력하는 프로그램을 작성하시오.
A,B = input().split(' ')
int(A) + int(B)


### 6. 두 정수 A와 B를 입력받은 다음, A-B를 출력하는 프로그램을 작성하시오.
a, b = map(int, input().split())
if (int(a)>0)&(int(b)<10):
    print(int(a) - int(b))

### 7. 두 정수 A와 B를 입력받은 다음, A×B를 출력하는 프로그램을 작성하시오.
a, b = map(int, input().split())
print(a*b)

### 8. 두 정수 A와 B를 입력받은 다음, A/B를 출력하는 프로그램을 작성하시오.
a, b = map(int, input().split())
print(a/b)

### 9. 두 자연수 A와 B가 주어진다. 이때, A+B, A-B, A*B, A/B(몫), A%B(나머지)를 출력하는 프로그램을 작성하시오. 
a, b = map(int, input().split())
val_list = [a+b, a-b, a*b, a//b, a%2]
for i in val_list:
    print(i)
print(a+b)
print(a-b)
print(a*b)
print(a//b)
print(a%2)
# val_list = [a+b, a-b, a*b, a//b, a%2]
# for i in val_list:
#     print(i)

a, b = input().split()

a = int(a)
b = int(b)

print(a+b)
print(a-b)
print(a*b)
print(a//b)
print(a%b) # --> 이 문제는 위에꺼는 왜 틀렸고 밑에꺼는 왜 맞았는지 모르겠다...

# 10. 준하는 사이트에 회원가입을 하다가 joonas라는 아이디가 이미 존재하는 것을 보고 놀랐다. 준하는 놀람을 ??!로 표현한다. 준하가 가입하려고 하는 사이트에 이미 존재하는 아이디가 주어졌을 때, 놀람을 표현하는 프로그램을 작성하시오.
name = input()
print(name + '??!')

# 11. ICPC Bangkok Regional에 참가하기 위해 수완나품 국제공항에 막 도착한 팀 레드시프트 일행은 눈을 믿을 수 없었다. 공항의 대형 스크린에 올해가 2562년이라고 적혀 있던 것이었다.
# 불교 국가인 태국은 불멸기원(佛滅紀元), 즉 석가모니가 열반한 해를 기준으로 연도를 세는 불기를 사용한다. 반면, 우리나라는 서기 연도를 사용하고 있다. 불기 연도가 주어질 때 이를 서기 연도로 바꿔 주는 프로그램을 작성하시오.
year = input()
print(int(year) - (2541-1998))

# 12. 
# (A+B)%C는 ((A%C) + (B%C))%C 와 같을까?
# (A×B)%C는 ((A%C) × (B%C))%C 와 같을까?
# 세 수 A, B, C가 주어졌을 때, 위의 네 가지 값을 구하는 프로그램을 작성하시오.
A, B, C = input().split()
A, B, C = int(A), int(B), int(C)
print((A+B)%C)
print(((A%C)+(B%C))%C)
print((A*B)%C)
print(((A%C)*(B%C))%C)

# 13. (세 자리 수) × (세 자리 수)는 다음과 같은 과정을 통하여 이루어진다.
# (1)과 (2)위치에 들어갈 세 자리 자연수가 주어질 때 (3), (4), (5), (6)위치에 들어갈 값을 구하는 프로그램을 작성하시오.
A = input()
B = input()
A = int(A)
for i in range(len(B)-1,-1,-1):
    print(A * int(B[i]))
print(A*int(B))