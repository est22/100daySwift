# 100 days of SwiftUI

## How to reuse code with functions
어떤 코드를 짜고 그 코드를 반복해서 사용하고 싶다면, 함수로 만든다.
```swift
func showWelcome() {
    print("Welcome to my app!")
    print("By default This prints out a conversion")
    print("chart from centimeters to inches, but you")
    print("can also set a custom range if you want.")
}
```

### 함수의 괄호 call site = a place where a function is called
여기서, 왜 함수 뒤에 괄호가 오는지 알아야한다. 함수를 호출(call)할 때 괄호를 쓴다. 이것은 function's ```call site``` 이라고 불린다. 말 그대로, 괄호는 함수가 호출되는 자리를 나타낸다.


그렇다면 여기서 괄호의 역할은 정확히 무엇인가?  we get to. ass in data that. ustomizes the way the function works, so the function becomes more __flexible__

```swift
let number = 139

if number.isMultiple(of: 2) {
    print("Even")
} else {
    print("Odd")
}
```

```isMultiple(of:)```을 사용하면 ```isOdd```,```isEven```보다 더욱 다양하게 활용할 수 있다. 즉, We can make our own functions that are open to configuration.

### parameter & argument
```swift
func printTimesTables(number: Int) {
    for i in 1...12 {
        print("\(i) x \(number) is \(i * number)")
    }
}

printTimesTables(number: 5)
```
우리가 밑에서 ```printTimesTables```을 호출할 때는, ```number: 5```이라고 확실히 명시해줘야한다. This isn’t common in other languages, but really helpful in Swift as a reminder of what each parameter does.

_multiple_ parameters일 때, this naming of parameters is really important.

```swift
func printTimesTables(number: Int, end: Int) {
    for i in 1...end {
        print("\(i) x \(number) is \(i * number)")
    }
}

printTimesTables(number: 5, end: 20)
```
여기서 ```printTimesTables(5, 20)```라고 하면, 어떤 숫자가 어떤 것인지 잘 기억이 안날것이다. 
```func printTimesTables(number: Int, end: Int) {``` 에서 ```number```, ```end``` 는 _parameter_ 이다. (함수가 호출될 때 값들로 채워질 placeholder names) 
그리고 여기서 __5__와 __20__ 은 _arguments_ 이다. 함수 안에 실질적으로 들어가서 동작하는 실제 값들로, ```number```와 ```end```의 값들을 채우게 된다.


- ```parameter```: _placeholder_
- ```argument```: _actual value_
라고 생각하면 된다.
⭐️ __ 요약: Parameter/Placeholder , Argument/Actual Value __
하지만 parameter을 둘 다에 사용해도 크게 문제는 없다... 왜냐면 스위프트에서 이 둘을 구분하는 것은 _매우_ 헷갈리기 때문에..
하지만! 기억해야 할 것은 parameter 순서대로 argument 값을 넣어줘야한다.
```swift
func printTimesTables(number: Int, end: Int) 
printTimesTables(end: 20, number: 5) // ❌
printTimesTables(number: 5, end: 20 ) // ✅
```

또한, 함수의 작동이 끝나는 순간 함수 안의 모든 데이터는 자동으로 없어져버린다. Any data you create inside a function is automatically destroyed when the function is finished.

### Optional: What code should be put in a function?
1. when i want the same functionality in many places
2. useful for breaking up code
3. _function composition_ : build big functions by combining small functions in various ways like Lego bricks

### Optional: How many parameters should a function accept?
0 to infinite. 하지만 그 전에 there’s an important lesson to be learned here: this is called a __“code smell”__ – something about our code that suggests an underlying problem in the way we’ve structured our program


## How to return values from functions
1. 함수를 여는 괄호를 쓰기 전에 화살표와 데이터 타입을 써준다. (어떤 데이터가 반환될지)
2. ```return``` 키워드를 쓴다. 

> Write an arrow then a data type before your function’s opening brace, which tells Swift what kind of data will get sent back.
> Use the return keyword to send back your data.

```swift
func rollDice() -> Int {
    return Int.random(in: 1...6)
}

let result = rollDice()
print(result)

```

또다른 예시: 두 개 string이 그들의 순서와 상관없이 똑같은 글자를 가지고 있을까? 에 대한 함수를 만들려면 두개의 string parameter를 가져야하고, true/false를 리턴해야한다. 가령, "abc", "cab" 는 true가 나와야한다.
```swift
func areLettersIdentical(string1: String, string2: String) -> Bool {
    let first = string1.sorted()
    let second = string2.sorted()
    return first == second
}
```
라고 할 수 있겠지만, 더욱 줄일 수 있다. ```first```, ```second```  변수 없이  ```sorted()``` 함수를 바로 사용해버린다.
```swift
func areLettersIdentical(string1: String, string2: String) -> Bool {
    return string1.sorted() == string2.sorted()
}
```

### return keyword 삭제

하지만 여기서 더 줄일 수 있다. 보다시피 한 줄의 함수이다. 이렇게 함수가 한 줄로 되었을 때는 ```return``` 키워드를 아예 삭제할 수 있다.

```swift
func areLettersIdentical(string1: String, string2: String) -> Bool {
    string1.sorted() == string2.sorted()
}
```


## How to return multiple values from functions
- array??? 🤔❌ index 요소 기억하기 어려움..
```swift
func getUser() -> [String] {
    ["Taylor", "Swift"]
}

let user = getUser()
print("Name: \(user[0]) \(user[1])") 
```
하지만, user[0], user[1]이 뭐였는지 기억하기 어렵기 때문이다. 

- dictionary??? 🤔❌ default값 명시..
```swift
func getUser() -> [String: String] {
    [
        "firstName": "Taylor",
        "lastName": "Swift"
    ]
}

let user = getUser()
print("Name: \(user["firstName", default: "Anonymous"]) \(user["lastName", default: "Anonymous"])") 
```
하지만,,, print문을 보면 우리는 이미 ```firstName```, ```lastName```을 정확하게 알고있음에도 불구하고 unexpected results를 위한 ```default:```을 써주어야한다.

➡️ tuple 😃✅

```swift
func getUser() -> (firstName: String, lastName: String) {
    (firstName: "Taylor", lastName: "Swift")
}

let user = getUser()
print("Name: \(user.firstName) \(user.lastName)")
```
딕셔너리와 다른 점은, we don't need to provide a default value and Swift does know ahead of time that it's available cus the tuple says it will be available. and no typos!

### three things it's important to know when using tuples 
1. 중요한것이 있는데.. 함수로부터 튜플을 반환하면 스위프트는 이미 각 아이템들을 튜플 안에 넣는다는 것을 인식하고 있어서, ```return```을 사용하여 반복을 할 필요가 없다. 그래서 아래와 같이 사용해도 된다.

```swift
func getUser() -> (firstName: String, lastName: String) {
    ("Taylor", "Swift")
}
```

2. element가 이름이 없어도 access할 수 있다.. by using numerical indices starting from 0

```swift

func getUser() -> (String, String) {
    ("Taylor", "Swift")
}

let user = getUser()
print("Name: \(user.0) \(user.1)")

``` 

3. tuple로 반환하면 그 튜플을 쪼개어서 individual values로 넣을 수 있다. 
```swift
func getUser() -> (firstName: String, lastName: String) {
    (firstName: "Taylor", lastName: "Swift")
}

let user = getUser()
let firstName = user.firstName
let lastName = user.lastName

print("Name: \(firstName) \(lastName)")
```

⭐️ 하지만, 처음에 ```user```를 생성하여 각각의 값들을 복붙하여 할당하는 단계를 스킵할 수 있다. 아래와 같이 처음부터  ```getUser()```의 반환값을 가져와서 two separate constants에 쪼개어 집어넣는다. 
```swift
let (firstName, lastName) = getUser()
print("Name: \(firstName) \(lastName)")
```
만약 특정값을 사용하지 않는다면, _ 을 사용한다.
```swift
let (firstName, _) = getUser()
print("Name: \(firstName)")
```

### Optional: When should you use an array, a set, or a tuple in Swift?
- Array: 순서를 유지하고 중복을 가질 수 있다
- Set: 정렬되지 않고, 중복을 가질 수 없다
- Tuple: 고정된 수의 고정 유형값이 들어 있다(a fixed number of values of fixed types)

* 게임의 사전에 모든 단어의 목록을 저장하기를 원한다면, 중복되지 않고 순서가 중요하지 않기 때문에 ```Set```
* 사용자가 읽은 모든 기사를 저장하고 순서가 중요하지 않은 경우, ```Set```를 사용하거나(읽었는지 여부에 상관없는 경우), 순서가 중요한 경우 ```Array```
* 비디오 게임의 고득점 목록을 저장하려는 경우 순서가 중요하며 중복이 포함될 수 있으므로(두 명의 플레이어가 같은 점수를 받는 경우) ```Array```
* 작업관리 목록의 항목을 저장하려면 순서를 예측할 수 있어야 하므로 ```Array```
* 정확히 두 개의 문자열, 정확히 두 개의 문자열과 정수 또는 정확히 세 개의 Boolans를 보유하려면 ```Tuple```

## How to customize parameter labels
```swift
func rollDice(sides: Int, count: Int) -> [Int] {
    // Start with an empty array
    var rolls = [Int]()

    // Roll as many dice as needed
    for _ in 1...count {
        // Add each result to our array
        let roll = Int.random(in: 1...sides)
        rolls.append(roll)
    }

    // Send back all the rolls
    return rolls
}

let rolls = rollDice(sides: 6, count: 4)
```
여기서 ```rollDice(sides: 6, count: 4)``` 는 꽤 self-explanatory 다.
우리가 앞서 봤던 ```hasPrefix()```는 ``` hasPrefix(string:)```나 ```hasPrefix(prefix:)```라고 사용하지 않고 그냥 바로 사용한다. 왜일까?

### external parameter labels

우리가 함수에 대한 매개 변수를 정의할 때 실제로 두 가지 이름을 추가할 수 있다. 하나는 함수가 호출되는 곳에서 사용하기 위한 이름이고 다른 하나는 함수 자체 내에서 사용하기 위한 이름이다. hasPrefix()는 이것을 사용하여 _를 매개변수의 외부 이름으로 지정하는데, 이는 스위프트가 "ignore this" 라고 말하는 방식이며 해당 매개변수에 대한 외부 레이블이 없게 만든다.

우리의 함수를 만들 때 이와 같은 기술을 사용할 수 있다. 
```swift
func isUppercase(string: String) -> Bool {
    string == string.uppercased()
}

let string = "HELLO, WORLD"
let result = isUppercase(string: string) // 🤬
```


여기서, ```string: string```이 중복되는 것이 꽤나 열받는다.. string의 타입을 명시해주지 않으면 "missing argument label 'string:' in call" 이라는 에러 메시지가 뜬다. ⭐️그래서 매개변수 앞에 _를 추가해주면, external parameter label을 생략할 수 있다.

```swift
func isUppercase(_ string: String) -> Bool {
    string == string.uppercased()
}

let string = "HELLO, WORLD"
let result = isUppercase(string) // 😃
```
이러한 기능은 ```append()```, ```contains()``` 등에 많이 쓰인다.


또한, call site에서 쓸 수 없을 때도 유용하다. 
```swift
func printTimesTables(number: Int) {
    for i in 1...12 {
        print("\(i) x \(number) is \(i * number)")
    }
}

printTimesTables(number: 5)
```
라고 하기엔 함수가 돌아가긴 하지만 명확하지 않아서 number -> for으로 바꿔주었다.

```swift
func printTimesTables(for: Int) {
    for i in 1...12 {
        print("\(i) x \(for) is \(i * for)")
    }
}

printTimesTables(for: 5)
``` 
라고 하니 이렇게만 써서는 안된다. 아래와 같이 고쳐주어야한다.
```swift
func printTimesTables(for number: Int) {
    for i in 1...12 {
        print("\(i) x \(number) is \(i * number)")
    }
}

printTimesTables(for: 5)
```
주의깊게 봐야 할 사항들 세가지 
1. ```for number: Int```에서 ```for```은 external name, ```number```은 internal name이며, ```Int``` 타입이다.
2. ```printTimesTables(for: 5)``` 는 파라미터의 외부 이름이다.
3. 파라미터의 내부 이름은 ```print("\(i) x \(number) is \(i * number)")```에서 사용되고 있다. 

### two important ways to control parameter names
외부 파라미터 이름이 사용되지 않도록 _를 사용하거나, 외부 파라미터 이름과 내부 파라미터 이름을 모두 갖도록 두 번째 이름을 추가할 수 있다.(we can use _ for the external parameter name so that it doesn’t get used, or add a second name there so that we have both external and internal parameter names.)

_그러므로 arguments, parameters 구분하는것이 여기서 헷갈린다는 것이다.._

### When should you omit a parameter label?
The main reason for skipping a parameter name is __when your function name is a verb__ and __the first parameter is a noun which the verb is acting on. __ 
For example,
- Greeting a person would be ```greet(taylor)``` rather than ```greet(person: taylor)```
- Buying a product would be ```buy(toothbrush)``` rather than ```buy(item: toothbrush)```
- Finding a customer would be ```find(customer)``` rather than ```find(user: customer)```


파라미터 레이블이 내가 넣으려는 파라미터와 이름이 같을 때 유용하다.
- Singing a song would be ```sing(song)``` rather than ```sing(song: song)```
- Enabling an alarm would be ```enable(alarm)``` rather than ```enable(alarm: alarm)```
- Reading a book would be ```read(book)``` rather than ```read(book: book)```

### reason? interoperability with Objective-C
SwiftUI가 생기기 전에는 Objective-C로 Apple’s UIKit, AppKit, and WatchKit frameworks 를 사용하여 앱을 빌드했다. Objective-C에서는 the first parameter to a function was always left unnamed. and so when you use those frameworks in Swift you’ll see lots of functions that have underscores for their first parameter label to preserve interoperability with Objective-C.

