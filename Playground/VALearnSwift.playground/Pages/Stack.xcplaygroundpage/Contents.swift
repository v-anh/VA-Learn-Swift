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
