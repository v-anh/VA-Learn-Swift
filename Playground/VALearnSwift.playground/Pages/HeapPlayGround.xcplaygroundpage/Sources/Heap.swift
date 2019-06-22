
import Foundation


public struct Heap<T> {
    public var nodes = [T]()
    
    private var orderCriteria:(T,T) -> Bool
    
    public init(array: [T],sort: @escaping (T,T) -> Bool) {
        self.orderCriteria = sort
        self.nodes = array
        self.buildHeap()
    }
    
    public mutating func remove() -> T? {
        guard !nodes.isEmpty else {return nil}
        if nodes.count == 1 {
            return nodes.removeLast()
        }else{
            let root = nodes[0]
            nodes[0] = nodes.removeLast()
            shiftDown(at: 0, until: nodes.count)
            return root
        }
    }
    
    @discardableResult public mutating func remove(at index:Int) -> T? {
        guard index < nodes.count else {return nil}
        let size = nodes.count - 1
        if index != size {
            nodes.swapAt(index, size)
            shiftDown(at: index, until: size)
            shiftUp(index: index)
        }
        return nodes.removeLast()
    }
    
    public mutating func insert(value:T) {
        self.nodes.append(value)
        self.shiftUp(index: nodes.count - 1)
    }
    
    public mutating func replace(value:T,at index:Int) {
        guard index < nodes.count else {return}
        remove(at: index)
        insert(value: value)
    }
    
    /*
     For any heap the elements at array indices n/2 to n-1 are the leaves of the tree. We can simply skip those leaves. We only have to process the other nodes, since they are parents with one or more children and therefore may be in the wrong order
     */
    internal mutating func buildHeap() {
        for index in (0..<nodes.count/2).reversed() {
            shiftDown(at: index, until: nodes.count)
        }
    }
    
    internal mutating func shiftUp(index:Int) {
        var childIndex = index
        let child = nodes[childIndex]
        var parentIndex = self.parentIndex(index: index)
        
        while childIndex > 0 && orderCriteria(child,nodes[parentIndex]) {
            nodes[childIndex] = nodes[parentIndex]
            childIndex = parentIndex
            parentIndex = self.parentIndex(index: childIndex)
        }
        nodes[childIndex] = child
    }
    
    
    internal mutating func shiftDown(at index:Int,until :Int) {
        guard index < nodes.count && index >= 0 else {return}
        let leftIndex = self.leftIndex(index: index)
        let rightIndex = self.rightIndex(index: index)
        var first = index
        if leftIndex < nodes.count && orderCriteria(nodes[leftIndex],nodes[index]) {
            first = leftIndex
        }
        if rightIndex < nodes.count && orderCriteria(nodes[rightIndex],nodes[index]) {
            first = rightIndex
        }
        if index == first {return}
        nodes.swapAt(index, first)
        shiftDown(at: first, until: nodes.count)
    }
    
    
    private func parentIndex(index:Int) -> Int {
        return (index - 1) / 2
    }
    private func leftIndex(index:Int) -> Int {
        return (index * 2) + 1
    }
    private func rightIndex(index:Int) -> Int {
        return (index * 2) + 2
    }
    
}
