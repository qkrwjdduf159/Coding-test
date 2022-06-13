def solution(arr1, arr2):
    answer = []
    for i in range(len(arr1)):
        var_list = []
        for j in range(len(arr2)):
            value = 0
            for k in range(len(arr2)):
                value += arr1[i][k]*arr2[k][j]
            var_list.append(value)
        answer.append(var_list)

    return answer

arr1 = [[1,4], [3,2], [4,1]]
arr2 = [[3,3], [3,3]]

arr1 = [[2,3,2],[4,2,4],[3,1,4]]
arr2 =[[5,4,3],[2,4,1],[3,1,1]]

solution(arr1,arr2)