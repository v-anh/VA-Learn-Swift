


/*
 One Away: There are three types of edits that can be performed on strings: insert a character, remove a character, or replace a character. Given two strings, write a function to check if they are one edit (or zero edits) away.
 EXAMPLE
 pale, ple -> true
 pales, pale -> true
 pale, bale -> true
 pale, bae -> false
 */


func oneEdited(first:String,second:String) -> Bool {
    if first.count == second.count {
        return oneEditedReplace(first: first, second: second)
    }else if (first.count + 1 == second.count) {
        return oneEditedInsert(first: first, second: second)
    }else if (first.count - 1 == second.count) {
        return oneEditedInsert(first: second, second: first)
    }
    return false
}

func oneEditedReplace(first:String,second:String) -> Bool {
    var foundDiff = false
    for i in 0..<first.count {
        let index = first.index(first.startIndex, offsetBy: i)
        if first[index] != second[index] {
            if foundDiff {
                return false
            }
            foundDiff = true
        }
    }
    return true
}

func oneEditedInsert(first:String,second:String) -> Bool {
    var index1 = 0
    var index2 = 0
    while (index1 < first.count && index2 < second.count) {
        let char1 = first[first.index(first.startIndex, offsetBy: index1)]
        let char2 = second[second.index(second.startIndex, offsetBy: index2)]
        if char1 != char2 {
            if index1 != index2 {
                return false
            }
            index2 += 1
        }else{
            index1 += 1
            index2 += 1
        }
        
    }
    return true
}



oneEdited(first: "apple", second: "apaled")



/*
 String Compression: Implement a method to perform basic string compression using the counts of repeated characters. For example, the string aabcccccaaa would become a2blc5a3. If the "compressed" string would not become smaller than the original string, your method should return
 the original string. You can assume the string has only uppercase and lowercase letters (a - z).
 */

func compress(input:String) -> String {
    if input.isEmpty {
        return input
    }
    var current = input.first!
    var compress = ""
    var count = 1
    for i in 1..<input.count {
        
        let index = input[input.index(input.startIndex, offsetBy: i)]
        if index != current {
            compress.append("\(current)\(count)")
            count = 1
            current = index
        }else{
            count += 1
            
        }
        if i >= input.count-1 {
            compress.append("\(index)\(count)")
        }
    }
    
    return compress
}

func compress2(input:String) -> String {
    if input.isEmpty {
        return input
    }
    
    var temp = input.first!
    var result = String(temp)
    var count = 1

    for i in 1..<input.count {
        let index = input[input.index(input.startIndex, offsetBy: i)]
        if index == temp {
            count += 1
        }else {
            result += "\(count)\(index)"
            count = 1
            temp = index
        }
        
        if i >= (input.count - 1) {
            result += "\(count)"
        }
        
    }
    return result
}


func plus(left:String,right:String) -> String {
    var result = ""
    if left.count > right.count {
        result = left
    }else{
        result = right
    }
    
    var temp = 0
    for i in 0..<result.count {
        var indexResult = result.index(result.startIndex, offsetBy: (result.count-1) - i)
        var sum = 0
        if i < left.count && i < right.count {
            var indexLong = left[left.index(left.startIndex, offsetBy: (left.count-1) - i)]
            var indexShort = right[right.index(right.startIndex, offsetBy: (right.count-1) - i)]
            sum = Int(String(indexLong))! + Int(String(indexShort))! + temp

        }else{
            sum = temp + Int(String(result[indexResult]))!
        }
        
        if sum >= 10 {
            sum = (sum - 10)
            temp = 1
        }else{
            temp = 0
        }
        
        result.replaceSubrange(indexResult...indexResult, with: String(sum))
    }
    if temp > 0 {
        result.insert("1", at: result.startIndex)
    }
    
    return result
}

compress(input: "aabbbbcccccccdc")
compress2(input: "aabbbbcccccccdc")
plus(left: "999999999", right: "1114")
999999999+1114

//34339998
//----1114
//---41112
/*
 [1,2,3,4]
 |5,6,7,8|
 |1,2,3,4|
 |5,6,7,8|
 */
var a = [[1,2,3,4],[5,6,7,8],[9,10,11,12],[13,14,15,16]]


func rotate90(matrix: inout [[Int]]) -> Bool {
    if matrix.count == 0 || matrix.count != matrix[0].count {
        return false
    }
    
    
    print("input ------------------ ")
    for a in matrix {
        print(a)
    }
    let n = matrix.count
    for layer in 0..<n/2 {
        let start = layer
        let end = n - 1 - layer
        for i in start..<end {
            let offset = i - start
            let temp = matrix[start][i]
            //left -> top
            matrix[start][i] = matrix[end-offset][start]
            
            //bot -> left
            matrix[end-offset][start] = matrix[end][end-offset]

            //right -> bot
            matrix[end][end-offset] = matrix[i][end]

            //top -> right
            matrix[i][end] = temp
        }
    }
    print("output ------------------ ")
    for a in matrix {
        print(a)
    }
    return true
}

rotate90(matrix: &a)



class StackUsingArray {
    private var stackArray :[Int]
    
    init() {
        stackArray = [Int]()
    }
    
    init(val:Int) {
        stackArray = [Int]()
        push(val: val)
    }
    
    func push(val:Int) {
        stackArray.append(val)
    }
    
    func pop() -> Int? {
        return stackArray.first
    }
    
    func remove() {
        if stackArray.count > 0 {
            stackArray.remove(at: 0)
        }
    }
}

/*
 Stack Min: How would you design a stack which, in addition to push and pop, has a function min
 which returns the minimum element? Push, pop and min should all operate in 0(1) time.
 */


class Node<T>{
    var data :T
    var next:Node<T>? = nil
    init(data:T) {
        self.data = data
    }
}
class Stack<T> {
    private var head:Node<T>? = nil
    private var tail:Node<T>? = nil
    
    func push(item:T) {
        let node = Node(data:item)
        if tail != nil {
            print("tail != nil")
            node.next = tail
        }
        tail = node
        
        if head == nil {
            head = tail
        }
    }
    
    func pop() -> T? {
        guard let last = self.tail else {
            print("error")
            return nil
        }
        
        tail = last.next
        if tail == nil {
            print("awdawd")
            self.head = nil
        }
        
        return last.data
    }
    
    
    func peek() -> T? {
        guard let last = self.tail else {
            print("error")
            return nil
        }
        
        return last.data
    }
    
    var isEmpty :Bool {
        return self.head == nil
    }
}

class NodeMin{
    var val :Int
    var min :Int
    var next:NodeMin? = nil
    init(val:Int,min:Int) {
        self.val = val
        self.min = min
    }
}


class StackMin:Stack<NodeMin>{
    
    func push(val :Int) {
        let newMin = min(self.getMin(), val)
        super.push(item: NodeMin(val: val, min: newMin))
    }
    
    func getMin() -> Int {
        if self.isEmpty {
            return Int.max
        }else {
            return peek()?.min ?? Int.max
        }
    }
}


var stackMin = StackMin()
stackMin.push(val: 4)
stackMin.peek()?.min
stackMin.push(val: 8)
stackMin.peek()?.min
stackMin.push(val: 13)
stackMin.peek()?.min
stackMin.push(val: 2)
stackMin.peek()?.min
stackMin.push(val: 66)
stackMin.peek()?.min
stackMin.push(val: 44)
stackMin.peek()?.min


stackMin.peek()?.min


stackMin.peek()?.min

stackMin.pop()?.val

stackMin.peek()?.min
stackMin.pop()?.val

stackMin.peek()?.min
stackMin.pop()?.val

stackMin.peek()?.min
