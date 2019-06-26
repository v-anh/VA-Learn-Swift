import UIKit


var str = "Hello, playground"

func factorical(N:Int) -> Double {
    if N == 0 {
        return 1
    }else{
        return Double(N)*factorical(N: N-1)
    }
}

func fibonacy(M:Int) -> [Int] {
    if M <= 1 {
        return [Int]()
    }
    var fibonacies = [Int]()
    fibonacies.append(0)
    fibonacies.append(1)
    for i in 2..<M {
        fibonacies.append(fibonacies[i-1] + fibonacies[i-2])
    }
    return fibonacies
}

fibonacy(M: 10)

func sum(t1:String,t2:String) -> String {
    let shorter = t1.count < t2.count ? t1 : t2
    var longer = t1.count < t2.count ? t2 : t1
    var index = 1
    var bonus = 0
    var result = ""
    while index <= longer.count  {
        let lCharIndex = longer.index(longer.endIndex, offsetBy: -(index))
        var sum = (Int(String(longer[lCharIndex])) ?? 0) + bonus
        if index <= shorter.count {
            let sCharIndex = shorter.index(shorter.endIndex, offsetBy: -(index))
            let sChar = Int(String(shorter[sCharIndex])) ?? 0
            sum = sum + sChar
        }
        
        bonus = 0
        if sum >= 10 {
            bonus = 1
            sum = sum - 10
        }
        result = "\(sum)" + result
        index += 1
    }
    if bonus > 0 {
        result = "\(bonus)"+result
    }
    return result
}


func minus(t1:String,t2:String) -> String {
    var negative = false
    if  t1 < t2 {
        negative = true
    }
    
    let shorter = t1.count < t2.count ? t1 : t2
    var longer = t1.count < t2.count ? t2 : t1
    var index = 1
    var bonus = 0
    var result = ""
    while index <= longer.count  {
        let lCharIndex = longer.index(longer.endIndex, offsetBy: -(index))
        var minus = (Int(String(longer[lCharIndex])) ?? 0) - bonus
        if index <= shorter.count {
            let sCharIndex = shorter.index(shorter.endIndex, offsetBy: -(index))
            let sChar = Int(String(shorter[sCharIndex])) ?? 0
            minus = minus - sChar
        }
        
        bonus = 0
        if minus < 0 {
            bonus = 1
            minus = 10 + minus
        }
        result = "\(minus)" + result
        index += 1
    }
    if bonus > 0 {
        result = "\(bonus)"+result
    }
    if negative {
        result = "-"+result
    }
    return result
}
let t1 = "947"
let t2 = "56"
print(minus(t1: t2, t2: t1))
