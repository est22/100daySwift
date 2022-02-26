# 100 days of SwiftUI

## How to use type annotations
### type inference
### 1. variable
swift "infers" which value is which type  -> explicit
we can override and say it's definitely some kinda type so that Swift can hold the value of its type
```swift
let surname = "Lasso"
var score = 0

// type annotation -> explicit
let surname: String = "Lasso"
var score: Int = 0
```

### 2. dictionary
```[String: Int]``` 이런 식으로 선언한다.

```swift
var user: [String: String] = ["id": "@twostraws"]
```

### 3. set
```Set<String>``` 이런 식으로 선언한다.

```swift
var books: Set<String> = Set(["The Bluest Eye", "Foundation", "Girl, Woman, Other"])
```

만약 initial values 를 넣기 싫다면 두번째 줄과 같이 하여도 좋다.
```swift
var soda: [String] = ["Coke", "Pepsi", "Irn-Bru"]
var teams: [String] = [String]()
```
* Remember, you need to add the open and close parentheses when making empty arrays, dictionaries, and sets, because it’s where Swift allows us to customize the way they are created.

type annotation을 사용하여도 좋고, type inference 를 사용하여도 좋다.
```swift
var cities: [String] = [] // type annotation
var clues = [String]() // type inference
```

### 4. enums
enums는 우리 마음대로 새로운 타입을 생성시킬 수 있다. 그래서 이전과는 조금 다르다.
```swift
enum UIStyle {
    case light, dark, system
}

var style = UIStyle.light
```
우리는 여기서 .light 를 .dark로 나중에 바꿀 수도 있다. 아무튼 이렇게 해도 이 ```style``` 변수는 ```UIstyle```의 종류라는 것을 알 수 있다.


## Summary: Complex data
- Arrays : ```count```,```append()```,```contains()```
- Dictionaries: ```count```,```insert()```,```contains()```
- Sets: really efficient at finding whether they contain a specific item. order대로 저장하려고 쓰는 타입이 아님
- Enums: let us create our own simple types in Swift so that we can specify a range of acceptable values
- type inference: mostly used. Swift must always know the type of data inside a constant or variable
- type annotation: force a particular type
