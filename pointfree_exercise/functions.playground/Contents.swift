import UIKit

func incr(_ x: Int) -> Int {
  return x + 1
}

func square(_ x: Int) -> Int {
  return x * x
}

extension Int {
  func incr() -> Int {
    return self + 1
  }

  func square() -> Int {
    return self * self
  }
}

precedencegroup ForwardApplication {
    associativity: left
}

infix operator |>: ForwardApplication

func |> <A, B>(a: A, f: (A) -> B) -> B {
    return f(a)
}
 
2 |> incr |> square


precedencegroup ForwardComposition {
    associativity: left
    higherThan: ForwardApplication
}
infix operator >>>: ForwardComposition

func >>> <A, B, C>(f: @escaping (A) -> B, g: @escaping (B) -> C) -> ((A) -> C) {
    return { a in
        g(f(a))
    }
}

(incr >>> square)(2)

2 |> incr >>> square
 
2 |> incr >>> square >>> String.init


[1, 2, 3]
.map(incr)
.map(square)


[1, 2, 3].map(incr >>> square)
