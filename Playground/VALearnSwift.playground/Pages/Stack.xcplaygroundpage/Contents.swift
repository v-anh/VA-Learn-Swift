//: [Previous](@previous)

import Foundation

public struct Stack<T> {
    private var data = [T]()
    public init() {
    }
    public mutating func push(data:T) {
        self.data.append(data)
    }
    
    public mutating func pop() -> T? {
        return data.popLast()
    }
    
    public mutating func peek() -> T? {
        return data.last
    }
}



var stack = Stack<Int>()
stack.push(data: 3)
stack.push(data: 5)
stack.push(data: 6)
stack.push(data: 7)
stack.push(data: 8)
stack.pop()
stack.peek()



class Node {
    var data:Int
    var next:Node?
    init(data:Int) {
        self.data = data
    }
}
class LinkedListStack {
    var head:Node?
    
    func push(data:Int) {
        let node = Node(data: data)
        node.next = head
        head = node
    }
    func pop() -> Int? {
        guard let head = self.head else {return nil}
        var data = head.data
        self.head = head.next
        return data
    }
}
var stack1 = LinkedListStack()
stack1.push(data: 3)
stack1.push(data: 5)
stack1.push(data: 6)
stack1.push(data: 7)
stack1.push(data: 8)
stack1.pop()
stack1.pop()
stack1.pop()
