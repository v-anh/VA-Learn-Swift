//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)



//##MARK: - Basic Sort

/*
 SelectionSort
 
 Loop X from start to (end - 1) -> marked X at lowest -> loop from X to the end -> conpare with all remain -> if found the lower mark this as lowest -> if found the lowest swap lowest with X
 -> continute when X to the end
 
 - Performace: O(n^2)
 */
func selectionSort(A:[Int]) -> [Int] {
    guard A.count > 1 else {return A}
    var sortedA = A
    for x in 0..<sortedA.count-1 {
        var temp = x
        for y in x+1..<sortedA.count {
            if sortedA[y] < sortedA[temp] {
                temp = y
            }
        }
        if x != temp {
            sortedA.swapAt(x, temp)
        }
    }
    return sortedA
}


/*
 InsetionSort
 
 Pickup First (No need if using the same Array) -> Loop X from 1 (cause 0 already picked up) to end -> Loop Y from X to Start (0) -> if data X lower then data Y -> Swap
 Continute when X to the end
 
 A
 [6,5,4,3,2,1]
 
 X = 1, Y = X = 1, temp = 5
 [6,5|4,3,2,1]
 
 A[Y] < A[Y-1] -> A[Y] = A[Y-1] (5 -> 6), Temp = 5, Y = Y-1
 [6,6|4,3,2,1]
 
 A[Y] = Temp (6->5)
 [5,6|4,3,2,1]
 
 */
func insertionSort(A: inout [Int]) -> [Int] {
    guard A.count > 1 else {return A}
    for x in 1..<A.count {
        var y = x
        let temp = A[y]
        while y > 0 && temp < A[y-1] {
            A[y] = A[y-1]
            y -= 1
        }
        A[y] = temp
    }
    return A
}


func quicksortLomuto(A:inout [Int],low: Int, high: Int) {
    if low < high {
        let p = partitionLomuto(A:&A, low: low, high: high)
        quicksortLomuto(A:&A, low: low, high: p - 1)
        quicksortLomuto(A:&A, low: p + 1, high: high)
    }
}

///-> an other way to choose Partition https://nguyenvanhieu.vn/thuat-toan-sap-xep-quick-sort/
func partitionLomuto(A:inout [Int],low:Int,high:Int) -> Int {
    let pivot = A[high]
    
    var i = low
    for j in low..<high {
        if A[j] <= pivot {
            A.swapAt(i, j)
            print("swapAt(\(i), \(j)) then i += 1, i = \(i+1)")
            i += 1
            print(A)
            print("\n")
        }
    }
    (A[i], A[high]) = (A[high], A[i])
    print(A)
    return i
}

func main() {
    selectionSort(A: [10,9,8,7,6,5,4,3,2,1,0])
    var list = [10,9,8,7,6,5,4,3,2,1,0]
    insertionSort(A: &list)
    
    var list1 = [ 10, 0, 3, 9, 2, 14, 26, 27, 1, 5, 8, -1, 8 ]
    quicksortLomuto(A: &list1, low: 0, high: list1.count-1)
}

main()




