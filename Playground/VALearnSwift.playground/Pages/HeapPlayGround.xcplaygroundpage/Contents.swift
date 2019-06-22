//: [Previous](@previous)

import Foundation

var array = [10, 7, 2, 5, 1,4,5,6,77]
var a = Heap(array: array, sort: >)
print(a.nodes)
a.remove()
print(a.nodes)
a.insert(value: 88)
print(a.nodes)
