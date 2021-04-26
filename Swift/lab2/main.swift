import Foundation

//Functions

func minValue(a: Int, b:Int) -> Int {
    
    if (a<b){
        return a
    }
    else {
        return b
    }
}

func lastDigit(_ number: Int) -> Int{
    return number%10
}

func divides(_ a:Int, _ b:Int) -> Bool{
    
    if (a%b == 0 ){
        return true
    }
    else {
        return false
    }
    
}

func countDivisors(_ a:Int) -> Int{
    
    var counter = 0
    
    for iter in 1...a {
        if (divides(a,iter)) {
            counter+=1
        }    
    } 
    
    return counter
    
}

func isPrime(_ a:Int) -> Bool{
    let num_of_divisors = countDivisors(a)
    if (num_of_divisors == 2){
        return true
    }
    return false
}


print(minValue(a: 3, b: 5))

print(lastDigit(132))

print(divides(10,3))

print(countDivisors(22))

print(isPrime(22))



//Closures

//1
var closure:() -> () = {
    print("I will pass this course with best mark, because Swift is great!")
}

func smartBart(_ n :Int, _ closure: () -> Void ){
    for _ in 0...n {
        closure()
    }
}

smartBart(11, closure)



//2
var numbers =  [10, 16, 18, 30, 38, 40, 44, 50]
let multiples_of_four = numbers.filter{$0%4==0}
print(multiples_of_four)


//3
let largest_number = numbers.reduce(0, {max($0,$1)})
print(largest_number)


//4
var strings = ["Gdansk", "University", "of", "Technology"]
let combined=strings.reduce("",{$0 == "" ? $1 : $0 + " " + $1})
print(combined)


//5
var new_numbers = [1, 2 ,3 ,4, 5, 6]
let output = new_numbers.filter{$0%2 != 0}.map{$0*$0}.reduce(0,{$0+$1})
print(output)



//Tuples

//1
func minimax(_ a :Int, _ b :Int)-> (Int, Int){
    return (a,b)
}

print(minimax(1,2))


//2

var stringsArray = ["gdansk", "university", "gdansk", "university", "university", "of", "technology","technology","gdansk", "gdansk"]

var result = stringsArray.reduce(into: [:]) { counts, word in
    counts[word, default: 0] += 1
}.map{($0.0,$0.1)}

print(result)




//Enums

enum Weekdays: String, CaseIterable   {
    case Monday
    case Tuesday
    case Wednesday
    case Thursday
    case Friday
    case Saturday
    case Sunday
    
    func value() -> Int {
        switch self {
            case .Monday:
                return 1
            case .Tuesday:
                return 2
            case .Wednesday:
                return 3
            case .Thursday:
                return 4
            case .Friday:
                return 5
            case .Saturday:    
                return 6
            case .Sunday: 
                return 7

        }
    }
    
    func mood() -> NSString {
         switch self {
            case .Monday:
                return "😰"
            case .Tuesday:
                return "🥱"
            case .Wednesday:
                return "😴"
            case .Thursday:
                return "😊"
            case .Friday:
                return "🥴"
            case .Saturday:    
                return "🍺"
            case .Sunday: 
                return "🤮"
        }     
    }  
}


for day in Weekdays.allCases {
    print(day, day.value(), day.mood())
}


let poniedzialek = Weekdays.Monday
print(poniedzialek.value())
print(poniedzialek.mood())

















