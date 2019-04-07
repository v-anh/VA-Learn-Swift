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

func main(){
}

main()


