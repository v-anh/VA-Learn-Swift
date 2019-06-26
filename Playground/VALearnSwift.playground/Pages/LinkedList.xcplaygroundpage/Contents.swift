

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

class Node {
    var data:Int
    var next:Node?
    init(data:Int) {
        self.data = data
    }
}
//Head
//previous -> current -> next
//NULL

class LinkedList{
    var head:Node?
    init() {
    }
    
    func addNode(data:Int) {
        let newNode = Node(data: data)
        newNode.next = head
        head = newNode
    }
    
    func reverseLinkedList()  {
        guard head != nil else {
            return
        }
        var current = head
        var previous:Node? = nil
        while current != nil {
            let temp = current?.next
            current?.next = previous
            previous = current
            current = temp
        }
        self.head = previous
    }
    
    func printList() {
        var current = self.head
        var dataString = ""
        while current != nil {
            dataString.append(" \( current?.data ?? 0)")
            current = current!.next
        }
        print(dataString)
    }
}

func reverseLinkedList(with head:Node?) -> Node? {
    guard head != nil else {
        return nil
    }
    if head?.next == nil {
        return head
    }
    
    var current = head
    var pre:Node? = nil
    while current != nil {
        let temp = current?.next
        current?.next = pre
        
        pre = current
        current = temp
    }
    return pre
}

var linkedList = LinkedList()
linkedList.addNode(data: 1)
linkedList.addNode(data: 2)
linkedList.addNode(data: 3)
linkedList.addNode(data: 4)
linkedList.addNode(data: 5)
linkedList.addNode(data: 6)
linkedList.printList()
linkedList.reverseLinkedList()
linkedList.printList()

var current = reverseLinkedList(with: linkedList.head)
var dataString = ""
while current != nil {
    dataString.append(" \( current?.data ?? 0)")
    current = current!.next
}
print(dataString)

class Queue {
    var head:Node?
    var tail:Node?
    init() {
        head = nil
        tail = nil
    }
    
    func enQueue(data:Int) {
        let newNode = Node(data: data)
        if tail == nil {
            tail = newNode
            head = tail
        }else{
            tail!.next = newNode
            tail = newNode
        }
    }
    
    func dequeue() -> Int? {
        guard let head = head else {
            return nil
        }
        let temp = head.data
        self.head = head.next
        if self.head == nil {
            tail = nil
        }
        return temp
    }
}
