//: [Previous](@previous)

import Foundation


public struct Queue<T> {
    public var data = [T?]()
    public var head = 0
    
    public var count:Int{
        return data.count - head
    }
    public mutating func enqueue(_ value:T) {
        self.data.append(value)
    }
    public mutating func dequeue() -> T? {
        guard head < data.count, let element = data[head] else {return nil}
        
        data[head] = nil
        head += 1
        
        let percentange = Double(head)/Double(data.count)
        if data.count > 50 && percentange > 0.25 {
            data.removeFirst(head)
            head = 0
        }
        return element
    }
}

var q = Queue<String>()
q.data                   // [] empty array

q.enqueue("Ada")
q.enqueue("Steve")
q.enqueue("Tim")
q.data             // [{Some "Ada"}, {Some "Steve"}, {Some "Tim"}]
q.data             // 3

q.dequeue()         // "Ada"
q.data             // [nil, {Some "Steve"}, {Some "Tim"}]
q.count             // 2

q.dequeue()         // "Steve"
q.data             // [nil, nil, {Some "Tim"}]
q.count             // 1

q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")
q.enqueue("Grace")

q.data             // [nil, nil, {Some "Tim"}, {Some "Grace"}]
q.count
q.dequeue()         // "Tim"
q.dequeue()
q.dequeue()
q.dequeue()
q.dequeue()
q.dequeue()
q.dequeue()
q.dequeue()         // "Tim"
q.dequeue()
q.dequeue()
q.dequeue()
q.dequeue()
q.dequeue()
q.dequeue()
q.dequeue()         // "Tim"
q.dequeue()
q.dequeue()
q.dequeue()
q.dequeue()
q.dequeue()
q.dequeue()
q.data             // [{Some "Grace"}]
q.count             // 1
