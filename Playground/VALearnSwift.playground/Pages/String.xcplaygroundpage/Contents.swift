


/*
 One Away: There are three types of edits that can be performed on strings: insert a character, remove a character, or replace a character. Given two strings, write a function to check if they are one edit (or zero edits) away.
 EXAMPLE
 pale, ple -> true
 pales, pale -> true
 pale, bale -> true
 pale, bae -> false
 */
import Foundation

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
    
    func push(item:T) {
        let node = Node(data:item)
        node.next = head
        head = node
    }
    
    func pop() -> T? {
        guard let head = self.head else {
            return nil
        }
        self.head = head.next
        return head.data
    }
    
    
    func peek() -> T? {
        guard let head = self.head else {
            return nil
        }
        
        return head.data
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

stackMin.push(val: 3)
stackMin.peek()?.val
stackMin.peek()?.min


var valueTypeSing = "valueTypeSing"

func change(string:String) {
    var a = string + "more string"
    print(a)
}
print(valueTypeSing)
change(string: valueTypeSing)
print(valueTypeSing)
var welcome = "hello"
welcome.trimmingCharacters(in: .whitespaces)

print(String(welcome.sorted()))
welcome.insert(contentsOf: " there", at: welcome.endIndex)
print(welcome)

let greeting = "Guten Tag!"
let index = greeting.index(greeting.startIndex, offsetBy: 7)
greeting[index]

func permutation(s:String,t:String) -> Bool {
    if s.count != t.count {
        return false
    }
    
    var letters = [Character:Int]()
    for c in s {
        if let count = letters[c] {
            letters[c] = count + 1
        }else{
            letters[c] = 1
        }
    }
    for c in t {
        guard let count = letters[c], count < 1 else {
            return false
        }
        letters[c] = count - 1
    }
    return true
}

permutation(s: "hello1", t: "helll0")

func URLify(t:String) -> String {
    var textArray = t.components(separatedBy: .whitespacesAndNewlines)
//    var textArray = t.split(separator: " ")
    return textArray.filter({!$0.isEmpty}).joined(separator: "%20")
}

print(URLify(t: "Mr John Smith       "))


/*
 One Away: There are three types of edits that can be performed on strings: insert a character, remove a character, or replace a character. Given two strings, write a function to check if they are one edit (or zero edits) away.
 EXAMPLE
 pale, ple true
 pales, pale -> true
 pale, bale -> true
 pale, bae -> false
 */
func oneWayEdit(first:String,second:String) -> Bool {
    if abs(first.count-second.count)>1 {
        return false
    }
    let s1 = first.count < second.count ? first : second
    let s2 = first.count < second.count ? second : first
    var index1 = 0
    var index2 = 0
    var foundDifference = false
    while index1 < s1.count && index2 < s2.count {
        let charIndex1 = s1.index(s1.startIndex, offsetBy: index1)
        let charIndex2 = s2.index(s2.startIndex, offsetBy: index2)
        if s1[charIndex1] != s2[charIndex2] {
            if foundDifference {
                return false
            }
            foundDifference = true
            if s1.count == s2.count { //Replace
                index1 += 1
                index2 += 1
            }else{
                index2 += 1
            }
        }else{
            index1 += 1
            index2 += 1
        }
    }
    return true
}

func replace(first:String,second:String) -> Bool {
    var found = false
    for i in 0..<first.count {
        let index1 = first.index(first.startIndex, offsetBy: i)
        let index2 = second.index(second.startIndex, offsetBy: i)
        if first[index1] != second[index2] {
            if found {
                return false
            }
            found = true
        }
    }
    return true
}

func insert(first:String,second:String) -> Bool {
    var index1 = 0
    var index2 = 0
    var found = 0
    for i in 0..<first.count {
        let index1 = first.index(first.startIndex, offsetBy: i)
        let index2 = second.index(second.startIndex, offsetBy: i + found)
        if first[index1] != second[index2] {
            if found > 0 {
                return false
            }
            found = 1
        }
    }
    return true
}

func oneWayEdit2(first:String,second:String) -> Bool {
    if abs(first.count-second.count)>1 {
        return false
    }
    if first.count == second.count {
        return replace(first: first, second: second)
    }else if first.count < second.count {
        return insert(first: first, second: second)
    }else {
        return insert(first: second, second: first)
    }
}


oneWayEdit(first: "pale", second: "ple")
oneWayEdit(first: "pales", second: "bales")
oneWayEdit(first: "pale", second: "bale")
oneWayEdit(first: "pale", second: "bae")

oneWayEdit2(first: "pale", second: "ple")
oneWayEdit2(first: "pales", second: "bales")
oneWayEdit2(first: "pale", second: "bale")
oneWayEdit2(first: "pale", second: "bae")


/*
 String Compression: Implement a method to perform basic string compression using the counts of repeated characters. For example, the string aabcccccaaa would become a2blc5a3. If the "compressed" string would not become smaller than the original string, your method should return the original string. You can assume the string has only uppercase and lowercase letters (a - z).
 */

func compress(text:String) -> String {
    if text.isEmpty || text.count <= 2 {
        return text
    }
    var temp = ""
    var index = 0
    var count = 0
    while index < text.count {
        count += 1
        if index+1 >= text.count || text[text.index(text.startIndex, offsetBy: index)] != text[text.index(text.startIndex, offsetBy: index+1)]   {
            temp += "\(text[text.index(text.startIndex, offsetBy: index)] )\(count)"
            count = 0
        }
        index += 1
    }
    if temp.count >= text.count {
        return text
    }
    return temp
}
//abbbb
print(compress(text: "aabcccccaaa"),compress(text: "aabcccccaaa") == "a2b1c5a3")
print(compress(text: "aabbccddeeff"),compress(text: "aabbccddeeff") == "aabbccddeeff")
print(compress(text: "aabbccddeeff"),compress(text: "abcdef") == "abcdef")


/*
 Word Break Problem | DP-32
 Given an input string and a dictionary of words, find out if the input string can be segmented into a space-separated sequence of dictionary words. See following examples for more details.
 Consider the following dictionary
 { i, like, sam, sung, samsung, mobile, ice,
 cream, icecream, man, go, mango}
 
 Input:  ilike
 Output: Yes
 The string can be segmented as "i like".
 
 Input:  ilikesamsung
 Output: Yes
 The string can be segmented as "i like samsung"
 or "i like sam sung".
 */

func dictionaryContain(text:String,dictionary:[String]) -> Bool {
    if (text.count == 0)  {return true}
    var start = 0
    var end = 1
    var found = false
    
    var dictionaryMap = [String:Int]()
    for index in dictionary {
        dictionaryMap[index] = 1
    }
    while (start < text.count && end <= text.count) {
        let startIndex = text.index(text.startIndex, offsetBy: start)
        let endIndex = text.index(text.startIndex, offsetBy: end)
        let range = startIndex..<endIndex
        let textIndex = String(text[range])
        print(textIndex)
        if dictionaryMap[textIndex] != nil {
            start = end
            end += 1
            found = true
        }else{
            end += 1
            found = false
        }
    }
    return found
}

func dictionaryContain2(text:String,dictionary:[String]) -> Bool {
    if (text.count == 0)  {return true}
    for i in 1...text.count {
        let startIndex = text.index(text.startIndex, offsetBy: i)
        let textIndex = String(text[..<startIndex])
        print(textIndex)
        let nextText = String(text[startIndex...])
        if dictionary.contains(textIndex) && dictionaryContain2(text: nextText, dictionary: dictionary) {
            return true
        }
    }
    return false
}

func dictionaryContainDB(text:String,dictionary:[String]) -> Bool {
    if (text.count == 0)  {return true}
    var wb = [Int:Bool]()
    for i in 1...text.count {
        let startIndex = text.index(text.startIndex, offsetBy: i)
        let textIndex = String(text[..<startIndex])
        
        if wb[i] == nil && dictionary.contains(textIndex) {
            wb[i] = true
        }
        if wb[i] != nil  {
            if i == text.count {
                return true
            }
            for j in (i+1)...text.count {
                let jStart = text.index(text.startIndex, offsetBy: i)
                let jEnd = text.index(text.startIndex, offsetBy: j)
                let jText = String(text[jStart..<jEnd])
                if wb[j] == nil && dictionary.contains(jText) {
                    wb[j] = true
                }
            }
        }
    }
    print(wb)
    return false
}
let text1 = "likesamsungi"
let text2 = "iiiiiiii"
let text3 = ""
let text4 = "ilikelikeimangoiii"
let text5 = "samsungandmango"
let text6 = "samsungandmangok"
let dictionary = ["mobile","likesamsungi","kesa","","su","","","man","mango","icecream","and",
                  "go","i","like","ice","cream"]
print(dictionaryContain2(text: text1, dictionary: dictionary) == true)
print(dictionaryContain2(text: text2, dictionary: dictionary) == true)
print(dictionaryContain2(text: text3, dictionary: dictionary) == true)
print(dictionaryContain2(text: text4, dictionary: dictionary) == true)
print(dictionaryContain2(text: text5, dictionary: dictionary) == true)
print(dictionaryContain2(text: text6, dictionary: dictionary) == true)

/*
 Count of distinct substrings
 */
//ababa
func countDistinctSubstring(text:String) -> Int {
    var start = 0
    var index = 0
    var distincDictionary = ["":1]
    while (start < text.count) {
        if index == text.count {
            start += 1
            index = start
        }else{
            index += 1
        }
        let startIndex = text.index(text.startIndex, offsetBy: start)
        let endIndex = text.index(text.startIndex, offsetBy: index)
        let range = startIndex..<endIndex
        let textIndex = String(text[range])
        print(textIndex)
        distincDictionary[textIndex] = 1
        
    }
    return distincDictionary.count
}

print(countDistinctSubstring(text: "ababa") == 10)
print(countDistinctSubstring(text: "ab") == 4)


/**
 1-9 -> 9 -> 9*1
 10-99 -> 90 -> 9 * 10
 100-999 -> 900 -> 9 * 100
 */

func countPosibleCharForChunks(for chunkCount:Int) -> Int{
    var leftSide = 0
    var i = 1
    var chunkCountTemp = chunkCount
    while i <= chunkCount {
        var countOfConsecutive = (9*i)
        if countOfConsecutive > chunkCountTemp {
            countOfConsecutive = chunkCountTemp
        }
        let count = i.numberOfDigits
        
        leftSide += (countOfConsecutive)*(count+1)
        print(leftSide)
        chunkCountTemp = chunkCountTemp - countOfConsecutive
        i = i*10
    }
    return leftSide + chunkCount.numberOfDigits*chunkCount
}
print(countPosibleCharForChunks(for: 10))
//print(leftSide)
