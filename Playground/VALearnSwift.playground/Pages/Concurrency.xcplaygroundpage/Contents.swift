



import Foundation

var value: Int = 2
    
    DispatchQueue.main.async {
        for i in 0...3 {
            value = i
            print("\(value) ✴️")
        }
        
        
    }



for i in 4...6 {
    value = i
    print("\(value) ✡️")
}

//DispatchQueue.main.async {
//    value = 9
//    print(value)
//}


