import Foundation


class BinarySearchTree {
    private(set) public var value:Int
    private(set) public var parent:BinarySearchTree?
    private(set) public var left: BinarySearchTree?
    private(set) public var right: BinarySearchTree?
    
    public convenience init(array: [Int]) {
        precondition(array.count > 0)
        self.init(value: array.first!)
        for v in array.dropFirst() {
            insert(value: v)
        }
    }
    
    public init(value: Int) {
        self.value = value
    }
    
    public var isRoot: Bool {
        return parent == nil
    }
    
    public var isLeaf: Bool {
        return left == nil && right == nil
    }
    
    public var isLeftChild: Bool {
        return parent?.left === self
    }
    
    public var isRightChild: Bool {
        return parent?.right === self
    }
    
    public var hasLeftChild: Bool {
        return left != nil
    }
    
    public var hasRightChild: Bool {
        return right != nil
    }
    
    public var hasAnyChild: Bool {
        return hasLeftChild || hasRightChild
    }
    
    public var hasBothChildren: Bool {
        return hasLeftChild && hasRightChild
    }
    
    public var count: Int {
        return (left?.count ?? 0) + 1 + (right?.count ?? 0)
    }
    
    func insert(value:Int) {
        if value < self.value {
            if let left = self.left {
                left.insert(value: value)
            }else{
                let left = BinarySearchTree(value: value)
                self.left = left
            }
        }else{
            if let right = self.right {
                right.insert(value: value)
            }else{
                let right = BinarySearchTree(value: value)
                self.right = right
            }
        }
    }
    
    func search(value:Int) -> BinarySearchTree? {
        if self.value < value {
            return self.left?.search(value: value)
        }else if value > self.value {
            return self.right?.search(value: value)
        }else {
            return self
        }
    }
    
    func travelseInOrder(process:(Int) -> Void) {
        self.left?.travelseInOrder(process: process)
        process(value)
        self.right?.travelseInOrder(process: process)
    }
    
    public func traversePreOrder(process: (Int) -> Void) {
        process(value)
        left?.traversePreOrder(process: process)
        right?.traversePreOrder(process: process)
    }
    
    public func traversePostOrder(process: (Int) -> Void) {
        left?.traversePostOrder(process: process)
        right?.traversePostOrder(process: process)
        process(value)
    }
}

extension BinarySearchTree: CustomStringConvertible {
    public var description: String {
        var s = ""
        if let left = left {
            s += "(\(left.description)) <- "
        }
        s += "\(value)"
        if let right = right {
            s += " -> (\(right.description))"
        }
        return s
    }
    
}

let tree = BinarySearchTree(array: [7, 2, 5, 10, 9, 1])
print(tree)
print("===travelseInOrder===")
tree.travelseInOrder { (value) in
    print(value)
}
print("===traversePreOrder===")
tree.traversePreOrder { (value) in
    print(value)
}
print("===traversePostOrder===")
tree.traversePostOrder { (value) in
    print(value)
}

let tree1 = BinarySearchTree(array: [1,2,3,4,5,6,7,8])

print(tree1)

//https://github.com/raywenderlich/swift-algorithm-club/tree/master/AVL%20Tree
//For fix the unbalance tree 
