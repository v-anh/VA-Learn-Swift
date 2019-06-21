//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)
public struct Heap {
    var element:[Int]
    
    public init(array:[Int]) {
        self.element = array
        self.buildheap()
    }
    
    public var isEmpty:Bool {
        return element.isEmpty
    }
    
    public var count:Int {
        return element.count
    }
    
    public func peek() -> Int? {
        return element.first
    }
    
    func isRoot(_ index:Int) -> Bool {
        return index == 0
    }
    
    func leftIndex(of index:Int) -> Int {
        return (2 * index) + 1
    }
    
    func rightIndex(of index:Int) -> Int {
        return (2 * index) + 2
    }
    
    func parentIndex(of index:Int) -> Int {
        return (index - 1) / 2
    }
    
    internal mutating func shiftDown(_ index: Int) {
        shiftDown(at: index, until: element.count)
    }
    
    internal mutating func buildheap() {
        for index in (0..<count/2).reversed() {
            print(index)
            self.shiftDown(index)
        }
    }
    
    internal mutating func siftUp(at index:Int) {
        var childIndex = index
        let child = element[childIndex]
        var parentIndex = self.parentIndex(of: childIndex)
        while childIndex > 0 && child > element[parentIndex] {
            element[childIndex] = element[parentIndex]
            child = parentIndex
            parentIndex = self.parentIndex(of: childIndex)
        }
        element[childIndex] = child
    }
    
    internal mutating func shiftDown(at index:Int,until endIndex:Int) {
        let leftIndex = self.leftIndex(of: index)
        let rightIndex = leftIndex + 1
        var first = index
        if leftIndex < endIndex && element[leftIndex] > element[first] {
            first = leftIndex
        }
        if rightIndex < endIndex && element[rightIndex] > element[first] {
            first = rightIndex
        }

        if first == index {return}
        element.swapAt(index, first)
        shiftDown(at: first, until: endIndex)
    }
}
print([10, 7, 2, 5, 1, 16])
var a = Heap(array: [10, 7, 2, 5, 1, 16])
print(a.element)
