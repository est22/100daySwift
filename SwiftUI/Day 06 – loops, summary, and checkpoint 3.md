# 100 days of SwiftUI

## How to use a for loop to repeat work
```swift
let platforms = ["iOS", "macOS", "tvOS", "watchOS"]

for os in platforms {
    print("Swift works great on \(os).")
}
```
여기서 우리는 ```os```를 ```loop variable```이라고 부른다.
이 말고도 fixed range of numbers 안에서도 루프를 순회할 수 있다.
```swift
for i in 1...12 {
    print("5 x \(i) is \(5 * i)")
}
```

_nested loops_도 할 수 있다.
```swift
for i in 1...12 {
    print("The \(i) times table:")

    for j in 1...12 {
        print("  \(j) x \(i) is \(j * i)")
    }

    print()
}
```

⭐️ two range operator에서 ```..<```을 쓰면 마지막 번호를 exclude한다.
이는 __array__ 와 작업할 때 상당히 유용하다.
```swift
for i in 1...5 {
    print("Counting from 1 through 5: \(i)")
}

print()

for i in 1..<5 {
    print("Counting 1 up to 5: \(i)")
} // 4까지만 함. 
```

⭐️ 또한, i나 j 같이 ```loop variable```을 쓰기 싫으면 underscore 를 쓰면 된다.

```swift
var lyric = "Haters gonna"

for _ in 1...5 {
    lyric += " hate"
}

print(lyric)
```


### Why does Swift use underscores with loops?
요약: 바디 안에서 루프 변수를 사용하지 않으면 _ 를 사용한다.
 if you don’t use a loop variable inside the body, Swift will warn you to rewrite it with an underscore.
 ```swift
 let names = ["Sterling", "Cyril", "Lana", "Ray", "Pam"]

for _ in names {
    print("[CENSORED] is a secret agent!")
}
```

### Why does Swift have two range operators?
범위 설정하기 유용하다. 
```print(names[1...])``` = “give me 1 to the end of the array”
 
## How to use a while loop to repeat work
```swift
var countdown = 10

while countdown > 0 {
    print("\(countdown)…")
    countdown -= 1
}

print("Blast off!")
```

while은 루프가 얼마나 돌아야하는지 정확히 모를 때 굉장히 유용하다. 
```Int```, ```Double```가 동시에 가진 ```random(in:)``` 함수는 이 때 매우 유용하다. 예를 들어 20면체 주사위가 있다고 치면 
```swift
// create an integer to store our roll
var roll = 0

// carry on looping until we reach 20
while roll != 20 {
    // roll a new dice and print what it was
    roll = Int.random(in: 1...20)
    print("I rolled a \(roll)")
}

// if we're here it means the loop ended – we got a 20!    
print("Critical hit!")
```
⭐️ ```for``` : when you have a finite amount of data to go thru
⭐️ ```while``` : when you need a custom condition


### When should you use a while loop?
- …the user asks us to stop
- …a server tell us to stop
- …we’ve found the answer we’re looking for
- …we’ve generated enough data
 
## How to skip loop items with break and continue
⭐️ ```continue``` : when you want to skip the rest of the __current__ loop iteration

```swift
let filenames = ["me.jpg", "work.txt", "sophie.jpg", "logo.psd"]

for filename in filenames {
    if filename.hasSuffix(".jpg") == false {
        continue
    }

    print("Found picture: \(filename)")
}
```
⭐️ ```break``` : when you want to skip __all remaining__ loop iterations

```swift
let number1 = 4
let number2 = 14
var multiples = [Int]()

for i in 1...100_000 {
    if i.isMultiple(of: number1) && i.isMultiple(of: number2) {
        multiples.append(i)

        if multiples.count == 10 {
            break
        }
    }
}

print(multiples)
```


### When to use break and when to use continue
```continue```: “I’m done with the current run of this loop”
```break```: “I’m done with this loop altogether, so get out completely.”


## Summary: Conditions and loops

- We use ```if``` statements to check a condition is true. You can pass in any condition you want, but ultimately it must boil down to a Boolean.
- If you want, you can add an ```else``` block, and/or multiple ```else if``` blocks to check other conditions. Swift executes these in order.
- You can combine conditions using ```||```, which means that the whole condition is true if either subcondition is true, or ```&&```, which means the whole condition is true if both subconditions are true.
- If you’re repeating the same kinds of check a lot, you can use a ```switch``` statement instead. These must always be exhaustive, which might mean adding a default case.
- If one of your ```switch``` cases uses ```fallthrough```, it means Swift will execute the following case afterwards. This is not used commonly.
- The ternary conditional operator lets us check WTF: What, True, False. Although it’s a little hard to read at first, you’ll see this used a lot in SwiftUI.
- ```for``` loops let us loop over arrays, sets, dictionaries, and ranges. You can assign items to a loop variable and use it inside the loop, or you can use underscore, _, to ignore the loop variable.
- ```while``` loops let us craft custom loops that will continue running until a condition becomes false.
- We can skip some or all loop items using ```continue``` or ```break``` respectively.
