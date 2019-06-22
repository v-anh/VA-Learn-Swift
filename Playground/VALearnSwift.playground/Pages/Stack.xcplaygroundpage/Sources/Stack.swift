import Foundation

public class Node<T> {
    var data : T
    var next:Node<T>? = nil
    public init(data:T) {
        self.data = data
    }
}

public class LinkedListStack<T> {
    private var head:Node<T>?
    public init() {
    }
    public func push(data:T) {
        let newNode = Node(data: data)
        newNode.next = head
        head = newNode
    }
    
    public func pop() -> T? {
        guard let head = head else {return nil}
        
        let popData = head.data
        self.head = head.next
        return popData
    }
    
    public func peek() -> T? {
        guard let head = head else {return nil}
        return head.data
    }
}


