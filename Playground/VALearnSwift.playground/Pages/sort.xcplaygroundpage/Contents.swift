


func bubbleSort(A:[Int]) -> [Int] {
    var sortedArray = A
    for i in 0..<sortedArray.count {
        for j in stride(from: sortedArray.count-1, to: i, by: -1){
            if sortedArray[j] < sortedArray[j-1]{
                sortedArray.swapAt(j, j-1)
            }
        }
    }
    return sortedArray
}

bubbleSort(A: [15,10,2,20,10,5,25,35,22,30])





