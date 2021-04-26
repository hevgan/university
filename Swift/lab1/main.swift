import Foundation

//print("Hello World")
print("--------------------------------------------------------------")

print("Strings and Text :")
let imie = "Maciej"
let nazwisko = "Adryan"


let personalia = "\(imie) \(nazwisko)"
//print(personalia)




//EX 
//1
var a = 5
var b = 10
var c = a + b
print(c)
//2

var  gut1 = "Gdansk University of Technology"
var gut2 = gut1.replacingOccurrences(of: "n", with: "⭐️")
print(gut2)


var personalia_inverse = ""

for char in personalia{
    personalia_inverse.insert(char, at: personalia_inverse.startIndex )
}

print(personalia_inverse)
print("--------------------------------------------------------------")

print("Control Flow:")

/*
//Control flow
var optionalName:String? = nil
var greeting = "Hello!"

if let name=optionalName {
    greeting = "Hello, \(name)"
}
print(greeting)
*/
//EX 1 
for _ in 0..<11{
   print("I will pass this course with best mark, because Swift is great!")
}
print()

//EX 2 

let ile = 5
for i in 1...ile {
print(i*i)

}
print()

//ex 3 
let licznik = 10
for _ in 0...licznik{
    for _ in 0...licznik{
        print("@", terminator: "")

    }
    print("")
}

//COLLECTIONS

//arrays
/*
var arrayOfInt = Array<Int>()

arrayOfInt.append(5) //element, not count of elements

print("Array have \(arrayOfInt.count) elements.")

print(arrayOfInt)

arrayOfInt = [] //override array

print(arrayOfInt)


var students: [String] = ["Homer", "Lisa", "Bart"]
var students2 = ["Homer", "Lisa", "Bart"] //shortened


if students.isEmpty {
    print("No students on board😞")
} else {
    print("\(students)")
}


students.append("Marge")

students+=["Apu", "Barney", "Nelson"]

let firstStudent = students[0]

print(firstStudent)


students[0] = "Flanders"
print(students[0])


students.remove(at: 0)
print(students[0])
*/
print("--------------------------------------------------------------")

print("Arrays:")


//Excercise

//1
let numbers = [5,10,20,15,80,13]
var max = numbers[0]
var length = numbers.count-1
for i in 0...length {
    if numbers[i] > max{
        max = numbers[i]
    }
}
print(max)

//2


for i in (0...length).reversed() {
    print(numbers[i], terminator: ", ")
    
}


var allNumbers = [10, 20, 10, 11, 13, 20, 10, 30]
var unique = Set(allNumbers)

print("\n\(unique)")

//sets
/*



var letters = Set<Character>()

letters.insert("A")
letters = []



var musicTypes: Set<String> = ["Rock", "Classic", "Hip hop"]
 
musicTypes.insert("Jazz")


musicTypes.remove("Hip hop")

if musicTypes.contains("Funk") {
    print("Is it your favourite?")
} else {
    print("Still something new to discover.")
}





let oddDigits: Set = [1,3,5,7,9]
let evenDigits: Set = [0,2,4,6,8]
let singleDigitPrimeNumbers: Set = [2,3,5,7]
*/ 

print("--------------------------------------------------------------")
print("Sets: ")

//EX

//1

var number = 10
var divisors = Set<Int>()
//TODO

for i in 1...number{
    if number % i == 0{
        divisors.insert(i)
    } 
}

let sortedDivisors = divisors.sorted()

print(sortedDivisors)





//Dictionaries
/*

var namesOfIntegers = [Int:String]()

namesOfIntegers[16] = "sixteen"

print(namesOfIntegers)

namesOfIntegers = [:] //clear

var airports: [String: String] = ["GDN" : "Gdansk", "NYO": "Stockholm Skavsta"]

airports["SFO"] = "San Francisco Airport"

airports["SFO"] = "San Francisco"

airports["SFO"] = nil //same as airports.removeValue(forKey: "SFO")

*/
print("--------------------------------------------------------------")
print("Dictionaries:")

//Excercise

//1

var flights: [[String: String]] = [
    [
        "flightNumber" : "AA8025",
        "destination" : "Copenhagen"
    ],
    [
        "flightNumber" : "BA1442",
        "destination" : "New York"
    ],
    [
        "flightNumber" : "BD6741",
        "destination" : "Barcelona"
    ]
]


var flightNumbers = Array<String>()

for flight in flights {
    for element in flight {
        if(element.key == "flightNumber"){
            flightNumbers.insert(element.value, at: flightNumbers.endIndex)
        }
        //flightNumbers.insert(dest, at: flightNumbers.endIndex)
    }
}

print(flightNumbers)
print()



//2
var names = ["Hommer","Lisa","Bart"]
var fullNames = [[String:String]]()

for i in 0...names.count-1 {
    let tmp = ["lastname":"Simpson","firstname":names[i]]
    fullNames.insert(tmp, at: fullNames.endIndex)
    print(tmp)
    
}


//print(fullName)




























