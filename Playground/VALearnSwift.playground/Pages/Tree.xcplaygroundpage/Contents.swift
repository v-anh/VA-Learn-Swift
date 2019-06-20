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


//Graph
//public class Edge {
//    var neighbor :Vertex
//    var weight: Int
//    init() {
//        neighbor = Vertex()
//        weight = 0
//    }
//}
//
//public class Vertex<T> {
//    var key:T?
//    var neighbor:[Edge]
//    init() {
//        neighbor = [Edge]()
//    }
//}
