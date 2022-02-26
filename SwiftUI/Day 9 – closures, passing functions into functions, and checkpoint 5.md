# 100 days of SwiftUI

Today the topic is __closures__, which are a bit like _anonymous functions_ – functions we can create and assign directly to a variable, or pass into other functions to customize how they work. Yes, you read that right: passing one function into another as a parameter.

## 1. How to create and use closures

1. we can create closures as anonymous functions, storing them inside constants and variables.
2. we’re also able to pass functions into other functions.

```swift
func greetUser() {
    print("Hi there!")
}

greetUser()

var greetCopy = greetUser
greetCopy()
```
__Imporant:__ When you’re copying a function, you don’t write the parentheses after it – it’s ```var greetCopy = greetUser ``` and not ```var greetCopy = greetUser()```. If you put the parentheses there you are calling the function and assigning its return value back to something else.

함수를 복사할 때는 괄호를 쓰지 않는다! 괄호를 쓴다는 것은 함수를 호출하여 그 반환값을 어디엔가 할당한다는 것이다.

하지만 개별의 함수를 생성하는 단계를 _스킵_하고 constant or variable에 바로 기능을 할당하고 싶다면, 이 때 __closure expression__을 쓴다.  a chunk of code we can pass around and call whenever we want.

클로저는 {} 안에 나타낼 수 있다. 그래서 만약 클로저에 매개변수를 넣고 싶으면 __braces 안에다가__ 넣어준다. 
```string
let sayHello = { (name: String) -> String in
    "Hi \(name)!"
}
```
⭐️ 여기서 ```in``` 키워드를 사용하는 것은, parameter 가 끝났다는 marker로 작용하면서 function body 의 start를 나타낸다.

### function types : 함수도 type이 있다!
``` var greetCopy: () -> Void = greetUser ``` 를 보면, 매개변수도 없고 리턴타입도 없으며 에러도 던지지 않는다는 것을 알 수 있다. ```Void```는 아무것도 없다는 뜻이다. ```()```를 쓰기도 하는데, 빈 parameter list와 헷갈릴수도 있어서 잘 쓰진 않는다. 


여기서 중요한 것은, 함수가 받는 data의 _name_은 함수의 일부가 아니라는것이다!

```swift
func getUserData(for id: Int) -> String {
    if id == 1989 {
        return "Taylor Swift"
    } else {
        return "Anonymous"
    }
}

let data: (Int) -> String = getUserData
let user = data(1989)
print(user)
```

user 변수에 위의 함수를 복사했지만, 우리는 ```data(1989)``` 라고 하지, ```data(for: 1989)``` 라고 하지 않았다! 이처럼 모든 클로저도 같은 개념이 적용된다. 즉, 클로저를 생성하거나 함수를 복사할 때는 external parameter names 는 중요하지 않다. 함수를 직접적으로 부를때만 중요하다!


### sorted() 안에 custom code(closure) 넘겨주기

```swift
let team = ["Gloria", "Suzanne", "Piper", "Tiffany", "Tasha"]
let sortedTeam = team.sorted()
print(sortedTeam)
```
위와 같은 함수가 있다고 했을 때, 캡틴이 있어서 그 캡틴은 항상 앞에 나와야한다면 어떻게 해야할까..? sorted() 함수 안에 두 개의 파라미터를 넣어주면 된다. 그래서 첫번재 스트링이 두번째 스트링에 앞서 정렬이 되어야 하면 참, 그것이 아니라 두번째 스트링 뒤에 가야하면 거짓으로 하는 함수를 만들어보면

```swift
func captainFirstSorted(name1: String, name2: String) -> Bool {
    if name1 == "Suzanne" {
        return true
    } else if name2 == "Suzanne" {
        return false
    }

    return name1 < name2
}
```

캡틴은 Suzanne으로 가정한다. 그리고 우리는 ```sorted()``` 함수에 우리가 만든 ```captainFirstSorted()``` 함수를 넘겨줄 수 있다.

```swift
let captainFirstTeam = team.sorted(by: captainFirstSorted)
print(captainFirstTeam) // ["Suzanne", "Gloria", "Piper", "Tasha", "Tiffany"]
```

그러면 우리가 원하는 바와 같은 결과를 얻을 수 있다.

아래와 같이 ```by:``` 안에 함수 대신 바로 클로져를 넘겨줄 수도 있다. 
```swift
let captainFirstTeam = team.sorted(by: { (name1: String, name2: String) -> Bool in
    if name1 == "Suzanne" {
        return true
    } else if name2 == "Suzanne" {
        return false
    }

    return name1 < name2
})
```

클로저 함수의 작성 방법 & code breakdown
1. ```sorted()``` 함수 호출을 할것이다.
2.  ```by:``` 안에 함수 대신 바로 클로져를 넘겨준다. ```by:``` 뒤의 여는 중괄호 ```{``` 부터 닫는 중괄호 ```}``` 까지 클로져의 일부다.
3. 클로져의 안에 우리는 sorted() 함수가 넘겨주는 두개의 파라미터를 정렬하는 작업을 한다. 그리고 클로져는 불리언 형식으로 반환할 것이라고도 말해준다. 그래서 클로져의 코드(body)가 시작될 것이라고 알려주는 marker ```in```을 써준다.
4. 클로져의 바디 안에 함수를 작성한다.





### Optional: What the heck are closures and why does Swift love them so much?
Closures let us wrap up some functionality in a single variable, then store that somewhere. We can also return it from a function, and store the closure somewhere else.

1. Running some code after a delay.
2. Running some code after an animation has finished.
3. Running some code when a download has finished.
4. Running some code when a user has selected an option from your menu.

### Optional: Why are Swift’s closure parameters inside the braces?
__function__
```swift
func pay(user: String, amount: Int) {
    // code
}
```
__closure__

```swift
let payment = { (user: String, amount: Int) in
    // code
}
```

차이점은 매개변수가 중괄호 안에 들어갔고, ```in``` 키워드가 사용된다는 것이다. 클로져는 brace {} 안에 선언되는데, 그 이유는 튜플이랑 헷갈릴 수 있기 때문이다. 튜플의 경우 ``` let payment = (user: String, amount: Int) ``` 라고 선언되기 때문에..

어쨌든, 헷갈리기 때문에 ```in``` 키워드가 정말 중요한 역할을 한다는 것!

### Optional: How do you return a value from a closure that takes no parameters?

1. 매개변수 하나를 받고, 아무것도 반환하지 않는 클로져

```swift
let payment = { (user: String) in
    print("Paying \(user)…")
}
```

2. 매개변수 하나를 받고 boolean 값을 리턴하는 클로져
```swift
let payment = { (user: String) -> Bool in
    print("Paying \(user)…")
    return true
}
```

3. 아무 매개변수도 받지 않고 boolean 값을 리턴하는 클로져.
꼭!! 빈 괄호를 써주어야한다. 그냥 ```-> Bool``` 이라고 쓰면 안된다!
```swift
let payment = { () -> Bool in
    print("Paying an anonymous person…")
    return true
}
```

## 2. How to use trailing closures and shorthand syntax
앞선 코드
```swift
let team = ["Gloria", "Suzanne", "Piper", "Tiffany", "Tasha"]

let captainFirstTeam = team.sorted(by: { (name1: String, name2: String) -> Bool in
    if name1 == "Suzanne" {
        return true
    } else if name2 == "Suzanne" {
        return false
    }

    return name1 < name2
})

print(captainFirstTeam)
```
에서, 우리는 두 매개변수의 타입을 명시해주지 않아도 된다. 왜냐하면 they _must_ be strings 이기 때문에.. 그래서 
```let captainFirstTeam = team.sorted(by: { name1, name2 in```
와 같이 쓸 수 있다.

코드가 짧아졌지만 한단계 더 나아갈 수 있다. ```sorted()```와 같이 한 함수가 또다른 함수를 매개변수로 받았을 때, 스위프트는 _trailing closure syntax_ 라는 것을 허용해준다. 

### trailing closures

```swift
let captainFirstTeam = team.sorted { name1, name2 in
    if name1 == "Suzanne" {
        return true
    } else if name2 == "Suzanne" {
        return false
    }

    return name1 < name2
}
```

```(by:```을 써서 클로저를 매개변수로 넘겨주는것 대신 by:도, 괄호도 그냥 생략해해버리고 써비린다!!

### shorthand syntax
스위프트는 자동으로 매개변수 이름을 정해준다. 그래서 우리는 불편하게 name1, name2... 이렇게 하지 않아도 된다. 대신 ```$0```, ```$1```.... 이렇게 사용해줄 수 있다!

```swift
let captainFirstTeam = team.sorted {
    if $0 == "Suzanne" {
        return true
    } else if $1 == "Suzanne" {
        return false
    }

    return $0 < $1
}
```
이곳에 쓰는 것보단 사실 sorted() 함수에 쓰면 더 코드가 깔끔해진다.
```swift
 let reverseTeam = team.sorted {
    return $0 > $1
}
```
하지만... 여기서 함수가 한 줄이 되었으니 또 ```return```을 생략할 수 있다.

```swift
let reverseTeam = team.sorted { $0 > $1 }
```

### shorthand syntax 언제 쓸지..?
1. The closure’s code is long.
2. ```$0``` and friends are used more than once each.
3. You get three or more parameters (e.g. ```$2```, ```$3```, etc).


또 다른 에시들
### filter()
```swift
let tOnly = team.filter { $0.hasPrefix("T") }
print(tOnly) // ["Tiffany", "Tasha"]
```

### map()
```swift
let uppercaseTeam = team.map { $0.uppercased() }
print(uppercaseTeam) // ["GLORIA", "SUZANNE", "PIPER", "TIFFANY", "TASHA"]
```

### Optional: Why does Swift have trailing closure syntax?
이유: 코드 읽기 쉬우라고.

```swift
func animate(duration: Double, animations: () -> Void) {
    print("Starting a \(duration) second animation…")
    animations()
}
```
에서, 트레일링 클로져를 쓰지 않고 이렇게 함수를 호출할 수 있다. 
```swift
animate(duration: 3, animations: {
    print("Fade out the image")
})
```
그렇지만 마지막의 ```})```이 아주 거슬린다....

그래서 trailing closure를 사용해주면서 animations 파라미터를 제거하면
```swift
animate(duration: 3) {
    print("Fade out the image")
}
```
와 같이 심플하게 사용할 수 있다. 

⭐️Trailing closures work best when their meaning is directly attached to the name of the function – you can see what the closure is doing because the function is called animate().

### Optional: When should you use shorthand parameter names?
1. Are there __ parameters__? If so, shorthand syntax stops being useful and in fact starts being counterproductive – was it $3 or $4 that you need to compare against $0 Give them actual names and their meaning becomes clearer.
2. Is __the function commonly used__? As your Swift skills progress, you’ll start to realize that there are a handful – maybe 10 or so – extremely common functions that use closures, so others reading your code will easily understand what $0 means.
3. Are the shorthand names used several times in your method? If you need to refer to $0 more than maybe __two or three times__, you should probably just give it a real name.

## 3. How to accept functions as parameters
1. accept other functions as parameters ```using:```
```swift
func makeArray(size: Int, using generator: () -> Int) -> [Int] {
    var numbers = [Int]()

    for _ in 0..<size {
        let newNumber = generator()
        numbers.append(newNumber)
    }

    return numbers
}
```
여기서 첫 번째 줄이 좀 어렵다. 이해만 하면 좋은데
```makeArray()``` 라는 함수를 만들었고,
첫번째 매개변수 이름은 ```size```라는 정수형 변수이다.
두번째 매개변수는 ```generator``` 라는 함수인데, 이 함수 자체는 매개변수가 없고 반환값은 정수형이다.
그래서 ```makeArray()``` 함수는 정수형 배열을 반환한다.

우리는 이 함수를 활용하여 임의의 크기를 가진 정수형 배열을 만들 수 있다(arbitrary-sized integer arrays).

```swift
let rolls = makeArray(size: 50) {
    Int.random(in: 1...20)
}

print(rolls)


func generateNumber() -> Int {
    Int.random(in: 1...20)
}

let newRolls = makeArray(size: 50, using: generateNumber)
print(newRolls)

```


2. you can make your function accept _multiple_ function parameters if you want, in which case you can specify multiple trailing closures. The syntax here is very common in SwiftUI

```swift
func doImportantWork(first: () -> Void, second: () -> Void, third: () -> Void) {
    print("About to start first work")
    first()
    print("About to start second work")
    second()
    print("About to start third work")
    third()
    print("Done!")
}

```
첫번째 trailing closure 은 우리가 쓴 것과 똑같으니까 그대로 두지만, second, third는 다르므로 이들은 _external parameter name_을 콜론(:)과 같이 써주고 그다음 중괄호를 열어주어야한다.

```swift
doImportantWork {
    print("This is the first work")
} second: {
    print("This is the second work")
} third: {
    print("This is the third work")
}
```


### Optional: Why would you want to use closures as parameters?

1. _the way Siri integrates with apps_. Siri is a system service that __runs from anywhere__ on your iOS device, but __it’s able to communicate with apps__ – you can book a ride with Lyft, you can check the weather with Carrot Weather, and so on. Behind the scenes, Siri launches a small part of the app in the background to pass on our voice request, then shows the app’s response as part of the Siri user interface.

하지만 만약 앱이 비정상적으로 작동해서 시리에게 응답하는데 10초가 걸린다면, 유저에게는 시리만 보이고 앱의 상태가 보이지 않으므로 마치 시리가 frozen한것처럼 보일것이다. 이는 terrible UX 다. 그래서 애플은 클로져를 사용한다. 

애플은 백그라운드에서 앱을 실행하고 실행이 완료되면 클로져(앱이 할일을 마쳤을 때 호출되도록 해놓음)로 넘긴다. 그러면 우리 앱은 어떤 작업을 수행해야 하는지 파악하는 데만 시간이 걸린다. 이 작업이 끝나면 시리에게 데이터를 전송하기 위해 클로져를 호출합니다. 함수에서 값을 반환하는 대신 클로저를 사용하여 데이터를 다시 전송하면 Siri는 함수가 완료될 때까지 기다릴 필요가 없으므로 UI를 interactive한 상태로 유지할 수 있으며 시리는 정지되지 않는다.



2. making N/W requests
또 다른 일반적인 예는 네트워크 요청입니다. 평균적인 iPhone은 초당 수십억 개의 작업을 수행할 수 있지만 일본의 서버에 연결하는 데는 0.5초 이상이 걸린다. 이는 장치에서 발생하는 속도에 비하면 매우 느린 속도이다. 그래서 우리가 인터넷에서 데이터를 요청할 때, closure와 함께 데이터를 요청한다: "please fetch this data, and when you’re done run this closure" 즉, 느린 작업이 발생하는 동안 UI를 강제로 정지시키지 않는다.

