# 100 days of SwiftUI
## 1. How to limit access to internal data using access control
### access control
- Use ```private``` for “don’t let anything outside the struct use this.”
- Use ```fileprivate``` for “don’t let anything outside the current file use this.”
- Use ```public``` for “let anyone, anywhere use this.”

- ```private(set)``` means “let anyone read this property, but only let my methods write it.” 
```swift
private var learnedSections = Set<String>()
```

__Important__: If you use private access control for one or more properties, chances are you’ll need to create your own initializer.


### Optional: What’s the point of access control?
-> "surface area"



## 2. Static properties and methods

가끔, 진짜 가끔 구조체 자체에 property나 method를 추가하고싶을 때가 있다. (인스턴스 말고)

```swift
struct School {
    static var studentCount = 0 

    static func add(student: String) {
        print("\(student) joined the school.")
        studentCount += 1
    }
}
```
위의 코드에서, studentCount, func add는 School struct 에 속하는 property, method이다. 추가하고 싶을 때 우리는 
```swift
School.add(student: "Taylor Swift")
print(School.studentCount)
```
와 같이 코드를 추가한다. 인스턴스를 생성하지 않고, 그냥 static이기 때문에 바로 접근을 하여 추가할 수 있다. 

그러므로, 우리가 ```studentCount``` property를 메소드에 ```mutating``` 처리를 해주지 않고서도 수정할 수 있다. 

### 만약 우리가 static, non-static과 mix & match를 하고 싶다면?
두 가지 규칙이 있다.
1. static -> non-static ❌
참고할 수 없다.
2. non-static -> static ✅ 
```School.studentCount```, ```Self``` 로 current type에 refer 가능.


```self``` : The current _value_ of a struct      55, "Hello", true
```Self``` : The current _type_ of struct     Int, String, Bool (데이터 타입이니까 대문자)

### 그렇다면 왜 필요한가?
아래와 같이 코드가 있다고 하자.
```swift
struct AppData {
    static let version = "1.3 beta 2"
    static let saveFilename = "settings.json"
    static let homeURL = "https://www.hackingwithswift.com"
}
```
1. 이렇게 데이터를 static properties로 해놓으면 어디서든 ```AppData.version``` 이런 식으로 접근할 수 있다.
2. 내 구조체에 대한 예시들을 생성할 수 있다. SwiftUI가 프리뷰를 보여줄 때(앱 개발할때) 샘플 데이터를 자주 요구하곤 한다. 이럴 때 아래와 같이 static ```example``` property를 프리뷰에 사용할 수 있다.
```swift
struct Employee {
    let username: String
    let password: String

    static let example = Employee(username: "cfederighi", password: "hairforceone")
}
```
내가 ```Employee``` 인스턴스가 필요할때마다, ```Employee.example```을 사용하기만 하면 되니 매우 편리하다.

### Optional: What’s the point of static properties and methods in Swift?

1. One common use for static properties and methods is to store common functionality you use across an entire app. "Unwrap"이라고 앱을 만들었는데, 앱의 URL과 같은 일반적인 정보를 앱스토어에 저장하여 앱이 필요로 하는 곳이라면 어디든 참조할 수 있도록 하고 싶다.

```swift
struct Unwrap {
    static let appURL = "https://itunes.apple.com/app/id1440611372"
}
```

그러면 나는 ```Unwrap.appURL``` 을 사용할 수 있다. ```static``` 키워드가 없이는 나는 ```Unwrap``` 구조체의 인스턴스를 계속 만들어야 할 것이다.




## 3. Summary: Structs
- ```struct``` 를 사용하여 나만의 구조체를 생성할 수 있다. {} 안에 명시헤준다.
- 구조체는 property로 알려진 variable, constants, methods로 알려진 함수들을 가질 수 있다.
- 메소드가 struct의 property를 바꾸려고 하면, ```mutating``` 을 앞에 써주어야한다.
- property를 메모리에 저장하거나, 접근될때마다 값을 바꾸도록 computed property를 생성할 수 있다.
- 구조체 내의 property에게 property observer인 ```didSet```, ```willSet```을 붙여줄 수 있다. property가 바뀔 때 특정한 코드가 항상 실행되어야 할 때 유용하다.
- Initializer는 특수화된 함수라고 할 수 있는데, 구조체 안의 모든 property 이름을 사용하여 모두 initializer가 생성된다.
- custom initializer을 사용할 수 있는데, 이때 반드시 initializer가 끝나기 전에 struct 내의 모든 property는 value가 있어야하고, 다른 methods를 호출하기 전에 그 값을 가져야 한다는 것을 기억해야한다.
- access control으로 어느 property, method가 외부에서 접근가능한지 아닌지 여부를 줄 수 있다.
- 인스턴스를 생성하지 않고 바로 struct 자체에 access control을 할 수 있다. 

