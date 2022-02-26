# 100 days of SwiftUI

## 1. How to check a condition is true or false : if
```swift
if someCondition {
    print("Do something")
    print("Do something else")
    print("Do a third thing")
}

if username.isEmpty == true {
    username = "Anonymous"
}

```
```isEmpty()```을 사용하여 true/false 값을 반환할 수 있다.



### How does Swift let us compare many types of data?
```swift
let firstName = "Paul"
let secondName = "Sophie"

let firstAge = 40
let secondAge = 10

print(firstName == secondName) // false
print(firstName != secondName) // true
print(firstName < secondName) // true
print(firstName >= secondName) // false

print(firstAge == secondAge) // false
print(firstAge != secondAge) // true
print(firstAge < secondAge) // false
print(firstAge >= secondAge) // true

```
또는 enum 도 비교할 수 있는데, case가 먼저 선언되었기 때문이다.

```swift
enum Sizes: Comparable {
    case small
    case medium
    case large
}

let first = Sizes.small
let second = Sizes.large
print(first < second) // true
```

## 2. How to check multiple conditions: if...else
```if-else```, ```if-else if-...-else``` 를 사용

- advanced conditions
만약 "오늘의 기온이 20도 이상이고 30도 이하일때 메시지 출력"을 하고싶다면?
```swift
let temp = 25

if temp > 20 {
    if temp < 30 {
        print("It's a nice day.")
    }
}
```
이라고 할 수 있겠지만, 조건연산자를 사용한다. 
```swift
if temp > 20 && temp < 30 {
    print("It's a nice day.")
}
```

```&&``` "and"
```||``` "or"  // pipe symbols

⭐️또한, 조건문 내에서의 ```== true```는 생략할 수 있다. 
```swift
if userAge >= 18 || hasParentalConsent {
    print("You can buy the game")
}


let strongMagnets = true
print(strongMagnets ? "Success" : "Failure")
```


```swift

enum TransportOption {
    case airplane, helicopter, bicycle, car, scooter
}

let transport = TransportOption.airplane

// 위에서 explicitedly referred 되었으니 그 다음부터는 TransportOption을 사용하지 않아도 된다.

if transport == .airplane || transport == .helicopter {
    print("Let's fly!")
} else if transport == .bicycle {
    print("I hope there's a bike path…")
} else if transport == .car {
    print("Time to get stuck in traffic.")
} else {
    print("I'm going to hire a scooter now!")
}

```



## 3. How to use switch statements to check multiple conditions: switch

```swift
enum Weather {
    case sun, rain, wind, snow, unknown
}

let forecast = Weather.sun

if forecast == .sun {
    print("It should be a nice day.")
} else if forecast == .rain {
    print("Pack an umbrella.")
} else if forecast == .wind {
    print("Wear something warm")
} else if forecast == .rain {
    print("School is cancelled.")
} else {
    print("Our forecast generator is broken!")
}

```
이렇게 할 수 있겠지만, 가독성이 떨어진다. 
일단 ```forecast``` 변수를 계속 사용해줘야하고, 실수로 ```.rain``` 을 두 번 하여 ```.snow```를 체크하지 못했다. 이럴 때 ```switch``` 를 사용하면 모든 조건들을 체크할 수 있다. 

```swift
switch forecast {
case .sun:
    print("It should be a nice day.")
case .rain:
    print("Pack an umbrella.")
case .wind:
    print("Wear something warm")
case .snow:
    print("School is cancelled.")
case .unknown:
    print("Our forecast generator is broken!")
}

```
하지만 유념해야 할 것이 두가지 있다.
1. All switch statements must be __exhaustive__, meaning that all possible values must be handled in there so you can’t leave one off by accident.

2. Swift will execute the first case that matches the condition you’re checking, but no more. Other languages often carry on executing other code from all subsequent cases, which is usually entirely the wrong default thing to do.


마지막에 __default case__를 provide 해줌으로써 코드가 실행되도록 할 수 있다.
```swift
let place = "Metropolis"

switch place {
case "Gotham":
    print("You're Batman!")
case "Mega-City One":
    print("You're Judge Dredd!")
case "Wakanda":
    print("You're Black Panther!")
default:  //⭐️
    print("Who are you?")
}
```
__Remember: Swift checks its cases in order and runs the first one that matches. __ 그래서 ```default```는 제일 마지막에 추가해주는것이 좋다. 


또한, 다음 case를 계속 실행하도록 원한다면 ```fallthrough```를 사용해준다. 자주 사용하진 않지만, 가끔 반복적인 작업을 줄여줄 수 있다.
아래의 코드에서 ```fallthrough``` 가 없다면, "5 golden rings"만 출력되어 나올것이다. 
```swift
let day = 5
print("My true love gave to me…")

switch day {
case 5:
    print("5 golden rings")
    fallthrough
case 4:
    print("4 calling birds")
    fallthrough
case 3:
    print("3 French hens")
    fallthrough
case 2:
    print("2 turtle doves")
    fallthrough
default:
    print("A partridge in a pear tree")
}

``` 
를 실행하면 
```
My true love gave to me…
5 golden rings
4 calling birds
3 French hens
2 turtle doves
A partridge in a pear tree
```
가 나온다.


### When should you use switch statements rather than if?

1. 스위치 문이 철저하게 완벽할때(가능한 모든 값들에 대한 해당값이 있을때)

Swift requires that its switch statements are exhaustive, which means you must either have a case block for every possible value to check (e.g. all cases of an enum) or you must have a default case. This isn’t true for if and else if, so you might accidentally miss a case.
2. 여러 결과가 있고 해당 값이 한번만 읽힐때, 아니면 여러번 읽을 때

When you use switch to check a value for multiple possible results, that value will only be read once, whereas if you use if it will be read multiple times. This becomes more important when you start using function calls, because some of these can be slow.
3. if가 다루기 힘든 고급 패턴 매칭을 가능하게 하고싶을 때

Swift’s switch cases allow for advanced pattern matching that is unwieldy with if.
가령, 3개 이상의 state value 를 확인하고 싶을때.


### Why does Swift have two range operators?
```..<``` 나, ```...```을 사용하여 specify only part of a range 가능
```swift
let names = ["Piper", "Alex", "Suzanne", "Gloria"]

print(names[1..<3]) // ["Alex", "Suzanne"]
print(names[1...3]) // ["Alex", "Suzanne", "Gloria"]

```

## 4. How to use the ternary conditional operator for quick tests: the ternary operator
_ternary conditional operator_ : 삼항연산자라고 하는데, 일단 +, -, == 와 같은 연산자들은 _binary operator_ 라고 불리는걸 알아야한다. 왜냐하면.. input이 두개이기 때문이다. 그렇다면 __ternary operator__은 당연히 _three_ pieces of input을 가진다. 
```swift
let age = 18
let canVote = age >= 18 ? "Yes" : "No"

let names = ["Jayne", "Kaylee", "Mal"]   
let crewCount = names.isEmpty ? "No one" : "\(names.count) people"
print(crewCount) // 3 people

"""
let names = [String]()
let crewCount = names.isEmpty ? "No one" : "\(names.count) people"
print(crewCount) // No one

"""

```


아래와 같은 코드가 있다고 할 때, 해석 시 break down을 잘 하면 된다.
만약 ```theme == .dark```  라면~ 이런 식으로.

```swift 
enum Theme {
    case light, dark
}

let theme = Theme.dark

let background = theme == .dark ? "black" : "white"
print(background)
```
