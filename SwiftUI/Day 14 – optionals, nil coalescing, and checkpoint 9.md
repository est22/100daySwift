# 100 days of SwiftUI
> Null references : when a variable has no value 
> in Swift : Optionals
## 1. How to handle missing data with optionals
_optionals_ – a word meaning “this thing might have a value or might not.”

### two primary ways of unwrapping optionals
1. __if let__ (the most common)
```swift
if let marioOpposite = opposites["Mario"] {
    print("Mario's opposite is \(marioOpposite)")
}
```
This ```if let``` syntax is _very common_ in Swift, and combines creating a condition (```if```) with creating a constant (```let```). Together, it does three things:

1. 딕셔너리부터 옵셔널 값을 읽어온다.
2. 만약 옵셔널이 있으면, unwrapped 된다. 즉, String이 marioOpposite constant로 들어간다.
3, 조건이 성공했다 - 옵셔널 언래핑에 성공했다 - 조건의 body 코드가 실행된다.

condition's body는 옵셔널 안에 값이 들어있을 때만 작동한다. 물론 ```else``` block을 추가할 수 있다. 
```swift
var username: String? = nil

if let unwrappedName = username {
    print("We got a user: \(unwrappedName)")
} else {
    print("The optional was empty.")
}
```

### 값이 없을 때 : nil
아래의 코드는 작동하지 않을것이다.
```swift
func square(number: Int) -> Int {
    number * number
}

var number: Int? = nil
print(square(number: number))
```
그 이유는 언래핑을 하지 않았기 때문이다. 옵셔널 정수는 언래핑이 먼저 되어야한다.  그래서 먼저 언래핑을 해주어야한다.
```swift
if let unwrappedNumber = number {
    print(square(number: unwrappedNumber))
}
```

### shadowing
⭐️ 그런데, 옵셔널을 언래핑할때, 같은 이름을 사용해서 언래핑한다. 스위프트에서는 이래도 된다. 그렇기 때문에 위의 코드를 아래와 같이 고친다.

```swift
if let number = number {
    print(square(number: number))
}
```
우리는 같은 이름을 가진 두번째 constant를 일시적으로 생성하고 있는데, 이것은 조건의 body에서만 유효하다. 이것을 _shadowing_이라고 한다. 


### Optional: Why does Swift make us unwrap optionals?
-> to provide a huge amount of protection for all our apps, because it puts a stop to uncertainty, to let us know it’s immediately safe to use

## 2. How to unwrap optionals with guard
앞서 제일 흔한 방법인 ```if let```으로 언래핑했다. 두 번째는 ```guard let``` 이다. 둘 다 옵셔널 안에 값이 있는지 아닌지 확인하는건 같다. 두개를 비교하면
```swift
var myVar: Int? = 3

if let unwrapped = myVar {
    print("Run if myVar has a value inside")
}

guard let unwrapped = myVar else {
    print("Run if myVar doesn't have a value inside")
}
```

### if let, guard let 차이점
- ```if let```은 옵셔널이 값이 있으면 {} 안의 코드를 실행한다. 

- ```guard let```은 옵셔널이 값이 __없으면__ {} 안의 코드를 실행한다. 그렇기 때문에 ```else``` 코드를 쓸 수 있다. "만약 우리가 옵셔널을 언래핑할 수 있는지 확인해봐..만약에 그렇게 하지 못한다면.."
guard let은 만약 우리의 기대대로 되지 못한다면 현재의 함수에서 벗어나게 하는 방식으로 __빼내주는 역할__을 한다. 이것을 _early return_이라고 종종 부른다. 바로 빼내주도록 하는 코드를 작성해서 우리의 의도대로 함수가 흘러가도록 하는 역할이랄까.. 만약 guard를 사용한다면 두 가지를 생각해야한다.
1. 함수의 input이 유효한지 확인하기 위해 guard를 사용한다면, 만약 확인이 실패할 경우를 대비하여 항상 ```return``` 키워드를 써야한다.
2. 만약 확인이 통과하고 언래핑하려는 옵셔널에 값이 들어있다면, ```guard``` 코드가 끝난 _후_에 옵셔널을 사용할 수 있다.

```swift
func printSquare(of number: Int?) {
    guard let number = number else {
        print("Missing input")

        // 1: We *must* exit the function here
        return
    }

    // 2: `number` is still available outside of `guard`
    print("\(number) x \(number) is \(number * number)")
}


printSquare(of: 3)

```

⭐️ use ```if let``` to unwrap optionals so you can process them somehow, and use ```guard let``` to ensure optionals have something inside them and exit otherwise.
⭐️ You can use guard with any condition, including ones that don’t unwrap optionals. For example, you might use ```guard someArray.isEmpty else { return }```.

### Optional: When to use guard let rather than if let
요약: 조건들이 만족되었는지 먼저 체크할 때 ```guard let``` 사용.
- ```if let```: if you just want to unwrap some optionals
- ```guard let```: if you’re specifically checking that conditions are correct before continuing


```guard let``` is designed to exit the current function, loop, or condition if the check fails, so any values you unwrap using it will stay around after the check.

```swift
func getMeaningOfLife() -> Int? {
    42
}


// if let
func printMeaningOfLife() {
    if let name = getMeaningOfLife() {
        print(name)
    }
}

// guard let
func printMeaningOfLife() {
    guard let name = getMeaningOfLife() else {
        return
    }

    print(name)
}
```
guard let을 사용하면...
1. 우리가 짠 코드가 계획대로 실행되는지에 온전히 집중하도록 해준다.
2. current scope가 이용되었을 때 scope를 탈출하도록 요구하므로 만약 실패한다면(이 코드에서) 함수로부터  ```return``` 을 시켜야한다. 이렇게 무언가가 반환된 상태는 옵셔널이 아니다. 스위프트는 이 return 키워드가 없다면 컴파일을 안해줄것이다.


## 3. How to unwrap optionals with nil coalescing
옵셔널 언래핑의 세번째..?! 바로 nil coalescing operator 이다. 옵셔널을 언래핑하면서 만약 옵셔널이 비었다면 디폴트값을 부여한다.

### nil coalescing operator: ??

```let new = captains["Serenity"]``` 뒤에 ```?? "N/A"```를 추가해준다. 
```swift
let captains = [
    "Enterprise": "Picard",
    "Voyager": "Janeway",
    "Defiant": "Sisko"
]

let new = captains["Serenity"] ?? "N/A"

```
이렇게 하면 captains 딕셔너리에서 값을 읽어와서 언래핑하려고 하는데 만약 그 안에 값이 있다면 new에 저장되겠지만, 없다면 "N/A"가 쓰여질것이다. 

이 말은, 옵셔널이 ```nil```을 가지던 실제 값을 가지던 결국 ```new```는 String 값을 가지게 될 것이다. 분명히 ```new```는 옵셔널이 아닐것이다!

그러면 이렇게 생각할 수 있다 : '그냥 딕셔너리 읽을 때 디폴트 값 부여하면 안되나?'

그래서 아래와 같이 코드를 입력할 수 있다.

```swift
let new = captains["Serenity", default: "N/A"]
```
이 경우에는 굳이 nil coalescing operator이 필요없다. 하지만  nil coalescing operator은 모든 옵셔널에 적용 가능하다.

### anoter example
```swift
// ex 1
let tvShows = ["Archer", "Babylon 5", "Ted Lasso"]
let favorite = tvShows.randomElement() ?? "None"

// ex 2. a struct with an optional property
struct Book {
    let title: String
    let author: String?
}

let book = Book(title: "Beowulf", author: nil)
//let book = Book(title: "Beowulf", author: "me")
let author = book.author ?? "Anonymous"
print(author)   // Anonymous


// ex 3. create an integer from a string
let input = ""
let number = Int(input) ?? 0
print(number)   
```

input 안에 String이 숫자로 있으면 그것이 Int로 바뀌어서 나오고, 아무것도 없으면 디폴트 값인 0이 나온다.


### Optional: When should you use nil coalescing in Swift?
__Nil coalescing__ lets us attempt to unwrap an optional, but provide a default value if the optional contains nil. 옵셔널이 되도록이면 없는 것이 일반적으로 좋기 때문에.

예를 들어 채팅앱을 만드는데 유저가 저장한 모든 메시지를 다 로딩하고 싶으면 이렇게 작성 가능하다.
```swift
let savedData = loadSavedMessage() ?? ""
```
-> ```loadSavedMessage()```은 문자열이 들어있는 옵셔널을 반환하는데, 언래핑되어 ```savedData```에 저장될것이다. 하지만 만약 옵셔널이 nil이면 ```savedData```에는 빈 문자열인 ```""```이 들어간다. 두 경우 모두 어쨌든간에 ```String```이 값으로 들어가게 된다.(더이상 옵셔널이 아니므로 _String?_이 아니다!)

여기서 nil coalescing을 연결(chain)할 수 있다. 일반적이진 않지만...
```swift
let savedData = first() ?? second() ?? ""
```
이렇게 하면 일단 first() 먼저 시도하고, 그다음에 이것이 nil을 반환하면 second()를 반환하고, second()가 nil을 반환하면 ""을 사용할것이다.

- dictionary에서의 nil coalescing 2 ways
⭐️ 딕셔너리 key를 읽는 것은 항상 옵셔널을 반환하므로, 여기서 우리가 확실히 non-optional한 값을 얻기 위해서는 nil coalescing을 해주는게 좋다.
```swift
let scores = ["Picard": 800, "Data": 7000, "Troi": 900]
let crusherScore = scores["Crusher"] ?? 0
```

취향 차이긴 한데 딕셔너리를 사용할때,만약 키가 찾아지지 않는다면 디폴트 값을 부여하도록 하는 다른 접근법이 있다.
```swift
let crusherScore = scores["Crusher", default: 0]
```

## 4. How to handle multiple optionals using optional chaining
옵셔널 안에 옵셔널이 있는 여러개의 옵셔널을 처리하려 할 때 옵셔널 체이닝을 이용한다.
```swift
let names = ["Arya", "Bran", "Robb", "Sansa"]

let chosen = names.randomElement()?.uppercased() ?? "No one"
print("Next in line: \(chosen)")
```

옵셔널 체이닝은 "옵셔널 안에 값이 있으면 언랩핑해..그리고 그 다음엔..."이라고 하는것과 같은데, 뒤이어서 계속 코드를 추가할 수 있다. 

⭐️ ```randomElement()```은 옵셔널을 반환하는데, 왜냐하면 배열이 비어있을 수 있기도 하기 때문이다. 하지만 옵셔널 체이닝은 만약 옵셔널이 비어있으면 아무것도 하지 않는다. 즉 옵셔널 체이닝을 해서 반환되는 값은 항상 옵셔널이라는 것이다. 그렇기 때문에 우리는 디폴트 값을 부여하기 위해 여전히 nil coalescing을 해주어야한다.

⭐️ 옵셔널 체이닝은 무한으로 길어질 수 있는데, ```nil```값을 받는다면 그 즉시 그 이후의 모든 코드들은 무시된다.

### 예시
작가의 이름순으로 책들을 정렬하고 싶다. 그렇다면 일단 
1. ```Book``` struct의 옵셔널 인스턴스를 만들것이다(정렬할 책이 있을수도, 없을수도 있으니). 
2. 만약 책이 있다면, 그 책은 작가가 있을수도 있고 작자미상일 수도 있다. 
3. 만약 작가가 있다면, 그 문자열은 빈 문자열일수도 있고 문자열이 존재하는 string일 수도 있다. 그렇기때문에 여기서도 첫 글자가 있을것이라고 방심할 수 없다. 
4. 만약 첫 번째 글자가 존재한다면, 첫글자는 무조건 대문자로 한다. (소문자로 시작하는 작가들도 있으니)
하....

코드로 구현을 하면 이렇다.
```swift
struct Book {
    let title: String
    let author: String?
}

var book: Book? = nil
let author = book?.author?.first?.uppercased() ?? "A"
print(author)

```
그래서 이렇게 읽힌다. “if we have a book, and the book has an author, and the author has a first letter, then uppercase it and send it back, otherwise send back A”.


### Optional: Why is optional chaining so important?
a very good companion to nil coalescing, because it allows you to dig through layers of optionals while also providing a sensible fall back if any of the optionals are nil.

## 5. How to handle function failure with optionals
### _optional_ try
When we call a function that might throw errors, we either call it using ```try``` and handle errors appropriately, or if we’re certain the function will not fail we use ```try!``` and accept that if we were wrong our code will crash. 

```swift
enum UserError: Error {
    case badID, networkFailed
}

func getUser(id: Int) throws -> String {
    throw UserError.networkFailed
}

if let user = try? getUser(id: 23) {
    print("User: \(user)")
}
```
```getUser()```는 항상 ```networkFailed``` 에러를 던질것인데 이것이 유저에게 갔는지 안갔는지가 중요하다. 우리에게 어떤 에러가 던져졌는지는 중요하지 않다.

여기서 ```try?``` 는 ```getUser()```가 옵셔널 문자열을 반환하도록 하고, 아무 에러나 던져졌을 때는 ```nil```을 반환할것이다. 

### try? + nil coalescing

만약 원한다면 ```try?``` 를 nil coalescing과 결합할 수 있다. 이 뜻은 "함수로부터 반환값을 가지고 오도록 시도해, 하지만 만약 실패하면 이 디폴트값을 대신 사용해라"라는 뜻이다. 하지만 여기서 ⭐️nil coalescing을 하기 전에 괄호를 추가해줘야한다.
```swift
let user = (try? getUser(id: 23)) ?? "Anonymous"
print(user)
```

### try? 가 자주 쓰이는 세 경우
1. ```guard let```과의 조합: to exit the current function if the ```try?``` call returns ```nil```.
2. nil coalescing과의 조합: to attempt something or provide a default value on failure
3. 반환값이 없는 throwing function을 호출하는데 성공하던 말던 상관이 없을때:  maybe you’re writing to a log file or sending analytics to a server, for example.

### Optional: When should you use optional try?
에러가 얼마나 중요한지에 따라 옵셔널 트라이를 사용하는것이 장단점이 될 수 있다. 만약 함수가 실패하는 이유는 하나도 중요하지 않고 단지 성공/실패 여부만 중요하다면 optional try를 쓰는 것이 좋다. 왜냐면 최종적으로 "함수 작동했나?"에 대한 답을 얻을 수 있기 때문이다. 그래서 아래와 같이 do...catch 를 쓰는것보다 
```swift
do {
    let result = try runRiskyFunction()
    print(result)
} catch {
    // it failed!
}
```
if let... try?를 사용하여 더 간결하게 코드를 작성할 수 있다.
```swift
if let result = try? runRiskyFunction() {
    print(result)
}
```

## Summary: Optionals
- Optionals let us represent the absence of data, which means we’re able to say “this integer has no value” – that’s different from a fixed number such as 0.
- As a result, everything that isn’t optional definitely has a value inside, even if that’s just an empty string.
- Unwrapping an optional is the process of looking inside a box to see what it contains: if there’s a value inside it’s sent back for use, otherwise there will be ```nil``` inside.
- We can use ```if let``` to run some code if the optional has a value, or ```guard let``` to run some code if the optional doesn’t have a value – but with ```guard``` we must always exit the function afterwards.
- The ```nil coalescing operator```, ```??```, unwraps and returns an optional’s value, or uses a default value instead.
- ```Optional chaining``` lets us read an optional inside another optional with a convenient syntax.
- If a function might throw errors, you can convert it into an optional using ```try?``` – you’ll either get back the function’s return value, or ```nil``` if an error is thrown.
