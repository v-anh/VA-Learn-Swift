
let T = 3
var chessboard = Array(repeating: Array(repeating: 0, count: T), count: T)
let Dx = [-2,-2,-1,-1, 1, 1, 2, 2]
let Dy = [-1, 1,-2, 2,-2, 2,-1, 1]
var count = 0

func printOut() {
    for i in 0..<T {
        print(chessboard[i])
    }
    
}

func initArray() {
    for i in 0..<T {
        for j in 0..<T{
            chessboard[i][j] = 0
        }
    }
}

/* A recursive utility function to solve Knight Tour
 problem */
func nextHorseStep(x:Int,y:Int,count:Int) -> Bool{
    
    if count == T*T {
        return true
    }
    
    /* Try all next moves from the current coordinate x, y */
    for i in 0...7 {
        let u = x + Dx[i]
        let v = y + Dy[i]
        if(u>=0 && u<T && v>=0 && v<T && chessboard[u][v] == 0){
            
            chessboard[u][v] = count
            if(nextHorseStep(x: u, y: v,count: count+1) == true) {
                return true
            }else{
                // backtracking
                chessboard[u][v] = 0
            }
        }
    }
    return false
}


func main(){
    
    printOut()
    chessboard[0][0] = 1
    if(nextHorseStep(x: 0, y: 0,count: 2) == false) {
        print("can not solve this problem")
    }else{
        print("solved this problem")
        printOut()
    }
}

main()

