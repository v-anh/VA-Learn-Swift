


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

compress(input: "aabbbbcccccccd")
