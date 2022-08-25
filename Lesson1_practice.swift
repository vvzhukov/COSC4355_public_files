// Materials used:
// 1. https://docs.swift.org/swift-book/LanguageGuide/TheBasics.html
// 2. https://docs.swift.org/swift-book/GuidedTour/GuidedTour.html
// 3. https://www.hackingwithswift.com/read/0/14/enumerations

/*
What is Swift?

By Wiki: General-purpose, multi-paradigm, compiled programming language developed by Apple Inc
We may add: Turing complete language.
Can be used to develop hello world apps or fully func OS

Why? When? Who?
- as a replacement for Objective-C
- 2014 first release
- Apple


Important and unique features:
- Does not expose pointers and other unsafe accessors
- Vars are always initialized before use
- Array idxs are checked fro out-of-bounds
- Ints are checked for overflow
- Optionals ensure that nil are handled explicitly
- Auto memory management
- Error handling usually helps you to recover from any failure
- Anonymous functions (closures)
*/

// C/ObjectiveC similar
print("Hello, playground")
// global scope no need in 'main'
// no need in semicolon

// 'var' used to declare variable
var myVar = 40 // integer
myVar = 50 // integer

// 'let' used to declare constants
let myConst = 30 // integer
// value of the const doesn't need
// to be known at the compile time
// must assign value exactly once

// Both const and var should must have
// same type as the value you are assigning

// You may specify the type of the variable
let explicitConst: Double = 70

// Values are never implicitly converted to another type
// Need to convert - make instance of the required type

let label = "Length is "
let length = 40
let fullText1 = label + String(length)

// you may include values in strings using backslash
let fullText2 = "The length is \(length) !"
// even with basic operations
let fullText3 = "The double length is \(2 * length) !"

// three double quotations (""") used for multiple lines
let qutatinos3 = """
The length is \(length) !
The double length is \(2 * length) !
"""

// arrays and dictionaries
var myArray = ["item1", "item2", "item3"]
myArray[0] = "item0"

var myDict = ["key0": "value0", "key1": "value1"]
myDict["key2"] = "value2"

// adding item to array
myArray.append("item4")

// creating empty arraydict
let emptyArray: [String] = []
let emptyDict: [String: Int] = [:]

// also works for inferred type
// set a new value for a var or pass arg to a func
myArray = []
myDict = [:]


// Control flow
// if, switch, for-in, while, repeat-while
// parentheses optional
// braces are required

var totalThirditems = 0
for item in myArray {
    if item == "item3" {
        totalThirditems += 1
    } else {
        print("Item is not #3")
    }
}

// condition should be strict boolean
// can not use constructions like 'if 0 ...' or 'if 1 ...'

// we can use if and let together to work with missing values
// optional either contains value or nit
// we add ? after the type to mark value as optional

var myOptString: String? = "Test"
print(myOptString == nil) // wil give us "false"

var myOptString2: String? = "Test"
if let name = myOptString {
    myOptString2 = "Second optional content: \(name)"
}

// Or we may change myOptString to nil and add else

// Another way to handle optionals is
// to provide defaults using ??

let nickName: String? = nil
let fullName: String = "First Last"
let greetings = "Hi, \(nickName ?? fullName)"

// Switches support any kind of data
let vegetables = "red pepper"
switch vegetables {
case "celery":
    print("hate celery!")
case "cucumber", "tomato":
    print("that is good to add to the salad!")
case let x where x.hasSuffix("pepper"):
    print("is it spicy \(x)?")
default:
    print("Unknown veggies detected!")
}

// Try removing default case. What will be the error?

// Dicts are an unrolled collection
// their keys and values are iterated over in arbitrary order

let myNumbers = [
    "Prime": [2,3,5,7,11,13],
    "Fibbonacci": [1,1,2,3,5,8],
    "Square": [1,4,9,16,25]
]

var largest = 0
for (_, numbers) in myNumbers { // _ may be replaced with var name
    for number in numbers {
        largest = max(largest, number)
    }
}

// while repeats a block until condition changes
var n = 2
while n < 100 {
    n *= 2
}

var m = 2
repeat {
    m *= 2
} while m < 100

// we can also keep idx in a loop by using ...<4 to make idxs range

var total = 0
for i in 0..<4 {
    total += i
}

// Functions
// Use -> to separate parameter names and return types

func greet(person: String, day: String) -> String {
    return "Hello \(person), today is \(day)."
}
greet(person: "Bob", day: "Tuesday")

// we can also use custom argument label before parameter or write _
// to use no arg label
func greet(_ person: String, on day: String) -> String {
    return "Hello \(person), today is \(day)."
}
greet("John", on: "Wednesday")


// we can use tuples to make compound values to return
// multiple values from the function

func calculateStatistics(scores: [Int]) -> (min: Int, max: Int, sum: Int) {
    var min = scores[0]
    var max = scores[0]
    var sum = 0

    for score in scores {
        if score > max {
            max = score
        } else if score < min {
            min = score
        }
        sum += score
    }

    return (min, max, sum)
}
let statistics = calculateStatistics(scores: [5, 3, 100, 3, 9])
print(statistics.sum)
print(statistics.2)

// there also could be nested functions
// nested functions have access to the variables
// that were decleared in the other function
// use nested functions to organize long and complex code
// careful, could be HARD TO MAINTAIN

func returnFifteen() -> Int {
    var y = 10
    func add() {
        y += 5
    }
    add()
    return y
}
returnFifteen()

// functions can return another function as its value (first-class type)
func makeIncrementer() -> ((Int) -> Int) {
    func addOne(number: Int) -> Int {
        return 1 + number
    }
    return addOne
}
var increment = makeIncrementer()
print(increment(7))

// functions can take other functions as arguments
func hasAnyMatches(list: [Int], condition: (Int) -> Bool) -> Bool {
    for item in list {
        if condition(item) {
            return true
        }
    }
    return false
}
func lessThanTen(number: Int) -> Bool {
    return number < 10
}
var numbers = [20, 19, 7, 12]
hasAnyMatches(list: numbers, condition: lessThanTen)

// Func are special case of closures
// blocks of code that could be called later
// access to the scope where the closure has been created
// We can write a closure without a name
// we use 'in' to separate arguments and return type from body

numbers.map({ (number: Int) -> Int in
    let result = 3 * number
    return result
})

// single closure statement
let mappedNumbers = numbers.map({ number in 3 * number })
print(mappedNumbers)
// Prints "[60, 57, 21, 36]"

// we can refer to parameters by number
let sortedNumbers = numbers.sorted { $0 > $1 } // here closure is the single argument, omit the "()"
print(sortedNumbers)
// Prints "[20, 19, 12, 7]"


// Classes

class Shape {
    // missing initializer/constructor
    var numberOfSides = 0
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
}

// Create instance of a class
var shape = Shape()
shape.numberOfSides = 7
var shapeDescription = shape.simpleDescription()

// Lets now include initializer
class NamedShape {
    var numberOfSides: Int = 0
    var name: String

    init(name: String) { // initializer
        self.name = name
    }

    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
}



// Methods of a subclass that override the
// superclasses implementation are marked with override

class Square: NamedShape {
    var sideLength: Double

    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 4
    }

    func area() -> Double {
        return sideLength * sideLength
    }

    override func simpleDescription() -> String {
        return "A square with sides of length \(sideLength)."
    }
}
let test = Square(sideLength: 5.2, name: "my test square")
test.area()
test.simpleDescription()

// in addition we can add getters and setters
class EquilateralTriangle: NamedShape {
    var sideLength: Double = 0.0

    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 3
    }

    var perimeter: Double {
        get {
            return 3.0 * sideLength
        }
        set {
            sideLength = newValue / 3.0 // here we can provide explicit name
        }
    }

    override func simpleDescription() -> String {
        return "An equilateral triangle with sides of length \(sideLength)."
    }
}
var triangle = EquilateralTriangle(sideLength: 3.1, name: "a triangle")
print(triangle.perimeter)
// Prints "9.3"
triangle.perimeter = 9.9
print(triangle.sideLength)
// Prints "3.3000000000000003"

// Here initializer follows 3 steps:
// 1. Setting the value of properties that the subclass declares.
// 2. Calling the superclass’s initializer.
// 3. Changing the value of properties defined by the superclass.
//    Any additional setup work that uses methods, getters, or setters
//    can also be done at this point.

// We may run some code before and after setting a new value
// we may use willSet and didSet

// Class below ensures that the side length of its triangle is
// always the same as the side length of its square.

class TriangleAndSquare {
    var triangle: EquilateralTriangle {
        willSet {
            square.sideLength = newValue.sideLength
        }
    }
    var square: Square {
        willSet {
            triangle.sideLength = newValue.sideLength
        }
    }
    init(size: Double, name: String) {
        square = Square(sideLength: size, name: name)
        triangle = EquilateralTriangle(sideLength: size, name: name)
    }
}
var triangleAndSquare = TriangleAndSquare(size: 10, name: "another test shape")
print(triangleAndSquare.square.sideLength)
// Prints "10.0"
print(triangleAndSquare.triangle.sideLength)
// Prints "10.0"
triangleAndSquare.square = Square(sideLength: 50, name: "larger square")
print(triangleAndSquare.triangle.sideLength)
// Prints "50.0"


// Enemurators and structures

// enum creates enumeration

// function to define current weather, accepts string
func getHaterStatus(weather: String) -> String? {
    if weather == "sunny" {
        return nil
    } else {
        return "Hate"
    }
}
// string coud be a bad choice for that type of data (categorical variable)
// we may solve the problem using enum
enum WeatherType {
    case sun, cloud, rain, wind, snow
}

func getHaterStatus(weather: WeatherType) -> String? {
    if weather == WeatherType.sun { // 'weather == .sun' will do the same
        return nil
    } else {
        return "Hate"
    }
}

getHaterStatus(weather: WeatherType.cloud)


// we can store additional values in enumerators
enum WeatherType2 {
    case sun
    case cloud
    case rain
    case wind(speed: Int)
    case snow
}

// Swift lets us use extra condition for switch/case
// so the case will match if only conditions are true
func getHaterStatus(weather: WeatherType2) -> String? {
    switch weather {
    case .sun:
        return nil
    case .wind(let speed) where speed < 10: // create a const to reference
                                            // use where to check
        return "meh"
    case .cloud, .wind:
        return "dislike"
    case .rain, .snow:
        return "hate"
    }
}

getHaterStatus(weather: WeatherType2.wind(speed: 5))
// be mindful how you order your cases!


// Swift optionals are implemented using enums with associated values.
// two cases: none and some where some having whatever value is inside the optional

func knockknock(_ caller: String?) {
    print( "Who's there?")
    switch caller {
    case .none:
            print("* silence *")
    case .some (let person):
            print (person)
    }
}

knockknock(nil)
knockknock ( "Orange")

// we can have methods associate with enumerations
enum Rank: Int {
    case ace = 1
    case two, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king

    func simpleDescription() -> String {
        switch self {
        case .ace:
            return "ace"
        case .jack:
            return "jack"
        case .queen:
            return "queen"
        case .king:
            return "king"
        default:
            return String(self.rawValue)
        }
    }
}
let ace = Rank.ace
print(ace)
let aceRawValue = ace.rawValue
print(aceRawValue)
