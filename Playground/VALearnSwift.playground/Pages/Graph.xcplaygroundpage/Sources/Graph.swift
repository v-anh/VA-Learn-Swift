import Foundation


public class Vertex {
    public var key:String?
    public var neighbor:[Edge]
    
    public init() {
        self.neighbor = [Edge]()
    }
}


public class Edge {
    public var neighbor:Vertex
    public var weight:Int
    public init() {
        weight = 0
        self.neighbor = Vertex()
    }
}

public class Graph {
    private var canvas:[Vertex]
    public var isDirected:Bool
    
    public init() {
        canvas = [Vertex]()
        isDirected = true
    }
    
    public func addVertex(key:String) -> Vertex {
        let child = Vertex()
        child.key = key
        
        canvas.append(child)
        return child
    }
    
    public func addEdge(source:Vertex,neighbor:Vertex,weight:Int)  {
        let newEdge = Edge()
        newEdge.weight = weight
        newEdge.neighbor = neighbor
        source.neighbor.append(newEdge)
        
        if isDirected == false {
            let reverseEdge = Edge()
            reverseEdge.weight = weight
            reverseEdge.neighbor = source
            neighbor.neighbor.append(reverseEdge)
        }
    }
}


