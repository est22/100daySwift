# 100 days of SwiftUI

## 1. How to create and use protocols
Protocols are a bit like contracts in Swift: they let us define what kinds of functionality we expect a data type to support. 
```swift
protocol Vehicle {
    func estimateTime(for distance: Int) -> Int
    func travel(distance: Int)
}
```
- We write ```protocol```, and since this is a new type, we need to use camel case starting with an uppercase letter.
- Inside the protocol we list all the methods we require in order for this protocol to work the way we expect.
- These methods do not contain any code inside – there are no function bodies provided here. Instead, we’re specifying the method names, parameters, and return types. You can also mark methods as being throwing or mutating if needed.

프로토콜을 설정하고 나면 we can design types that work with that protocal. we can create new structs, classes, or enums that implement the requirements for that protocol, which is a process we call _adopting_ or _conforming_ to the protocol.

The protocol specifies only a bare minimum. 

If ```Car``` struct conforms to ```Vehicle```, 
```swift
struct Car: Vehicle {
    func estimateTime(for distance: Int) -> Int {
        distance / 50
    }

    func travel(distance: Int) {
        print("I'm driving \(distance)km.")
    }

    func openSunroof() {
        print("It's a nice day!")
    }
}
```
1. 자식클래스를 정의하는것처럼 Car 뒤에 콜론 하고 Vehicle을 써야한다.
2. Vehicle에서 정의한 모든 메서드가 Car에 _정확히_ 존재해야한다. 이름이 다르거나, 다른 매개변수를 받거나 다른 반환 타입을 가지면 안된다.
3. Car 안에 있는 메서드들은 우리가 프로토콜에서 정의했던 메서드들의 실제 결과물이다. 이 경우, 우리의 struct는 대략적인 틀을 제공한다.
4. openSunroof() 메서드는 Vehicle 프로토콜에서 온 것이 아니다. 사실 많은 탈것들은 선루프가 없다. 하지만 괜찮다. 왜냐하면 프로토콜은 only _minimum_ functionality 만 묘사하기 때문에, 필요할 때마다 추가해서 정의할 수 있기 때문이다.

아래에 commute() 함수를 추가했다.

```swift
func commute(distance: Int, using vehicle: Car) {
    if vehicle.estimateTime(for: distance) > 100 {
        print("That's too slow! I'll try a different vehicle.")
    } else {
        vehicle.travel(distance: distance)
    }
}

let car = Car()
commute(distance: 100, using: car)

```
위 코드는 문제없이 작동한다. 하지만 왜 굳이 프로토콜을 추가하냐면,
스위프트는 Vehicle에 순응하는 어떠한 타입이든 estimateTime()과 travel() 메서드를 반드시 implement해야한다는 것을 알고 있다. 그래서 우리에게 Car을 사용하기보단 Vehicle을 매개변수 타입으로 쓰도록 한다.

그래서 우리는 함수를 이렇게 다시 작성할 수 있다.
```swift
func commute(distance: Int, using vehicle: Vehicle) {
```
그리고 Vehicle을 따르는 하나의 구조체를 추가로 생성한다.
```swift
struct Bicycle: Vehicle {
    func estimateTime(for distance: Int) -> Int {
        distance / 10
    }

    func travel(distance: Int) {
        print("I'm cycling \(distance)km.")
    }
}

let bike = Bicycle()
commute(distance: 50, using: bike)
```
여기서, 우리는 이제 commute() 함수에 Car나 Bicycle을 넘길 수 있다. 그리고 그것이 estimateTime() 이나 travel()을 호출할 때, 스위프트는 자동적으로 더 적절한 것을 사용한다. 만약 car에다가 넣으면 "i'm driving"을 하고, 자전거에다가 넣으면 "i'm cycling"이 나올것.

### protocols describe properties
As well as methods, you can also write protocols to describe _properties_ that must exist on conforming types. To do this, write ```var```, then a property name, then list whether it should be readable and/or writeable.

```swift
protocol Vehicle {
    var name: String { get }
    var currentPassengers: Int { get set }
    func estimateTime(for distance: Int) -> Int
    func travel(distance: Int)
}
```
1. A string called ```name```, which must be readable. That might mean it’s a constant, but it might also be a computed property with a getter.
2. An integer called ```currentPassengers```, which must be read-write. That might mean it’s a variable, but it might also be a computed property with a getter and setter.

이제 프로토콜이 더 추가되었으니, Car과 Bicycle이 더이상 프로토콜을 따르지 않을 것이라고 경고를 줄것이다. 그렇기 떄문에 우리는 Car, Bicycle 에다가 다음과 같이 속성(property)들을 각각 추가해준다.

```swift
let name = "Car"
var currentPassengers = 1
```
```swift
let name = "Bicycle"
var currentPassengers = 1
```

먄약에 ```{ get set }```을 사용하면 프로토콜에 순응하지 않는다. 
아무튼 이제 이것에 의존하는 코드를 짤 수 있다. 예를 들어 vehicles를 배열로 받아서 계산하는 함수도 쓸 수 있다.
```swift
func getTravelEstimates(using vehicles: [Vehicle], distance: Int) {
    for vehicle in vehicles {
        let estimate = vehicle.estimateTime(for: distance)
        print("\(vehicle.name): \(estimate) hours to travel \(distance)km")
    }
}
```

프로토콜을 쓰면, ```Vehicle``` protocol 전채를 받을 수 있다. 즉, we can pass in a ```Car```, a ```Bicycle```, or any other struct that conforms to ```Vehicle```, and it will automatically work:
```swift
getTravelEstimates(using: [car, bike], distance: 150)
```
⭐️ Tip: 내가 필요한 만큼 프로토콜에 따를 수 있다. 그냥 콤마로 구분해서 한 줄로 적으면 딘다. 만약 자식클래스가 프로토콜에 따르도록 하고 싶으면 일단 부모클래스의 이름을 먼저 적어주고 그다음 프로토콜을 적어준다. 


### Optional: Why does Swift need protocols?
protocols determine the minimum required functionality, but we can always add more. = protocols let us create blueprints of how our types share functionality, then use those blueprints in our functions to let them work on a wider variety of data.




## 2. How to use opaque return types: ```some```
스위프트는 매우 모호하고 복잡하지만 매우 중요한 opaque return type을 가지고 있다. 이것을 사용하면 우리 코드의 복잡성을 줄여준다. 

```swift

func getRandomNumber() -> Int {
    Int.random(in: 1...6)
}

func getRandomBool() -> Bool {
    Bool.random()
}
```
```Bool.random()```은 true/false 값을 랜덤으로 반환한다. Int, Bool은 모두 ```Equatable```이라는 스위프트 프로토콜을 따르는데, 동등한 것을 위해 비교가능하다는 뜻이다. 이 프로토콜은 ```==```을 쓸 수 있게 해주는 프로토콜이다.`
```swift
print(getRandomNumber() == getRandomNumber())
```
두개의 함수 모두 이 프로토콜을 따르므로 화살표와 같이 표현할 수 있다. 하지만 코드는 작동 안하고 에러메시지를 줄 것이다. “protocol 'Equatable' can only be used as a generic constraint because it has Self or associated type requirements”. 왜 이것이 되지 않는지 이해를 해야 opaque return types를 이해할 수 있다.

앞서 Vehicle protocol을 따른 것들은 서로 interchangeable.
하지만 Int와 Bool은 Equatable 프로토콜에 따르지만 NOT interchangeable. 왜냐하면 ==을 쓸 수 없기 때문이다. 

```swift
func getRandomNumber() -> Equatable {
    Int.random(in: 1...6)
}

func getRandomBool() -> Equatable {
    Bool.random()
}
```

### How to?
함수로부터 프로토콜을 반환하는것은 정보를 숨길 수 있기 때문에 유용하다. 우리의 두 함수를 opaque return types로 업그레이드 시키려면, return type 앞에 ```some``` 키워드를 사용하면 된다.
```swift
func getRandomNumber() -> some Equatable {
    Int.random(in: 1...6)
}

func getRandomBool() -> some Equatable {
    Bool.random()
}
``` 
이제 우리는 ``` getRandomNumber()```을 두 번 호출할 수 있고 그 결과도 ```==```로 비교할 수 있다!!
⭐️ returning ```Vehicle``` means "any sort of Vehicle type but we don't know what", whereas returning ```some Vehicle``` means "a specific sort of Vehicle type but we don't want to say which one.”

⭐️ SwiftUI returns the type ```some View``` = some kinda view screen will be returned but we don't want to have to write out it's mile-long type. = “this is going to send back some kind of view to lay out, but I don’t want to write out the exact thing – you figure it out for yourself.” = Swift knows the real underlying type because that’s how opaque return types work = Swift always knows the exact type of data being sent back, and SwiftUI will use that create its layouts.


## 3. How to create and use extensions
```trimmingCharacters(in:)``` method removes certain kinds of characters from the start or end of a string(most commonly whitespace and new lines)

for example:
```swift
var quote = "   The truth is rarely pure and never simple   "
let trimmed = quote.trimmingCharacters(in: .whitespacesAndNewlines)"
```
The ```.whitespacesAndNewlines``` value comes from Apple’s Foundation API, and actually so does ```trimmingCharacters(in:)```.

but having to call this method is a bit wordy -> write an extension
```swift
extension String {
    func trimmed() -> String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
```
* explanation
1. ```extension``` keyword = "we want to add functionality to an existing type" to Swift
2. which type? comes next => ```String```.
3. open a brace ```{}``` and write code
4. we can use ```self``` here. it autonatically refers to the current string. This is possible because we’re currently in a string extension.

now we can just write the following:
```swift
let trimmed = quote.trimmed()
```

actually we could have used it without an extension like below:
```swift
func trim(_ string: String) -> String {
    string.trimmingCharacters(in: .whitespacesAndNewlines)
}

let trimmed2 = trim(quote)
```
this kind of function is called a _global_ function. but the extension has a number of benefits over the global function.

### Advantages of extension 
1. when typing ```quote.``` , Xcode brings up a list of methods of the string. extra easy to find
2. writing global functions can be rather messsy
3. we can user properties and methods marked with ```private``` access control
4. can modify values easier(directly)
```swift
mutating func trim() {
    self = self.trimmed()
}
```
and the ```quote``` was created as a variable, we can trim it in place like this:
```swift
quote.trim()
```

when we return a new value we used ```trimmed()```, but when we modified the string directly we used ```trim()```.  


```swift
mutating func trim() {
    self = self.trimmed()
}

extension String {
    func trimmed() -> String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
```


⭐️ as if we create an array we can use ```sort()``` in place rather than returning a new copy. (```sorted()``` does)


⭐️ can only add extensions to _computed_ properties! not stored properties. reason: adding new stored properties would affect the actual size of the data types.

### using computed properties
we can break the string up into an array of indiv. lines
```swift
var lines: [String] {
    self.components(separatedBy: .newlines)
}
```

```swift
import Cocoa

extension String {
    func trimmed() -> String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    
    mutating func trim() {
        self = self.trimmed()
    }

    var lines: [String] {
        self.components(separatedBy: .newlines)
    }
    
}

var quote = "   The truth is rarely pure and never simple   "
let trimmed = quote.trimmingCharacters(in: .whitespacesAndNewlines)
quote.trim()



let lyrics = """
But I keep cruising
Can't stop, won't stop moving
It's like I got this music in my mind
Saying it's gonna be alright
"""

print(lyrics.lines.count)
```
### extensions with struct
creating your own initializer means that Swift will no longer provide the memberwise one for us. if we implement a custom initializer inside an _extension_, then Swift _won’t_ disable the automatic memberwise initializer. So, if we wanted our ```Book``` struct to have the default memberwise initializer as well as our custom initializer, we’d place the custom one in an extension

```swift
struct Book {
    let title: String
    let pageCount: Int
    let readingHours: Int
    
    init(title: String, pageCount: Int) {
        self.title = title
        self.pageCount = pageCount
        self.readingHours = pageCount / 50
    }
}

extension Book {
    init(title: String, pageCount: Int) {
        self.title = title
        self.pageCount = pageCount
        self.readingHours = pageCount / 50
    }
}

let letter = Book(title: "JSDF", pageCount: 118, readingHours: 24)

```

## 4. How to create and use protocol extensions
What would happen if we could write extensions on protocols?
```swift
let guests = ["Mario", "Luigi", "Peach"]

if guests.isEmpty == false {
    print("Guest count: \(guests.count)")
}
// or

if !guests.isEmpty {
    print("Guest count: \(guests.count)")
}
```
-> both of them are not easy. we want to say "if not some array is empty?"

we can fix this with a simple extension for ```Array```:
```swift
extension Array {
    var isNotEmpty: Bool {
        isEmpty == false
    }
}
```
⭐️ Xcode's playgrounds run the code from top to bottom so make sure to write extension on the top _before_ where it's used.

now we can write easier code.

```swift
if guests.isNotEmpty {
    print("Guest count: \(guests.count)")
}
```

### Can we do better?
We can list some required methods in a protocol, then add default implementations of those inside a protocol extension. All conforming types then get to use those default implementations, or provide their own as needed.

```Array```, ```Set```, and ```Dictionary``` all conform to a built-in protocol called ```Collection```, through which they get functionality such as ```contains()```, ```sorted()```, r```eversed()```, and more.

if we write an extension on Collection, we can still access isEmpty because it’s required. This means we can change Array to Collection in our code.

```swift
extension Collection {
    var isNotEmpty: Bool {
        isEmpty == false
    }
}

let guests = ["Mario", "Luigi", "Peach"]


if guests.isNotEmpty {
    print("Guest count: \(guests.count)")
}

```

we can now use ```isNotEmpty``` on arrays, sets, and dictionaries, as well as any other types that conform to ```Collection```.


### protocol-oriented programming 
protocol Person {
    var name: String { get }
    func sayHello()
}

// That means all conforming types must add a sayHello() method
extension Person {
    func sayHello() {
        print("Hi, I'm \(name)")
    }
}

// conforming types "can" add their own sayHello() method
struct Employee: Person {
    let name: String
}

// because it conforms to Person, we could use the default implementation we provided in our extension.
let taylor = Employee(name: "Taylor Swift")
taylor.sayHello()


### Optional: When are protocol extensions useful in Swift?
ex) Swift’s arrays have an ```allSatisfy()``` method that returns true if all the items in the array pass a test. this method works on a protocol called ```Sequence```, which all arrays, sets, and dictionaries conform to. This meant the allSatisfy() method immediately became available on all those types, sharing exactly the same code.

* array
```swift
let numbers = [4, 8, 15, 16]
let allEven = numbers.allSatisfy { $0.isMultiple(of: 2) }
```
* set
```swift
let numbers2 = Set([4, 8, 15, 16])
let allEven2 = numbers2.allSatisfy { $0.isMultiple(of: 2) }
```
* dictionary
```swift
let numbers3 = ["four": 4, "eight": 8, "fifteen": 15, "sixteen": 16]
let allEven3 = numbers3.allSatisfy { $0.value.isMultiple(of: 2) }
```

## Summary: Protocols and extensions
- Protocols are like contracts for code: we specify the functions and methods that we required, and conforming types must implement them.
- Opaque return types let us hide some information in our code. That might mean we want to retain flexibility to change in the future, but also means we don’t need to write out gigantic return types.
- Extensions let us add functionality to our own custom types, or to Swift’s built-in types. This might mean adding a method, but we can also add computed properties.
- Protocol extensions let us add functionality to many types all at once – we can add properties and methods to a protocol, and all conforming types get access to them.


## How to get the most from protocol extensions
[link](https://www.hackingwithswift.com/quick-start/beginners/how-to-get-the-most-from-protocol-extensions)

