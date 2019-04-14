

class QueueNode<T> {
    var data : T
    var next:QueueNode<T>? = nil
    
    init(data:T) {
        self.data = data
    }
}

class MyQueue<T> {
    var head:QueueNode<T>? = nil
    var tail:QueueNode<T>? = nil
    
    init(data:T) {
        self.tail = QueueNode(data:data)
        self.head = tail
    }
    
    func add(item:T) {
        let node = QueueNode(data:item)
        if tail != nil {
            tail!.next = node
        }
        tail = node
        
        if head == nil {
            head = tail
        }
    }
    
    func remove() {
        guard let first = self.head else {
            print("error")
            return
        }
        
        head = first.next
        if head == nil {
            self.tail = nil
        }
    }
    
    
    func peek() -> T? {
        guard let first = self.head else {
            print("error")
            return nil
        }
        
        return first.data
    }
    
    var isEmpty :Bool {
        return self.head == nil
    }
}

var queue = MyQueue(data:10)


queue.add(item:3)
queue.add(item:1)
queue.add(item:2)
queue.add(item:4)
queue.add(item:5)

queue.peek()

queue.remove()

queue.peek()



