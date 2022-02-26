# 100 days of SwiftUI

## How to store truth with Booleans (boolean)
Booleans were named after George Boole, an English mathematician who spent a great deal of time researching and writing about logic

논리연산자: !
```swift
var isAuthenticated = false
isAuthenticated = !isAuthenticated
print(isAuthenticated)
isAuthenticated = !isAuthenticated
print(isAuthenticated)

```

However, ```toggle()``` 함수를 호출하면 논리연산자를 쓴것처럼 바꿔준다.

```swift:toggle.swift
var gameOver = false
print(gameOver)

gameOver.toggle()
print(gameOver)

```

## How to join strings together
Notice how we’re using + to join two strings, but when we used Int and Double it added numbers together? This is called operator overloading – the ability for one operator such as + to mean different things depending on how it’s used. For strings, it also applies to +=, which adds one string directly to another.
```operator overloading``` 연산자가 어떻게 쓰였느냐에 따라 다른 역할로 기능할 수 있는 기능

```swift
let luggageCode = "1" + "2" + "3" + "4" + "5"
```
위와 같은 코드가 있다고 할 때, Swift can’t join all those strings in one go. Instead, it will join the first two to make “12”, then join “12” and “3” to make “123”, then join “123” and “4” to make “1234”, and finally join “1234” and “5” to make “12345” – it makes temporary strings to hold “12”, “123”, and “1234” even though they aren’t ultimately used when the code finishes.

```string interpolation``` lets us efficiently create strings from other strings, but also from integers, decimal numbers, and more
```swift:stringInterpolation.swift
let quote = "Then he tapped a sign saying \"Believe\" and walked away."

let name = "Taylor"
let age = 26
let message = "Hello, my name is \(name) and I'm \(age) years old."
print(message)


let missionMessage = "Apollo " + String(number) + " landed on the moon."
// 이렇게 써도 되지만 string interpolation을 쓰면 더욱 간단.
let missionMessage = "Apollo \(number) landed on the moon."

// 팁: 안에 연산자를 넣어도 된다.
print("5 x 5 is \(5 * 5)") // “5 x 5 is 25”
```


===
### Why does Swift need both Doubles and Integers?
```swift
var myInt = 1
var myDouble = 1.0
```
As you can see, they both contain the number 1, but the former is an integer and the latter a double.

Now, if they both contain the number 1, you might wonder why we can’t add them together – why can’t we write var total = myInt + myDouble? The answer is that Swift is playing it safe: we can both see that 1 plus 1.0 will be 2, but your double is a variable so it could be modified to be 1.1 or 3.5 or something else. How can Swift be sure it’s safe to add an integer to a double – how can it be sure you won’t lose the 0.1 or 0.5?


### Why is Swift a type-safe language?

 It’s a variable, which means we can change its value as often as we need to, but we can’t change its type: it will always be an integer.

This is extremely helpful when building apps, because it means Swift will make sure we don’t make mistakes with our data. 





