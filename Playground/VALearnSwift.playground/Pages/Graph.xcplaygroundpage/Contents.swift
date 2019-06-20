//: [Previous](@previous)

import Foundation
var str = "Hello, playground"

//: [Next](@next)

var graph = Graph()
str = str.trimmingCharacters(in: .whitespaces)
for (index,char) in str.enumerated() {
    graph.addVertex(key: String(char))
}

print(graph)

