# 100 days of SwiftUI

## How to store ordered data in arrays

```append()``` 로 배열에 요소를 추가한다.
하지만, make sure your array only ever contains one type of data at a time.

### type safety
swift won't let us mix different types -> 타입 명시
```swift
let firstBeatle = beatles[0] // String array
let firstNumber = numbers[0] // Int array
let notAllowed = firstBeatle + firstNumber // not allowed
```

```swift
var scores = Array<Int>() // type safety
scores.append(100)
scores.append(80)
scores.append(85)
print(scores[1])

var albums = Array<String>()
albums.append("Folklore")
albums.append("Fearless")
albums.append("Red")

```

### array 선언법
```Array<String>``` 대신 ```[String]``` 이라고도 쓸 수 있다.
```swift
var albums = Array<String>()
var albums = [String]()

```
또는 처음부터 initial values를 집어넣어서 Swift가 스스로 타입을 인식시키도록 할 수 있다.
```swift
var albums = ["Folklore"]

```

### useful functionality that comes with arrays
```.count``` 으로 배열 내 요소 카운트
```remove(at:)``` 특정 인덱스의 아이템 제거
```removeAll()``` 모든 요소 제거
```.contains()``` 특정한 아이템을 포함하는지 확인
```.sorted()``` alphabetically/numerically 정렬한 새로운 배열을 반환
```.reversed()``` 해당 함수를 사용하면, 더이상 단순한 배열이 아니다 
```swift
let presidents = ["Bush", "Obama", "Trump", "Biden"]
let reversedPresidents = presidents.reversed()
print(reversedPresidents) // "ReversedCollection<Array<String>>(_base: ["Bush", "Obama", "Trump", "Biden"])\n"
```
``` shuffle()```


### reversed()
[공식문서 링크](https://developer.apple.com/documentation/swift/array/1690025-reversed)
```swift
func reversed() -> ReversedCollection<Array<Element>>
```
이렇게 하면 해당 배열의 요소들에 필요한 새로운 메모리 공간의 할당 없이 바꿀 수 있다. 
A ```ReversedCollection``` instance wraps an underlying collection and provides access to its elements in reverse order.
```swift
let word = "Backwards"
for char in word.reversed() {
    print(char, terminator: "")
}
// Prints "sdrawkcaB"

```
If you need a reversed collection of the same type, you may be able to use the collection’s sequence-based or collection-based initializer.
⭐️ 위에서 보았다시피 reversed()를 하면 우리가 원하는 대로의 결과를 반환할 수 없다. 원하는 결과대로 반환을 하려면, original variable과 같은 타입을 명시해줘야한다.!!!

```swift
let word = "Backwards"
let reversedWord = String(word.reversed()) // ⭐️ type 명시
print(reversedWord)
// Prints "sdrawkcaB"
```

이 때 시간 복잡도는 O(1) 이다.


### Why does Swift have arrays?
Swift’s strings, integers, Booleans, and Doubles allow us to temporarily store single values, but if you want to store many values you will often use arrays instead.

We read values out of arrays using their numerical position, counting from 0.  This “counting from 0” has a technical term: we can say that Swift’s arrays are zero-based. Swift will automatically crash your program if you attempt to read an array using an invalid index.


## How to store and find data in dictionaries
very often accessing data by its position in the array can be annoying or even dangerous.

```swift
var employee = ["Taylor Swift", "Singer", "Nashville"]

print("Name: \(employee[0])")
employee.remove(at: 1)
print("Job title: \(employee[1])")
print("Location: \(employee[2])")  

```
예를 들어 employee's details들을 포함한 배열이 있고, 그 요소 하나하나에 접근하려면 너무 많은 시간이 걸릴뿐더러, 배열의 인덱스로 요소로 접근하는 것은 항상 그 인덱스가 고정일것이라고 확신할 수 없다. 그러므로 아래와 같이 딕셔너리 타입을 사용하는 것이 편리하다. 

```swift
let employee2 = [
    "name": "Taylor Swift",
    "job": "Singer", 
    "location": "Nashville"
]
```

### optional 
하지만 위와 같이 하여 플레이그라운드에서 실행을 하면 엑스코드는 주의를 준다. (various warnings along the lines of “Expression implicitly coerced from 'String?' to 'Any’”.) 또한, 우리가 원하는 결과가 아닌 

```swift
Optional("Taylor Swift")
Optional("Singer")
Optional("Nashville")

```
이러한 결과를 출력한다. 왜냐하면 ,만약 아래와 같이 우리가 현재 value 값을 가지고 있지 않은 key에 접근하려고 하는 경우를 생각해보자... 그렇다면 스위프트는 무작정 app crash를 하기보다는 "value값을 받을 수는 있지만 아무것도 못받을수도 있어~" 라는 대안으로 대응한다. 스위프는 이러한 것을 ```optional```이라고 한다. because the existence of data is optional - it might be there or it might not. 그래서 이런 코드를 쓰면 위와 같은 경고문들과 같이 "이 데이터 없을 수도 있는데..출력하고 싶은거 확실해?"라고 하면서 물어보는 것이다.

### default 값을 입력~
그래서 옴셔널을 할 때, 만약 키가 존재하지 않는다면 디폴트 값을 주면서 불러들일 수 있다.

```swift
print(employee2["name", default: "Unknown"]) // "Taylor Swift\n"
print(employee2["job", default: "Unknown"]) // "Singer\n"
print(employee2["location", default: "Unknown"]) // "Nashville\n"
```

```swift
let olympics = [
    2012: "London",
    2016: "Rio de Janeiro",
    2021: "Tokyo"
]

print(olympics[2012]) // 경고창과 함께 "Optional("London")\n"
print(olympics[2012, default: "Unknown"]) // "London\n"

```

### dictionary 선언법
```[String: Int]``` 을 명시해주면, key-Strings, values-Integers 의 딕셔너리를 생성한다는 것이다.

```swift
var heights = [String: Int]()
heights["Yao Ming"] = 229
heights["Shaquille O'Neal"] = 216
heights["LeBron James"] = 206
```
each dictionary item must exist at one specific key, dictionaries don’t allow duplicate keys to exist. Instead, if you set a value for a key that already exists, Swift will overwrite whatever was the previous value.
키가 중복되면 스위프트는 값을 덮어쓰기 해버린다.
``` archEnemies["Batman"] = "Penguin" ``` 처럼 rewrite할 수 있다.

### 유용한 함수
```count```, ```removeAll()```


## How to use sets for fast data lookup
```swift
let people = Set(["Denzel Washington", "Tom Cruise", "Nicolas Cage", "Samuel L Jackson"])
```
You might see the names in the original order, but you might also get a completely different order – the set just doesn’t care what order its items come in.

⭐️ set: ```insert()``` 로 추가한다. 왜냐하면.. 자기 맘대로 순서를 정해서 저장하기 때문에. 그 이유는, 최적화된 순서로 아이템을 저장하기 때문이다. 
we aren’t adding an item to the end of the set, because the set will store the items in whatever order it wants.
instead of storing your items in the exact order you specify, sets instead store them in a highly optimized order that makes it very fast to locate items.

```swift
var people = Set<String>()
people.insert("Denzel Washington")
people.insert("Tom Cruise")
people.insert("Nicolas Cage")
people.insert("Samuel L Jackson")
```

### contains()
set에서 ```contains()```을 쓰면 아주 빠르게 반환한다. 배열의 경우, 정말 오래 걸린다.

이 외에도 set 에서 사용할 수 있는 유용한 함수들이 있다.
```swift
let people = Set(["Denzel Washington", "Tom Cruise", "Nicolas Cage", "Samuel L Jackson"])

print(people)
print(people.contains("Tom Cruise")) // true
print(people.count) // 4
print(people.sorted()) // ["Denzel Washington", "Nicolas Cage", "Samuel L Jackson", "Tom Cruise"]

```



### Why are sets different from arrays in Swift?
sets don’t need to store your objects in the order you add them, they can instead store them in a seemingly random order that optimizes them for fast retrieval. 특히 ```contains()``` 함수를 활용할 때 매우 유용하다. (In comparison, arrays must store their items in the order you give them, so to check whether item X exists in an array containing 10,000 items Swift needs to start at the first item and check every single item until it’s found – or perhaps it isn’t found at all.)


## How to create and use enums
```swift
enum Weekday {
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
}
```
That calls the new enum Weekday, and provides five cases to handle the five weekdays.

```swift
var day = Weekday.monday
day = Weekday.tuesday
day = Weekday.friday
```
이와 같이 명시된 case만 할 수 있다. 그래서 "Friday"나 새로운 것은 할 수 없다.  

그리고 enum을 더 쉽게 사용할 수 있는 방법이 두가지 있다.

1. 한줄로 쓰기
```swift
enum Weekday {
    case monday, tuesday, wednesday, thursday, friday
}
```

2. 값을 변수에 집어넣으면 데이터 형식이 고정된다. 
```swift
var day = Weekday.monday
day = .tuesday
day = .friday
```
Swift knows that .tuesday must refer to Weekday.tuesday because day must always be some kind of Weekday.

### 저장하는 방법
Although it isn’t visible here, one major benefit of enums is that Swift stores them in an optimized form – when we say Weekday.monday Swift is likely to store that using a single integer such as 0, which is much more efficient to store and check than the letters M, o, n, d, a, y.

### Why does Swift need enums?
요약: 제한적인 수의 case들이 구체적으로 무엇을 의미하는지 명시적으로 나타내기 쉽다.
빠르게 생성 및 저장할 수 있다.

Well, at their simplest an enum is simply a nice name for a value. We can make an enum called Direction with cases for north, south, east, and west, and refer to those in our code. Sure, we could have used an integer instead, in which case we’d refer to 1, 2, 3, and 4, but could you really remember what 3 meant? And what if you typed 5 by mistake?

So, enums are a way of us saying Direction.north to mean something specific and safe.
