import Foundation


class Node {
    var name:String
    var children:[Node]? = nil
    
    init(name:String) {
        self.name = name
    }
}


class Tree {
    var root:Node
    
    init(root:Node) {
        self.root = root
    }
}

sqrt(3.0)
