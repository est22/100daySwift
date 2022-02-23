# 100 days of SwiftUI

## variables
naming convention: camelCase
If you can, prefer to use constants rather than variables


## strings

```swift:backslash.swift
let quote = "Then he tapped a sign saying \"Believe\" and walked away."

```

how to write multi strings? ... use ```"""```
```swift:threeQuotes.swift
let movie = """
A day in
the life of an
Apple engineer
"""

```

frequently used functions
1. .count
```swift:count.swift
let nameLength = actor.count
print(nameLength)
```
2. uppercased()
```swift:uppercased.swift
print(result.uppercased())
```
.count에서는 괄호가 필요없지만 uppercased에는 괄호를 써야한다. 그 이유는?
데이터를 읽어야할때는 괄호가 필요하지 않지만, 데이터를 읽어들여야할때는 괄호가 필요하다.

if you’re asking Swift to read some data you don’t need the parentheses, but if you’re asking Swift to do some work you do. That’s not wholly true as you’ll learn later, but it’s enough to get you moving forward for now.


3. hasPrefix() 어두가 이걸로 시작하는지 아는것
lets us know whether a string starts with some letters of our choosing:
```swift:hasPrefix.swift
print(movie.hasPrefix("A day"))
```
4. hasSuffix() 어미가 이걸로 끝나는지 찾는것(확장자에 유용!)
```swift:hasPrefix.swift
print(movie.hasSuffix("A day"))
```print(filename.hasSuffix(".jpg"))



## how to store whole numbers (int)
“integer” is originally a Latin word meaning “whole”
If we were writing that out by hand we’d probably write “100,000,000” at which point it’s clear that the number is 100 million. Swift has something similar: you can use underscores, _, to break up numbers however you want.
```swift:use_underscore_with_long_numbers.swift
let reallyBig = 100_000_000
// Swift doesn’t actually care about the underscores
let reallyBig = 1_00__00___00____00
// reallyBig = 100,000,000
```

tip: you can call ```isMultiple(of:)``` on an integer to find out whether it’s a multiple of another integer.
```swift:isMultiple.swift
let number = 120
print(number.isMultiple(of: 3))
// or can use a number directly if you want
print(120.isMultiple(of: 3))
```

## How to store decimal numbers (decimal)
how swift store floating-point numbers? the only way it can do that is by moving the decimal point around based on the size of the number!
```swift
let number = 0.1 + 0.2
print(number)
```
이렇게 한다면 결과는 it won’t print 0.3. Instead, it will print 0.30000000000000004 – that 0.3, then 15 zeroes, then a 4 because… well, like I said, it’s complex.

the reason floating-point numbers are complex is because computers are trying to use binary to store complicated numbers. For example, if you divide 1 by 3 we know you get 1/3, but that can’t be stored in binary so the system is designed to create very close approximations. It’s extremely efficient, and the error is so small it’s usually irrelevant, but at least you know why Swift doesn’t let us mix Int and Double by accident!



First, when you create a floating-point number, Swift considers it to be a Double. That’s short for “double-precision floating-point number”, it means Swift allocates twice the amount of storage as some older languages would do, meaning a Double can store absolutely massive numbers. 

Second, Swift considers decimals to be a wholly different type of data to integers, which means you can’t mix them together. After all, integers are always 100% accurate, whereas decimals are not, so Swift won’t let you put the two of them together unless you specifically ask for it to happen.


type safety: Swift won’t let us mix different types of data by accident.

```swift
let c = Double(a) + b
```

Many older APIs use a slightly different way of storing decimal numbers, called CGFloat. Fortunately, Swift lets us use regular Double numbers everywhere a CGFloat is expected, so although you will see CGFloat appear from time to time you can just ignore it.



