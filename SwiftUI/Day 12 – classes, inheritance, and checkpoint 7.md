# 100 days of SwiftUI
## 1. How to create your own classes
Swift uses structs for storing most of its data types(String, Int, Double, Array), but there is _another_ way to create custom data types called _classes_.

### class & struct 공통점
- 생성할 때 이름을 지어야한다.
- property, method를 추가할 수 있다. (property observers, access control 포함)
- new instances를 설계(configure)하기 위한 custom initializer를 만들 수 있다.


### class가 struct와 다른 점 5가지
1. 한 클래스와 상관관계를 가진 기능성 측면에서 새로운 클래스를 만들 때 원래의 것으로부터 모든 properties, methods를 다 받아와 시작할 수 있다. 선택적으로 특정한 methods 만 override 하고싶다면, 그것도 가능하다.
2. 첫번째 특징 때문에, 스위프트는 자동으로 클래스를 위한 memberwise initializer 를 생성시키지 않는다. 이 말은 나만의 initializer를 쓰거나 내가 생성하는 모든 properties에 디폴트값을 넣어주어야 한다.
3. 클래스의 인스턴스를 복사할 때, 복사본은 같은 데이터를 공유한다. 그렇기 때문에 하나의 복사본을 수정하면 또다른 복사본 또한 바뀐다.
4. 만약 클래스 인스턴스의 마지막 복사본이 파괴된다면, 스위프트는 선택적으로 _deinitializer_라는 특수한 기능을 실행시킬 수 있다.
5. 만약 내가 class를 constant 로 만들어도, 그들이 변수인 이상 class property를 바꿀 수 있다.

SwiftUI uses classes extensively, mainly for __point 3__: all copies of a class share the same data. This means many parts of your app can share the same information, so that if the user changed their name in one screen all the other screens would automatically update to reflect that change.

### class의 생김새
```swift
class Game {
    var score = 0 {
        didSet {
            print("Score is now \(score)")
        }
    }
}

var newGame = Game()
newGame.score += 10
```
사실, ```struct``` 가 ```class``` 로 바뀐 것 외에는 똑같다. 
하지만 클래스도, 구조체도 각각 활용도가 높고 매우 유용하게 쓰일 것이므로 사용하면서 점차 차이점을 익히는 것이 좋다.


### Optional: Why does Swift have both classes and structs?
* Classes do not come with synthesized memberwise initializers.
* One class can be built upon (“inherit from”) another class, gaining its properties and methods.
* Copies of structs are always unique, whereas copies of classes actually point to the same shared data.
* Classes have deinitializers, which are methods that are called when an instance of the class is destroyed, but structs do not.
* Variable properties in constant classes can be modified freely, but variable properties in constant structs cannot.


### Optional: Why don’t Swift classes have a memberwise initializer?
The main reason is that classes have inheritance, which would make memberwise initializers difficult to work with. Think about it: if I built a class that you inherited from, then added some properties to my class later on, your code would break – all those places you relied on my memberwise initializer would suddenly no longer work.

그래서 author should write their own initializer by hand.


## 2. How to make one class inherit from another
Swift lets us create classes by basing them on existing classes, which is a process known as _inheritance_. 

parent / super class -> child / subclass

상속을 받아오려면, child class의 이름 뒤에 콜론(:)을 쓰고 parent class의 이름을 쓴다. 
```swift
class Employee {
    let hours: Int

    init(hours: Int) {
        self.hours = hours
    }
}
```
여기서 ```Employee```의 두 자식 클래스를 만들거다. 이들은 ```hours``` property와 initializer를 상속받게 된다.

```swift
class Developer: Employee {
    func work() {
        print("I'm writing code for \(hours) hours.")
    }
}

class Manager: Employee {
    func work() {
        print("I'm going to meetings for \(hours) hours.")
    }
}
```
두 개의 자식 클래스들은 ```hours``` 에 directly 접근할 수 있다. 
또한, 자기만의 property를 추가할 수도 있다. 그렇기 때문에 각각에 해당하는 인스턴스를 만들고 ```work()```를 호출하면, 우리는 다른 결과를 얻을 수 있다.
```swift
let robert = Developer(hours: 8)
let joseph = Manager(hours: 10)
robert.work()
joseph.work()
```

properties 말고도 methods 도 공유할 수 있다. ```Employee``` 클래스에 하나의 method를 추가해본다. 
```swift
func printSummary() {
    print("I work \(hours) hours a day.")
}
```
그러면 ```Developer``` 는 ```Employee```를 상속하므로, 우리는 즉시 ```printSummary()```를 ```Developer```의 인스턴스에서 호출할 수 있다.
```swift
let novall = Developer(hours: 8)
novall.printSummary()
```

### 상속 받은 method를 수정하는 법: override
if a child class wants to change a method from a parent class, you must use ```override``` in the child class’s version.

* 주의사항 
override를 사용하지 않고 메서드를 수정하려고 하면, 스위프트는 빌드를 안해준다.
또한, override를 써놓고선 메서드를 수정 안해놓으면, 이것 역시 스위프트가 빌드해주지 않는다.


만약 unique ```printSummary()``` method를 가지고 싶으면, ```Developer``` class에 아래의 코드를 추가해준다.
```swift
override func printSummary() {
    print("I'm a developer who will sometimes work \(hours) a day, but other times spend hours arguing about whether code should be indented using tabs or spaces.")
}
```

그러면 아래와 같이 이렇게.. 잘 상속되는 것을 볼 수 있다.
```swift
class Employee {
    let hours: Int
    
    init(hours: Int){
        self.hours = hours
    }
    
    func printSummary() {
        print("I work \(hours) hours a day.")
    }
}


class Developer: Employee {
    func work() {
        print("I work \(hours) hours.")
    }
    
    override func printSummary() {
        print("I'm a developer who will sometimes work \(hours) a day, but other times spend hours arguing about whether code should be indented using tabs or spaces.")
    }
}

let robert = Developer(hours:8)
robert.work() // I work 8 hours.
robert.printSummary() // I'm a developer who will sometimes work 8 a day, but other times spend hours arguing about whether code should be indented using tabs or spaces.

```


⭐️ Tip: 만약 내 클래스가 상속을 지원하면 안된다는 것을 확실히 알고 있다면, ```final```을 mark 해준다. 이렇게 하면 클래스 자체는 다른 것들로부터 상속을 해올 수는 있지만, 내 클래스가 다른 클래스들에게 상속해줄 수는 없다. 어떠한 자식 클래스도 final class를 부모 클래스로 가질 수 없다.



## 3. How to add initializers for classes
클래스의 initializer는 구조체의 initializer보다 더 복잡하다. 
자식 클래스가 custom initializer가 있다면, 그것을 설정하는게 끝났을 때 부모 클래스의 initializer를 반드시 불러야한다. 존재한다면.

스위프트는 자동으로 memberwise initializer를 생성시키지 않는다. 이것은 상속이 되든 안되든 똑같이 적용된다. 절대. 생성되지 않는다. 자동적으로는. 그렇기 때문에 내가 직접 initializer를 써주거나 클래스의 모든 properties에 해당하는 default values를 줘야한다.

```swift
class Vehicle {
    let isElectric: Bool

    init(isElectric: Bool) {
        self.isElectric = isElectric
    }
}
```
이렇게 클래스를 생성했는데, Vehicle로부터 상속받는 Car class를 만들고싶다. 그렇다면 우리는 아래와 같이 코드를 작성하겠지..
```swift
class Car: Vehicle {
    let isConvertible: Bool

    init(isConvertible: Bool) {
        self.isConvertible = isConvertible
    }
}
```

하지만 스위프트는 코드를 빌드해주지 않을것이다. 왜냐하면 ```Vehicle``` class가 electric인지 아닌지 알아야하는데, 우리가 아직 그것에 대한 value를 주지 않았기 때문이다.

그렇기 때문에 우리가 ```Car``` class에서 ```isElectric```, ```isConvertible``` 를 모두 포함하는 initializer를 만들어줘야한다. 그래서 우리는 아래와 같이 부모클래스에게 run its own initializer 해달라고 요청해야한다.

```swift
class Car: Vehicle {
    let isConvertible: Bool

    init(isElectric: Bool, isConvertible: Bool) {
        self.isConvertible = isConvertible
        super.init(isElectric: isElectric)
    }
}
```
```super```는 ```self```랑 비슷한데, initializer처럼 부모 클래스에 속하는 메서드들까지 호출할 수 있다. 이제 빌드가 정상적으로 되었기 때문에, 우리는 ```Car``` 클래스에 대한 인스턴스를 만들 수 있다.
```swift
let teslaX = Car(isElectric: true, isConvertible: false)
```

⭐️ Tip: 만약 자식클래스가 자신만의 initializer가 없다면, 자동으로 부모 클래스의 initializer를 상속받는다.



## 4. How to copy classes
In Swift, _all copies of a class instance share the same data_, meaning that any changes you make to one copy will automatically change the other copies. This happens because classes are _reference types_ in Swift, which means all copies of a class all refer back to the same underlying pot of data.

```swift
class User {
    var username = "Anonymous"
}

// create an instance
var user1 = User()

// take a copy of user 1
var user2 = user1
// change the username value
user2.username = "Taylor"



print(user1.username) // Taylor
print(user2.username) // Taylor

```

이렇게, 둘 다 같은 결과가 나온다. 버그처럼 보일수도 있으나 , 사실 이것은 정말 중요한 특징(feature)이다.

⭐️ 반면, __structs do not share their data amongst copies__, meaning that if we change class User to struct User in our code we get a different result: it will print “Anonymous” then “Taylor”, because changing the copy didn’t also adjust the original.

### deep copy
만약 내가 클래스 인스턴스로부터 unique copy를 얻고 싶으면 (_deep copy_), 새로운 인스턴스를 생성할 때 좀 손봐야한다. 
```swift
class User {
    var username = "Anonymous"

    func copy() -> User {
        let user = User()
        user.username = username
        return user
    }
}
```


### Optional: Why do copies of a class share their data?
The technical term for this distinction is __“value types vs reference types.”__ Structs are __value types__, which means they hold simple values such as the number 5 or the string “hello”. It doesn’t matter how many properties or methods your struct has, it’s still considered one simple value like a number. On the other hand, classes are __reference types__, which means they refer to a value somewhere else.

It’s hard to overestimate how important this difference is in Swift development. Previously I mentioned that Swift developers prefer to use structs for their custom types, and this copy behavior is a big reason. Imagine if you had a big app and wanted to share a User object in various places – what would happen if one of those places changed your user? If you were using a class, all the other places that used your user would have their data changed without realizing it, and you might end up with problems. But if you were using a struct, every part of your app has its own copy of the data and it can’t be changed by surprise.

## 5. How to create a deinitializer for a class

Swift’s classes can optionally be given a _deinitializer_, which is a bit like the opposite of an initializer in that it gets called when the object is _destroyed_ rather than when it’s created.

### a few small provisos
1. initializer처럼, ```func```를 쓰지 않는다. 이들은 특별해!
2. deinitializer들은 매개변수를 받거나 데이터를 반환하지 않는다. 괄호 안에 쓰지도 않음
3. final copy of a class instance가 파괴될 때 자동으로 호출된다. 
4. 우리는 이들을 직접 호출하지 않고, 시스템에 의해 자동으로 불러진다.
5. 구조체는 deinitializer가 없다, 왜냐하면 복사를 못하기 때문이다.

Exactly _when_ your deinitializers are called depends on what you’re doing, but really it comes down to a concept called _scope_. Scope more or less means “the context where information is available”, and you’ve seen lots of examples already:

우리는 for, while... 이런 loop에서 범위(scope) 설정을 많이 해봐서 친숙하다. when a value exits _scope_ it means in case of struct the data is being destroyed, but in the case of classes it means only one copy of the underlying data is going away - there might still be other copies elsewhere. But when the final copy goes away, then the underlying data is also destroyed, and the memory is returned back to the system.

```swift
class User {
    let id: Int

    init(id: Int) {
        self.id = id
        print("User \(id): I'm alive!")
    }

    deinit {
        print("User \(id): I'm dead!")
    }
}

for i in 1...3 {
    let user = User(id: i)
    print("User \(user.id): I'm in control!")
}

```

이와 같이 loop 안에 User instance를 사용하면, loop iteration이 끝날 때 인스턴스가 destroy된다는것을 볼 수 있다. 

```
User 1: I'm alive!
User 1: I'm in control!
User 1: I'm dead!
User 2: I'm alive!
User 2: I'm in control!
User 2: I'm dead!
User 3: I'm alive!
User 3: I'm in control!
User 3: I'm dead!

```

우리가 여기서 기억해야 할 것은 클래스 인스턴스에서 남아있는 (remaining reference)가 파괴될 때만 deinitializer가 호출된다는 것이다. 만약 우리가 User instances들이 생성될 때 계속 추가하는 식으로 코드를 짰다면, 배열이 다 비워질 때 파괴된다.
```swift
class User {
    let id: Int

    init(id: Int) {
        self.id = id
        print("User \(id): I'm alive!")
    }

    deinit {
        print("User \(id): I'm dead!")
    }
}


var users = [User]()

for i in 1...3 {
    let user = User(id: i)
    print("User \(user.id): I'm in control!")
    users.append(user)
}

print("Loop is finished!")
users.removeAll()
print("Array is clear!")

```

```
User 1: I'm alive!
User 1: I'm in control!
User 2: I'm alive!
User 2: I'm in control!
User 3: I'm alive!
User 3: I'm in control!
Loop is finished!
User 1: I'm dead!
User 2: I'm dead!
User 3: I'm dead!
Array is clear!
```



### Optional: Why do classes have deinitializers and structs don’t?

Behind the scenes Swift performs something called _automatic reference counting_, or _ARC_. ARC tracks how many copies of each class instance exists: every time you take a copy of a class instance Swift adds 1 to its reference count, and every time a copy is destroyed Swift subtracts 1 from its reference count. When the count reaches 0 it means no one refers to the class any more, and Swift will call its deinitializer and destroy the object.

So, the simple reason for why structs don’t have deinitializers is because __they don’t need them__: __each struct has its own copy of its data__, so nothing special needs to happen when it is destroyed.

You can put your deinitializer anywhere you want in your code, but I love this quote from Anne Cahalan: “Code should read like sentences, which makes me think my classes should read like chapters. So __the deinitializer goes at the end, it's the ~fin~ of the class!__”


## 6. How to work with variables inside classes
Swift’s classes work a bit like _signposts_: every copy of a class instance we have is actually a signpost pointing to the same underlying piece of data. Mostly this matters because of the way changing one copy changes all the others, but it also matters because of how classes treat variable properties.


* Taylor
```swift
class User {
    var name = "Paul"
}

let user = User()
user.name = "Taylor"
print(user.name) // Taylor


```

* Paul
```swift
class User {
    var name = "Paul"
}

var user = User()
user.name = "Taylor"
user = User()
print(user.name) // Paul

```

이 경우 variable instance, constant properties를 보이는데, 우리가 원한다면 ```User```를 새로 생성할 순 있지만 이 properties는 바꿀 수 없다는 것을 말한다.

결국, 우리는 네 가지 옵션들을 가지고 있다.
1. Constant instance, constant property – a signpost that always points to the same user, who always has the same name.
2. Constant instance, variable property – a signpost that always points to the same user, but their name can change.
3. Variable instance, constant property – a signpost that can point to different users, but their names never change.
4. Variable instance, variable property – a signpost that can point to different users, and those users can also change their names.

When you see constant properties it means you can be sure neither your current code nor any other part of your program can change it, but as soon as you’re dealing with variable properties – regardless of whether the class instance itself is constant or not – it opens up the possibility that the data could change under your feet.

This is different from structs, because constant structs cannot have their properties changed even if the properties were made variable. Hopefully you can now see why this happens: structs don’t have the whole signpost thing going on, they hold their data directly. This means if you try to change a value inside the struct you’re also implicitly changing the struct itself, which isn’t possible because it’s constant.

One upside to all this is that classes don’t need to use the ```mutating``` keyword with methods that change their data. This keyword is really important for structs because constant structs _cannot_ have their properties changed no matter how they were created, so when Swift sees us calling a ```mutating``` method on a constant struct instance it knows that shouldn’t be allowed.

With classes, how the instance itself was created no longer matters – the only thing that determines whether a property can be modified or not is whether the property itself was created as a constant. Swift can see that for itself just by looking at how you made the property, so there’s no more need to mark the method specially.


### Optional: Why can variable properties in constant classes be changed?
Consider code such as this:
```swift
var number = 5
number = 6
```
We can’t simply define the number 5 to be 6, because that wouldn’t make sense – it would break everything we know about mathematics. Instead, that code removes the existing value assigned to number and gives it the number 6 instead.

That’s how structs work in Swift: when we change one of its properties, we are in fact changing the entire struct. Sure, behind the scenes Swift can do some optimization so that it isn’t really throwing away the whole value every time we change just one part of it, but that’s how it’s treated from our perspective.

So, if changing one part of a struct effectively means destroying and recreating the entire struct, hopefully you can see why constant structs don’t allow their variable properties to be changed – it would mean destroying and recreating something that is supposed to be constant, which isn’t possible.

Classes don’t work this way: you can change any part of their properties without having to destroy and recreate the value. As a result, constant classes can have their variable properties changed freely.

