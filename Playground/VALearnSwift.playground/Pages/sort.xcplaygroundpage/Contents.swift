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
func insertionSort(A:[Int]) -> [Int] {
    guard A.count > 1 else {return A}
    var sortedA = A
    for x in 1..<sortedA.count {
        var y = x
        var temp = sortedA[y]
        while y > 0 && temp < sortedA[y-1] {
            sortedA[y] = sortedA[y-1]
            y -= 1
        }
        sortedA[y] = temp
    }
    return sortedA
}

func main() {
    selectionSort(A: [10,9,8,7,6,5,4,3,2,1,0])
    insertionSort(A: [10,9,8,7,6,5,4,3,2,1,0])
}

main()




