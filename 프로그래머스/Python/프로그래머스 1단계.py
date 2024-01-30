# 선물을 직접 전하기 힘들 때 카카오톡 선물하기 기능을 이용해 축하 선물을 보낼 수 있습니다. 당신의 친구들이 이번 달까지 선물을 주고받은 기록을 바탕으로 다음 달에 누가 선물을 많이 받을지 예측하려고 합니다.

# 두 사람이 선물을 주고받은 기록이 있다면, 이번 달까지 두 사람 사이에 더 많은 선물을 준 사람이 다음 달에 선물을 하나 받습니다.
# 예를 들어 A가 B에게 선물을 5번 줬고, B가 A에게 선물을 3번 줬다면 다음 달엔 A가 B에게 선물을 하나 받습니다.
# 두 사람이 선물을 주고받은 기록이 하나도 없거나 주고받은 수가 같다면, 선물 지수가 더 큰 사람이 선물 지수가 더 작은 사람에게 선물을 하나 받습니다.
# 선물 지수는 이번 달까지 자신이 친구들에게 준 선물의 수에서 받은 선물의 수를 뺀 값입니다.
# 예를 들어 A가 친구들에게 준 선물이 3개고 받은 선물이 10개라면 A의 선물 지수는 -7입니다. B가 친구들에게 준 선물이 3개고 받은 선물이 2개라면 B의 선물 지수는 1입니다. 만약 A와 B가 선물을 주고받은 적이 없거나 정확히 같은 수로 선물을 주고받았다면, 다음 달엔 B가 A에게 선물을 하나 받습니다.
# 만약 두 사람의 선물 지수도 같다면 다음 달에 선물을 주고받지 않습니다.
# 위에서 설명한 규칙대로 다음 달에 선물을 주고받을 때, 당신은 선물을 가장 많이 받을 친구가 받을 선물의 수를 알고 싶습니다.

# 친구들의 이름을 담은 1차원 문자열 배열 friends 이번 달까지 친구들이 주고받은 선물 기록을 담은 1차원 문자열 배열 gifts가 매개변수로 주어집니다. 이때, 다음달에 가장 많은 선물을 받는 친구가 받을 선물의 수를 return 하도록 solution 함수를 완성해 주세요.
import pandas as pd

def solution(friends, gifts):
    
    ## 주고받은 선물 표로 나타냄
    data = pd.DataFrame(0, index = friends, columns = friends)    
    for give in gifts:
        a, b = give.split()
        data.loc[a,b] +=1
        
    ## 주고받은 선물의 선물 지수를 표로 표현
    sub_data = pd.DataFrame(0, index = data.index, columns = ['준 선물','받은 선물','선물 지수'])
    for i in data.index:
        sub_data.loc[i,'준 선물'] = sum(data.loc[i,:])
        sub_data.loc[i,'받은 선물'] = sum(data.loc[:,i])
        
    sub_data['선물 지수'] = sub_data['준 선물'] - sub_data['받은 선물']
    data_dict = {}
    for num in data.index:
        data_dict[num] = 0  
    ## 같은 개수를 주고받은 결과를 바탕으로 +1 해주기
    for person in data.index:
        index_list = data.loc[person,:]
        column_list = data.loc[:,person]
        
        for k in range(len(friends)):
            if data.loc[person, data.index[k]] > data.loc[data.index[k],person]:
                data_dict[person] += 0.5
            elif data.loc[person, data.index[k]] < data.loc[data.index[k],person]:
                data_dict[data.index[k]] += 0.5
            else:
                if sub_data.loc[data.index[k],'선물 지수'] > sub_data.loc[person,'선물 지수']:
                    data_dict[data.index[k]] += 0.5
                elif sub_data.loc[data.index[k],'선물 지수'] < sub_data.loc[person,'선물 지수']:
                    data_dict[person] += 0.5
                else:
                    pass
    return int(max(data_dict.values()))
            
# 배열 array의 i번째 숫자부터 j번째 숫자까지 자르고 정렬했을 때, k번째에 있는 수를 구하려 합니다.
# 예를 들어 array가 [1, 5, 2, 6, 3, 7, 4], i = 2, j = 5, k = 3이라면
# array의 2번째부터 5번째까지 자르면 [5, 2, 6, 3]입니다.
# 1에서 나온 배열을 정렬하면 [2, 3, 5, 6]입니다.
# 2에서 나온 배열의 3번째 숫자는 5입니다.
# 배열 array, [i, j, k]를 원소로 가진 2차원 배열 commands가 매개변수로 주어질 때, commands의 모든 원소에 대해 앞서 설명한 연산을 적용했을 때 나온 결과를 배열에 담아 return 하도록 solution 함수를 작성해주세요.
def solution(array, commands):
    answer = []
    for i in commands:
        sub_array = array[i[0]-1:i[1]]
        print(sub_array)
        num = sorted(sub_array)[i[2]-1]
        answer.append(num)
    return answer


# 문자열로 구성된 리스트 strings와, 정수 n이 주어졌을 때, 각 문자열의 인덱스 n번째 글자를 기준으로 오름차순 정렬하려 합니다.
# 예를 들어 strings가 ["sun", "bed", "car"]이고 n이 1이면 각 단어의 인덱스 1의 문자 "u", "e", "a"로 strings를 정렬합니다.
def solution(strings, n):
    
    strings = sorted(strings)
    answer = sorted(strings, key=lambda x:x[n])

    return answer