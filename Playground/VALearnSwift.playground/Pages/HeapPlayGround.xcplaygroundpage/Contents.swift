//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)
public class Heap {
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
    
    func buildheap() {
        for index in (0..<count/2).reversed() {
            siftDown(at: index)
        }
    }
    
    func siftUp(at index:Int) {
        
    }
    
    func siftDown(at index:Int,until endIndex:Int) {
        let leftIndex = self.leftIndex(of: index)
        let rightIndex = leftIndex + 1
        var first = index
        if leftIndex < endIndex && element[leftIndex] < element[first] {
            first = leftIndex
        }
    }
    
}
