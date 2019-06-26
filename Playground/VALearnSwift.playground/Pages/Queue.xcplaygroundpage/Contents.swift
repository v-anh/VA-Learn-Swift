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



class Node{
    var data:Int
    var next:Node?
    init(data:Int) {
        self.data = data
    }
}
class LinkedListQueue {
    var head:Node?
    var tail:Node?
    func enqueue(data:Int) {
        let node = Node(data: data)
        if head == nil {
            head = node
            tail = head
        }else{
            tail?.next = node
            tail = node
        }
    }
    
    func dequeue() -> Int? {
        guard let head = self.head else {return nil}
        let data = head.data
        self.head = head.next
        if self.head == nil {
            tail = nil
        }
        return data
    }
    
    func peek() -> Int? {
        guard let head = self.head else {return nil}
        let data = head.data
        return data
    }
}

var queue = LinkedListQueue()
queue.enqueue(data: 1)
queue.enqueue(data: 2)
queue.enqueue(data: 3)
queue.enqueue(data: 4)
queue.enqueue(data: 5)
queue.enqueue(data: 6)
queue.head?.data

queue.tail?.data
queue.dequeue()
queue.dequeue()
queue.dequeue()
queue.dequeue()
queue.dequeue()
queue.dequeue()
queue.dequeue()
queue.dequeue()

queue.head?.data

queue.tail?.data
queue.dequeue()
