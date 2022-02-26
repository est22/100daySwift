# 100 days of SwiftUI
## 1. How to provide default values for parameters
default parameter values let us keep flexibility in our functions without making them annoying to call most of the time – you only need to send in some parameters when you need something unusual.
```swift
func printTimesTables(for number: Int, end: Int = 12) {
    for i in 1...end {
        print("\(i) x \(number) is \(i * number)")
    }
}

printTimesTables(for: 5, end: 20) // 5 ~ 20
printTimesTables(for: 8) // 8 ~ 12

```

### keepingCapacity
우리가 ```removeAll()```을 사용하면, 스위프트는 array에 해당하는 모든 아이템들을 지우면서 그들이 차지하고 있던 메모리 공간도 싹 다 비운다. 하지만 가끔... 비우고 다시 새로운 아이템들을 그 자리에 채워넣고 싶을 때가 있다. 이 때 사용할 수 있는 default parameter value로 ```keepingCapacity```가 있다.
```swift
characters.removeAll(keepingCapacity: true)
```
keepingCapacity is a Boolean with the default value of __false__ so that it does the sensible thing by default, while also leaving open the option of us passing in ```true``` for times we want to __keep the array’s existing capacity__.



### Optional: When to use default parameters for functions
If you think there are certain parameter values you’ll use repeatedly, you can make them have a default value so your function takes less code to write and does the smart thing by default.


```swift
func findDirections(from: String, to: String, route: String = "fastest", avoidHighways: Bool = false) {
    // code here
}

findDirections(from: "London", to: "Glasgow")
findDirections(from: "London", to: "Glasgow", route: "scenic")
findDirections(from: "London", to: "Glasgow", route: "scenic", avoidHighways: true)

```
Shorter, simpler code most of the time, but flexibility when we need it – perfect.


## 2. How to handle errors in functions
비번이 너무 짧거나 쉬울때 에러를 나타내려고 한다. 

1. we need to start by defining the possible errors that might happen. swift's existing ```Error```type 을 이용할것이다.

```swift
enum PasswordError: Error {
    case short, obvious
}
```

2. write a function that will trigger one of those errors. When an error is triggered – or thrown in Swift – we’re saying something fatal went wrong with the function, and instead of continuing as normal it immediately terminates without sending back any value.
```swift
func checkPassword(_ password: String) throws -> String {
    if password.count < 5 {
        throw PasswordError.short
    }

    if password == "12345" {
        throw PasswordError.obvious
    }

    if password.count < 8 {
        return "OK"
    } else if password.count < 10 {
        return "Good"
    } else {
        return "Excellent"
    }
}
```

3. run the function and handle any errors that might happen
Swift Playground == pretty lax about error handling cus they're mostly meant for learning. but when working with real Swift projs you'll find there are three steps:

1) Starting a block of work that might throw errors, using ```do```.
2) Calling one or more throwing functions, using ```try```.
3) Handling any thrown errors using ```catch```.

 _puseudocode_

```
do {
    try someRiskyWork()
} catch {
    print("Handle errors here")
}
```

```swift
let string = "12345"

do {
    let result = try checkPassword(string)
    print("Password rating: \(result)")
} catch {
    print("There was an error.")
}
```
⭐️ 여기서 중요한 것은 ```try``` 인데, 에러를 유발할 수 있는 함수 전에 선언되어야한다. 에러발생 시 regular code execution이 interrupted 될것이라는 visual signal 이기도 하다.
⭐️ When you use ```try```, you need to be inside a ```do``` block, and make sure you have one or more ```catch``` blocks able to handle any errors.

When it comes to catching errors, you must always have a ```catch``` block that is able to handle every kind of error. However, you can also catch __specific errors__ as well, if you want:

```swift
let string = "12345"

do {
    let result = try checkPassword(string)
    print("Password rating: \(result)")
} catch PasswordError.short {
    print("Please use a longer password.")
} catch PasswordError.obvious {
    print("I have the same combination on my luggage!")
} catch {
    print("There was an error.")
}
```

⭐️ tip: ```error.localizedDescription```을 사용하여 구체적으로 어떤 에러인지 알 수 있다.

### Optional: Why does Swift make us use try before every throwing function?
Using Swift’s throwing functions relies on three unique keywords: ```do```, ```try```, and ```catch```. We need all three to be able to call a throwing function, which is unusual – most other languages use only two, because they don’t need to write ```try``` before every throwing function.

The reason Swift is different is fairly simple: by forcing us to use ```try``` before every throwing function, we’re explicitly acknowledging which parts of our code can cause errors. This is particularly useful if you have several throwing functions in a single ```do``` block, like this:
```swift
do {
    try throwingFunction1()
    nonThrowingFunction1()
    try throwingFunction2()
    nonThrowingFunction2()
    try throwingFunction3()
} catch {
    // handle errors
}
```
using try makes it clear that the first, third, and fifth function calls can throw errors, but the second and fourth cannot.

