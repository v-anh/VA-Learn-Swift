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


func mergeSort(array: [Int]) -> [Int] {
    guard array.count > 1 else {return array}
    let mid = array.count/2
    let left = mergeSort(array: Array(array[0..<mid]))
    let right = mergeSort(array: Array(array[mid..<array.count]))
    return merge(left: left, right: right)
}

func merge(left:[Int],right:[Int]) -> [Int] {
    var leftIndex = 0
    var rightIndex = 0
    
    var orderedPile = [Int]()
    orderedPile.reserveCapacity(left.count + right.count)
    
    while leftIndex < left.count && rightIndex < right.count  {
        if left[leftIndex] < right[rightIndex] {
            orderedPile.append(left[leftIndex])
            leftIndex += 1
        }else if left[leftIndex] > right[rightIndex] {
            orderedPile.append(right[rightIndex])
            rightIndex += 1
        }else {
            orderedPile.append(left[leftIndex])
            orderedPile.append(right[rightIndex])
            leftIndex += 1
            rightIndex += 1
        }
    }
    
    while leftIndex < left.count {
        orderedPile.append(left[leftIndex])
        leftIndex += 1
    }
    
    while rightIndex < right.count {
        orderedPile.append(right[rightIndex])
        rightIndex += 1
    }
    return orderedPile
}


func main() {
//    selectionSort(A: [10,9,8,7,6,5,4,3,2,1,0])
    var list = [10,9,8,7,6,5,4,3,2,1,0]
//    insertionSort(A: &list)
    let message = list.map { String($0) }.joined(separator: " ")
    print(message)
//    var list1 = [ 10, 0, 3, 9, 2, 14, 26, 27, 1, 5, 8, -1, 8 ]
//    quicksortLomuto(A: &list1, low: 0, high: list1.count-1)
    
//    mergeSort(array: [10,9,8,7,6,5,4,3,2,1,0])
}

//main()

func reverseArray(a: [Int]) -> [Int] {
    var left = 0
    var right = a.count-1
    var result = a
    while(left <= right) {
        if left == right {
            break
        }else{
            result[left] = a[right]
            result[right] = a[left]
        }
        left+=1
        right-=1
    }
    print(result.map{String($0)}.joined(separator:" "))
    return result
}

let res = reverseArray(a: [1,4,3,2])



func mergrSortNew(array:[Int]) -> [Int] {
    guard array.count > 1 else { return array }
    let divide = array.count/2
    let left = mergrSortNew(array: Array(array[0..<divide]))
    let right = mergrSortNew(array: Array(array[divide..<array.count]))
    return mergeNew(left: left, right: right)
}

func mergeNew(left:[Int],right:[Int]) -> [Int] {
    var result = [Int]()
    result.reserveCapacity(left.count+right.count)
    var leftIndex = 0
    var rightIndex = 0
    while leftIndex < left.count && rightIndex < right.count {
        if left[leftIndex] < right[rightIndex] {
            result.append(left[leftIndex])
            leftIndex += 1
        }else if left[leftIndex] > right[rightIndex] {
            result.append(right[rightIndex])
            rightIndex += 1
        }else{
            result.append(left[leftIndex])
            result.append(right[rightIndex])
            leftIndex += 1
            rightIndex += 1
        }
    }
    while leftIndex < left.count {
        result.append(left[leftIndex])
        leftIndex += 1
    }
    while rightIndex < right.count {
        result.append(right[rightIndex])
        rightIndex += 1
    }
    return result
}

print(mergrSortNew(array: [2, 1, 5, 4, 9]))


func quickSortNew(array:[Int]) -> [Int] {
    guard array.count > 1 else { return array }
    let pivot = array[array.count/2]
    let left = array.filter({$0 < pivot})
    let mindle = array.filter({$0 == pivot})
    let right = array.filter({$0 > pivot})
    
    return quickSortNew(array: left) + mindle + quickSortNew(array: right)
}

func quickSortNewLumoto(array: inout [Int],low:Int,high:Int) {
    if low < high {
        let pi = partitionLumoto(array: &array, low: low, high: high)
        quickSortNewLumoto(array: &array, low: low, high: pi-1)
        quickSortNewLumoto(array: &array, low: pi+1, high:high)
    }
}

func partitionLumoto(array:inout [Int],low:Int,high:Int) -> Int {
    let pivot = array[high]
    var i = low
    for j in low..<high {
        if array[j] <= pivot {
            (array[i], array[j]) = (array[j],array[i])
            i += 1
        }
    }
    
    (array[i], array[high]) = (array[high],array[i])
    return i
}

print(quickSortNew(array: [ 10, 0, 3, 9, 2, 14, 26, 27, 1, 5, 8, -1, 8 ]))
var array = [ 10, 0, 3, 9, 2, 14, 26, 27, 1, 5, 8, -1, 8 ]
quickSortNewLumoto(array: &array, low: 0, high: array.count-1)
print(array)
func mergedTwoArray(a:[Int],b:[Int]) -> [Int] {
    var buffer = [Int]()
    buffer.reserveCapacity(a.count + b.count)
    var indexA = 0
    var indexB = 0
    while indexA < a.count && indexB < b.count  {
        if a[indexA] < b[indexB] {
            buffer.append(a[indexA])
            indexA += 1
        }else if a[indexA] > b[indexB] {
            buffer.append(b[indexB])
            indexB += 1
        }else{
            buffer.append(a[indexA])
            indexA += 1
            buffer.append(b[indexB])
            indexB += 1
        }
    }
    while indexA < a.count {
        buffer.append(a[indexA])
        indexA += 1
    }
    while indexB < b.count {
        buffer.append(b[indexB])
        indexB += 1
    }
    return buffer
}


mergedTwoArray(a: [3,6,7,8], b: [1,2,3,4,5])
