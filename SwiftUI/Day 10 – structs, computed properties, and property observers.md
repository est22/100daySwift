# 100 days of SwiftUI

## 1. How to create your own structs

struct는 이와 같이 생겼다.

```swift

struct Book {
    var title: String
    var author = "Unknown"
    var pageCount = 0
}



struct Album {
    let title: String
    let artist: String
    let year: Int

    func printSummary() {
        print("\(title) (\(year)) by \(artist)")
    }
}
```
Album이라는 새로운 type을 생성하는데, String, Int, Bool, Set 와 같이 data type을 나타낼 때면 첫 글자는 대문자로, 그리고 camel case를 사용한다. 하지만 만약 그 type 내에서 어떤 것을 나타낼때는 첫 글자는 소문자로 camel case를 사용한다. 

```swift
let red = Album(title: "Red", artist: "Taylor Swift", year: 2012)
let wings = Album(title: "Wings", artist: "BTS", year: 2016)

print(red.title) // Red
print(wings.artist) // BTS

red.printSummary() // Red (2012) by Taylor Swift
wings.printSummary() // Wings (2016) by BTS

```
또다른 struct를 생성해볼 수 있다. 

```swift
struct Employee {
    let name: String
    var vacationRemaining: Int

    func takeVacation(days: Int) {
        if vacationRemaining > days {
            vacationRemaining -= days
            print("I'm going on vacation!")
            print("Days remaining: \(vacationRemaining)")
        } else {
            print("Oops! There aren't enough days remaining.")
        }
    }
}
```
하지만 빌드가 안될것이다. 일단 ```let```을 사용해서 사용하면 constant가 된다. 그래서 불변 상수인데 우리가 함수를 정상적으로 호출할 수는 있지만, struct의 data를 변경할 수 없게 된다.

그래서 데이터만 읽는 함수는 괜찮지만, 만약 struct에 속한 데이터를 변경하는 함수는 다음과 같이 특별한 ```mutating``` 키워드로 마크되어야한다.

```swift
mutating func takeVacation(days: Int) {   
```

### properties, methods, instance, and initializer
- Variables and constants that belong to structs are called _properties_.
- Functions that belong to structs are called _methods_.
- When we create a constant or variable out of a struct, we call that an _instance_ – you might create a dozen unique instances of the ```Album``` struct, for example.
- When we create instances of structs we do so using an _initializer_ like this: ```Album(title: "Wings", artist: "BTS", year: 2016)```.

### syntactic sugar
That last one might seem a bit odd at first, because we’re treating our struct like a function and passing in parameters. This is a little bit of what’s called _syntactic sugar_ – Swift silently creates a special function inside the struct called ```init()```, using all the properties of the struct as its parameters. It then automatically treats these two pieces of code as being the same:
```swift
var archer1 = Employee(name: "Sterling Archer", vacationRemaining: 14)
var archer2 = Employee.init(name: "Sterling Archer", vacationRemaining: 14)
```

Swift is intelligent in the way it generates its initializer, even inserting default values if we assign them to our properties. For example, if our struct had these two properties

```swift
let name: String
var vacationRemaining = 14
```

Then Swift will silently generate an initializer with a default value of 14 for ```vacationRemaining```, making both of these valid:
```swift
let kane = Employee(name: "Lana Kane")
let poovey = Employee(name: "Pam Poovey", vacationRemaining: 35)
```

⭐️ Tip: If you assign a default value to a constant property, that will be removed from the initializer entirely. To assign a default but leave open the possibility of overriding it when needed, use a variable property.

 
### Optional: What’s the difference between a struct and a tuple?
Use tuples when you want to return two or more arbitrary pieces of values from a function, but prefer structs when you have some fixed data you want to send or receive multiple times.


### Optional: What’s the difference between a function and a method?
the only real difference is that _methods belong to a type_, such as structs, enums, and classes, _whereas functions do not_. That’s it – that’s the only difference. 

[link](https://www.hackingwithswift.com/quick-start/understanding-swift/whats-the-difference-between-a-function-and-a-method)


### Optional: Why do we need to mark some methods as mutating?

- Marking methods as mutating will stop the method from being called on constant structs, even if the method itself doesn’t actually change any properties. If you say it changes stuff, Swift believes you!
- A method that is not marked as mutating cannot call a mutating function – you must mark them both as mutating.


## 2. How to compute property values dynamically
Structs can have two kinds of property: 

1. a _stored_ property is a variable or constant that holds a piece of data inside an instance of the struct, and 

2. a _computed_ property calculates the value of the property dynamically every time it’s accessed. This means computed properties are a blend of both stored properties and functions: they are accessed like stored properties, but work like functions.

```swift
struct Employee {
    let name: String
    var vacationRemaining: Int
}

var archer = Employee(name: "Sterling Archer", vacationRemaining: 14)
archer.vacationRemaining -= 5
print(archer.vacationRemaining)
archer.vacationRemaining -= 3
print(archer.vacationRemaining)
```
위의 코드는, 초기값인 14라는 중요한 value를 잊어버리게 된다.
우리는 이 코드에 computed property를 사용하도록 할 수 있다. 
```swift
struct Employee {
    let name: String
    var vacationAllocated = 14
    var vacationTaken = 0

    var vacationRemaining: Int { // calculated automatically
        vacationAllocated - vacationTaken
    }
}
```
이제 초기값을 property에 할당함으로써, regular stored property처럼 보인다.
```swift
var archer = Employee(name: "Sterling Archer", vacationAllocated: 14)
archer.vacationTaken += 4
print(archer.vacationRemaining) // 10
archer.vacationTaken += 4
print(archer.vacationRemaining) // 6
```

### getter & setter
우리는 property값들로 보이는것을 읽고있지만, 이면에서는 스위프트가 이 값을 매번 계산하기 위해 코드를 실행하고 있다.

우리는 이 값을 여기에 _write_ 할 순 없다, 왜냐하면 스위프트에게 어떻게 처리되어야하는지 알려준 적이 없기 때문이다. 그러기 위해 우리는 _getter_ 그리고 _setter_를 줄 것이다. 각각 코드를 읽고, 코드를 적는 역할을 한다.

⭐️ ```getter``` : code that reads
⭐️ ```setter``` : code that writes

```swift
var vacationRemaining: Int {
    get {
        vacationAllocated - vacationTaken
    }

    set {
        vacationAllocated = vacationTaken + newValue
    }
}
```

여기서 주목할 것은 ```setter``` 안의 ```newValue``` 인데, 이것은 스위프트가 자동으로 우리에게 준 것이다. 여기에는 유저가 property 에게 할당하려했던 값이 담긴다. getter, setter가 있으면 이제 ```vacationRemaining```을 수정할 수 있다.

```swift
struct Employee {
    let name: String
    var vacationAllocated = 14
    var vacationTaken = 0

    

//    var vacationRemaining: Int {
//        vacationAllocated - vacationTaken
//    }
//}

    var vacationRemaining: Int {
        get {
        vacationAllocated - vacationTaken
        }

        set {
        vacationAllocated = vacationTaken + newValue
        }
    }
}

var archer = Employee(name: "Sterling Archer", vacationAllocated: 14)
archer.vacationTaken += 4
archer.vacationRemaining = 5
print(archer.vacationAllocated)

```


### Optional: When should you use a computed property or a stored property?
Properties let us attach information to structs, and Swift gives us two variations: stored properties, where a value is stashed away in some memory to be used later, and computed properties, where a value is recomputed every time it’s called.


Deciding which to use depends partly on whether your property’s value depends on other data, and partly also on performance. The __performance__ part is easy: if you regularly read the property when its value hasn’t changed, then using a __stored property__ will be much faster than using a computed property. On the other hand, if your property is read very rarely and perhaps not at all, then using a computed property saves you from having to calculate its value and store it somewhere.

When it comes to __dependencies__ – whether your property’s value relies on the values of your other properties – then the tables are turned: this is a place where __computed properties__ are useful, because you can be sure the value they return always takes into account the latest program state.

Lazy properties help mitigate the performance issues of rarely read stored properties, and property observers mitigate the dependency problems of stored properties – we’ll be looking at them soon.


## 3. How to take action when a property changes
### property observers
Swift lets us create _property observers_, which are special pieces of code that run when properties change. These take two forms: a ```didSet``` observer to run when the property just changed, and a ```willSet``` observer to run before the property changed.

### 왜 필요한가?
```swift
struct Game {
    var score = 0
}

var game = Game()
game.score += 10
print("Score is now \(game.score)")
game.score -= 3
print("Score is now \(game.score)")
game.score += 1
```
버그: 마지막 줄에 print문을 해야하는데.. 빠뜨려버렸다. property observer를 통해서라면 이러한 문제를 해결할 수 있다. 

### didSet

```swift

struct Game {
    var score = 0 {
        didSet {
            print("Score is now \(score)")
        }
    }
}

var game = Game()
game.score += 10
game.score -= 3
game.score += 1

```

스위프트는 ```didSet``` 안의 ```oldValue```를 자동으로 부여해준다. 

### willSet
property가 바뀌기 전에 코드를 실행할 수 있는 것이 ```willSet```이다. 
```swift
struct App {
    var contacts = [String]() {
        willSet {
            print("Current value is: \(contacts)")
            print("New value will be: \(newValue)")
        }

        didSet {
            print("There are now \(contacts.count) contacts.")
            print("Old value was \(oldValue)")
        }
    }
}

var app = App()
app.contacts.append("Adrian E")
app.contacts.append("Allen W")
app.contacts.append("Ish S")
```

현업에서는 ```didSet``` >>>> ```willSet``` 이렇게 didSet 이 더 많이 쓰인다. 하지만 ```game.score += 1 ``` 과 같이 사소한 연산들을 property observer에 할당하여 사용하게 하면 너무 과도한 일을 하게 되기때문에 성능이 저하될 수 있으므로 조심해야한다.

### Optional: When should you use property observers?
### Optional: When should you use willSet rather than didSet?

## 4. How to create custom initializers
### memberwise initializer
```swift
struct Player {
    let name: String
    let number: Int
}

let player = Player(name: "Megan R", number: 15)
```
That creates a new ```Player``` instance by providing values for its two properties. Swift calls this the _memberwise initializer_, which is a fancy way of saying an initializer that accepts each property in the order it was defined.

this kind of code is possible because Swift silently generates an initializer accepting those two values, but we could write our own to do the same thing. The only catch here is that you must be careful to distinguish between the names of parameters coming in and the names of properties being assigned.

```swift
struct Player {
    let name: String
    let number: Int

    init(name: String, number: Int) {
        self.name = name // “assign the name parameter to my name property”.
        self.number = number
    }
}
```
By writing ```self.name``` we’re clarifying we mean “the ```name``` property that belongs to my current instance,” as opposed to anything else.

물론 아래와 같이 하여도 된다.
```swift
struct Player {
    let name: String
    let number: Int

    init(name: String) {
        self.name = name
        number = Int.random(in: 1...99)
    }
}

let player = Player(name: "Megan R")
print(player.number)

```
⭐️ 중요한 것은, initializer가 끝날 때 모든 property들이 value를 가져야 한다는 것이다.! 그렇지 않으면 build 실패할 수 있다.

⭐️ initializer 안의 struct에 다른 methods를 호출할 수 있지만, 일단 모든 property에 value를 할당하여야한다.(Although you can call other methods of your struct inside your initializer, you can’t do so before assigning values to all your properties; make sure to be safe)


### Optional: How do Swift’s memberwise initializers work?
1. if any of your properties have default values, then they’ll be incorporated into the initializer as default parameter values. So, if I make a struct like this, then I can create it in either of these two ways:

```swift
struct Employee {
    var name: String
    var yearsActive = 0
}

let roslin = Employee(name: "Laura Roslin")
let adama = Employee(name: "William Adama", yearsActive: 45)
```

2. The second clever thing Swift does is _remove_ the memberwise initializer if you create an initializer of your own.
```swift
struct Employee {
    var name: String
    var yearsActive = 0

    init() {
        self.name = "Anonymous"
        print("Creating an anonymous employee…")
    }
}
```

With that in place, I could no longer rely on the memberwise initializer, so this would no longer be allowed:

```swift
let roslin = Employee(name: "Laura Roslin")
```

So, as soon as you add a custom initializer for your struct, the default memberwise initializer goes away. If you want it to stay, move your custom initializer to an __extension__, like this:

```swift
struct Employee {
    var name: String
    var yearsActive = 0
}

extension Employee {
    init() {
        self.name = "Anonymous"
        print("Creating an anonymous employee…")
    }
}

// creating a named employee now works
let roslin = Employee(name: "Laura Roslin")

// as does creating an anonymous employee
let anon = Employee()
```


### Optional: When would you use self in a method?
By far the most common reason for using self is inside an initializer, where you’re likely to want parameter names that match the property names of your type, like this:

```swift
struct Student {
    var name: String
    var bestFriend: String

    init(name: String, bestFriend: String) {
        print("Enrolling \(name) in class…")
        self.name = name
        self.bestFriend = bestFriend
    }
}
```
if you don't use it, then it gets a little clumsy adding some sort of prefix


```swift
struct Student {
    var name: String
    var bestFriend: String

    init(name studentName: String, bestFriend studentBestFriend: String) {
        print("Enrolling \(studentName) in class…")
        name = studentName
        bestFriend = studentBestFriend
    }
}
```
Outside of initializers, the main reason for using ```self``` is because we’re in a closure and Swift requires it so we’re clear we understand what’s happening. This is only needed when accessing ```self``` from inside a closure that belongs to a class, and Swift will refuse to build your code unless you add it.
