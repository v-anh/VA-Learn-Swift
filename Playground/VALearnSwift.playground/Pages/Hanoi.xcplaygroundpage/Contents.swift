


func haNoiTower(N:Int, A:String,C:String,B:String) {
    if N == 1{
        bring(N: N, from: A, to: C)
    } else {
        haNoiTower(N: N-1, A: A, C: B, B: C)
        bring(N: N, from: A, to: C)
        haNoiTower(N: N-1, A: B, C: C, B: A)
    }
    return
}

func bring(N:Int, from:String,to:String) {
    print(" Bring \(N) from \(from) to \(to)\n")
}

func HNMain(){
    haNoiTower(N: 10, A: "A", C: "C", B: "B")
}

HNMain()
