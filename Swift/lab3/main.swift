import Foundation


public struct User {
    var id : Int
    var latitude : Double
    var longitude : Double
    init(id: Int, latitude : Double, longitude : Double){
        self.id = id
        self.latitude = latitude
        self.longitude = longitude
    }

    
}

public enum Rating : Double  { //Double : Comparable
    case empty
    case one
    case two
    case three
    case four
    case five

       public static func > (a: Rating, b: Rating) -> Bool {
        return a.rawValue > b.rawValue
    }

    /*
 func value() -> Double {
        switch self {
            case .one:
                return 1.0
            case .two:
                return 2.0
            case .three:
                return 3.0
            case .four:
                return 4.0
            case .five:
                return 5.0
        }
*/

  
}



public enum LocationType : String 
{ 
    case empty
    case restaurant
    case pub
    case museum
    case monuments
}

public struct Location 
{
    var id : Int
    var type : LocationType
    var name : String
    var rating : Rating
    init(id: Int, type: LocationType, name: String, rating: Rating)
    {
        self.id = id
        self.type = type
        self.name = name
        self.rating = rating
    }
  
    init()
    {
        self.id = -1
        self.type = LocationType.empty
        self.name = "tmp"
        self.rating = Rating.empty
    }

}

public struct City 
{
    var id : Int
    var name : String
    var description : String
    var latitude : Double
    var longitude : Double
    var keywords : [String]
    var locations : [Location]? 

    init( id : Int, name : String, description : String, latitude : Double, longitude : Double, keywords : [String], locations : [Location] )
    {
        self.id = id
        self.name = name
        self.description = description
        self.latitude = latitude
        self.longitude = longitude
        self.keywords = keywords
        self.locations = locations
        
    }
    init(latitude: Double, longitude: Double, locations: [Location])
    {
        self.id = -1
        self.name = "tmp"
        self.description = "tmp"
        self.latitude = latitude
        self.longitude = longitude
        self.keywords = ["tmp"]
        self.locations = locations
    }
}




func findByName(_ cities : Array<City>, _ name : String) -> Array<City> 
{
    var result = Array<City>()
        for item in cities 
        {
            if item.name == name 
            {
                result.append(item)
            }
        }
        return result
}

func findByKeyword(_ cities : Array<City>, _ searched_keyword : String) -> Array<City> 
{
    var result = Array<City>()
    for item in cities 
    {
        if item.keywords.contains(searched_keyword)  
        {
            result.append(item)
        }
    }
    return result
}

func calcDistance(_ city_a : City, _ city_b : City) -> Double 
{   
    func toRadians (_ location : Double) -> Double{
        return ( (location * .pi) / 180.0)
    }


    let delta_longitude = toRadians(city_b.longitude - city_a.longitude)
    let delta_latitude = toRadians((city_b.latitude - city_a.latitude )) 
    let a = sin(delta_latitude/2) * sin(delta_latitude/2) + cos(toRadians(city_a.latitude)) * cos(toRadians(city_b.latitude)) * sin(delta_longitude/2) * sin(delta_longitude/2)
    return (6371.0 * 2 * atan2( sqrt(a), sqrt(1-a) ))

}

func findClosestAndFurthestCity(_ user : User, _ cities : Array<City>) -> ((String, Double),( String, Double))
{
    var distanses : Array<(String, Double)> = []
    var curr_dist :  Double
    var y : Double = user.longitude
    var x : Double = user.latitude

    //create a fake list of locations and temporary city
    //to spawn a temporary city next to user and use it for calculation
    var fake_one:[Location] = [Location()]
    var tmp_city = City(latitude: x,longitude: y, locations: fake_one)


    for item in cities 
    { 
        curr_dist = calcDistance(tmp_city, item)
        distanses.append((item.name,curr_dist ))   
    }

    func get_distance(_ c1 : (String, Double), _ c2 : (String, Double) ) -> Bool 
    {
        return c1.1 > c2.1
    }

    let furthest : (String, Double)! = distanses.sorted(by: get_distance)[0]
    let close : (String, Double)! = (distanses.sorted(by: get_distance).last)
    return ((close.0, close.1), (furthest.0,furthest.1))
}

func furthestSpread(_ cities : Array<City> ) -> (String, String, Double)
{
    var cities_and_distances : Array<(String, String, Double)> = []
    var dist : Double = 0.0
    var max_dist : Double = 0.0
    for i in cities 
    {   
        
        for j in cities //jak tu zrobic, zeby zaczac od j = i a nie od zera zawsze?
        {
            dist = calcDistance(i,j)
            if (dist > max_dist) //skroci nasz wektor i przyspueszy dzialanie przy pozniejszym przeszukaniu
            { 
                cities_and_distances.append((i.name, j.name, dist)) 
            }
        }
    }
    func get_distance2(_ c1 : (String, String, Double), _ c2 : (String, String,  Double) ) -> Bool 
    {
         return c1.2 > c2.2
    }
    let sorted : [(String, String, Double)]! = cities_and_distances.sorted(by: get_distance2)

    return(sorted.first!)
}

    func graded_five(_ c1 : (String, String, Double), _ c2 : (String, String,  Double) ) -> Bool 
    {
         return c1.2 < c2.2
    }




func citiesWithFiveStarRatings(_ cities : Array<City>) 
{
   for city in cities {
        var goodLocationsNum: Int = 0

        if let locs = city.locations {
            for loc in locs {
                if loc.rating == Rating.five {
                    goodLocationsNum += 1
                }
            }
        }
        if goodLocationsNum > 0 {
            print("City of ", city.name, " has ", goodLocationsNum, " locations with 5 stars:")
        }
        if let locs = city.locations {

            for loc in locs {
                if loc.rating == Rating.five {
                    print( loc.type, loc.name)
                }
            }
        }
                if goodLocationsNum > 0 {
            print("\n")
        }
    }

}




func citiesWithFiveStarRestaurants(_ cities : Array<City>) {
    for city in cities 
    {
        var goodRestaurantsNum: Int = 0

        if let locs = city.locations {
            for loc in locs {
                if loc.rating == Rating.five && loc.type == LocationType.restaurant{
                    goodRestaurantsNum += 1
                }
            }
        }
        if goodRestaurantsNum > 0 {
      print("City of ", city.name, " has ", goodRestaurantsNum, " restaurants with 5 stars:")
           
       }
        if let locs = city.locations {
           

            for loc in locs {
                if loc.rating == Rating.five && loc.type == LocationType.restaurant{
                    print( loc.name)
                }
            }
        }
        if goodRestaurantsNum > 0 
        {
        print("\n")
           
        }      
    
    }


}



func listAllLocationsOfCityInOrder(_ city : City)  {
    print("locations related with ", city.name, " in order: ")

 if var locs = city.locations {
        locs.sort{
            (lhs: Location, rhs: Location) in return lhs.rating > rhs.rating
        }
        for loc in locs {
            print( loc.name, "rating: ", loc.rating )
        }
    }


}
//Gdansk
var Eliksir = Location(id: 0, type: LocationType.restaurant, name: "Eliksir", rating: Rating.five)
var Tutam = Location(id: 1, type: LocationType.restaurant, name: "Tutam", rating: Rating.five)
var AvocadoVeganBistro = Location(id: 2, type: LocationType.restaurant, name: "Avocado Vegan Bistro", rating: Rating.four)
var KrowarzywaGda = Location(id: 3, type: LocationType.restaurant, name: "Krowarzywa", rating: Rating.three)
var MuseumOfSecondWorldWar = Location(id: 4, type: LocationType.museum, name: "Muzeum Drugiej Wojny Swiatowej", rating: Rating.four)
var EuropejskieCentrumSolidarnosci = Location(id: 5, type: LocationType.museum, name: "Europejskie Centrum Solidarnosci", rating: Rating.five)
var Westerplatte = Location(id: 6, type: LocationType.monuments, name: "Westerplatte", rating: Rating.four)
var StareMiastoGdansk = Location(id: 7, type: LocationType.monuments, name: "Stare Miasto Gdansk", rating: Rating.five)
var GameOver = Location(id: 8, type: LocationType.pub, name: "Game Over", rating: Rating.four)
var Brudershaft = Location(id: 9, type: LocationType.pub, name: "Brudershaft", rating: Rating.one)

var lokacjeGdanska: Array<Location> = [Eliksir, Tutam, AvocadoVeganBistro, KrowarzywaGda, MuseumOfSecondWorldWar, EuropejskieCentrumSolidarnosci, Westerplatte, StareMiastoGdansk, GameOver, Brudershaft ]

var Gdansk = City(id: 1, name: "Gdańsk", description: "", latitude: 54.356030, longitude: 18.646120, keywords: ["tourism, sea, old-town, airport"], locations: lokacjeGdanska) 


//Warsaw
var Belvedere = Location(id: 10, type: LocationType.restaurant, name: "Belvedere", rating: Rating.five)
var AtelierAmaro = Location(id: 11, type: LocationType.restaurant, name: "Ateliere Amaro", rating: Rating.five)
var DzirkaOdKlucza = Location(id: 12, type: LocationType.restaurant, name: "Dziurka Od Klucza", rating: Rating.four)
var Krowarzywa = Location(id: 13, type: LocationType.restaurant, name: "Krowarzywa", rating: Rating.three)
var Polin = Location(id: 14, type: LocationType.museum, name: "POLIN Muzeum Historii Żydów Polskich", rating: Rating.four)
var MuzeumNeonow = Location(id: 15, type: LocationType.museum, name: "Warszawskie Muzeum Neonow", rating: Rating.five)
var PomnikBohaterowGetta = Location(id: 16, type: LocationType.monuments, name: "Pomnik Bohaterow Getta", rating: Rating.four)
var KolumnaZygmunta = Location(id: 17, type: LocationType.monuments, name: "Kolumna Zygmunta", rating: Rating.five)
var SameKrafty = Location(id: 18, type: LocationType.pub, name: "Same Krafty", rating: Rating.four)
var Borpince = Location(id: 19, type: LocationType.pub, name: "Borpince", rating: Rating.one)

var lokacjeWarszawy: Array<Location> = [Belvedere, AtelierAmaro, DzirkaOdKlucza, Krowarzywa, Polin, MuzeumNeonow, PomnikBohaterowGetta, KolumnaZygmunta, SameKrafty, Borpince ]

var Warsaw = City(id: 2, name: "Warsaw", description: "", latitude: 52.229675, longitude: 21.012230, keywords: ["airport, old-town, tourism, capital, big, shops"], locations: lokacjeWarszawy) 
var alsoWarsaw = City(id: 3, name: "Warsaw", description: "", latitude: 52.229675, longitude: 21.012230, keywords: ["airport, old-town, tourism, capital, big, shops"], locations: lokacjeWarszawy) 


//Torun
var Manekin = Location(id: 20, type: LocationType.restaurant, name: "Manekin", rating: Rating.five)
var Luizjana = Location(id: 21, type: LocationType.restaurant, name: "Luizjana SteakHouse", rating: Rating.four)
var Widelec = Location(id: 22, type: LocationType.restaurant, name: "Widelec", rating: Rating.four)
var Loft79 = Location(id: 23, type: LocationType.restaurant, name: "Loft79", rating: Rating.three)
var MuseumPiernikow = Location(id: 24, type: LocationType.museum, name: "Muzeum Piernikow", rating: Rating.four)
var NiewidzialnyDom = Location(id: 25, type: LocationType.museum, name: "Niewidzialny Dom", rating: Rating.five)
var PomnikKopernika = Location(id: 26, type: LocationType.monuments, name: "Pomnik Mikołaja Kopernika", rating: Rating.four)
var PiesFilus = Location(id: 27, type: LocationType.monuments, name: "Pies Filus", rating: Rating.five)
var JanOlbracht = Location(id: 28, type: LocationType.pub, name: "Jan Olbracht", rating: Rating.four)
var SzerokaNo9 = Location(id: 29, type: LocationType.pub, name: "Szeroka No 9", rating: Rating.one)

var lokacjeTorunia: Array<Location> = [Manekin, Luizjana, Widelec, Loft79, MuseumPiernikow, NiewidzialnyDom, PomnikKopernika, PiesFilus, JanOlbracht, SzerokaNo9]

var Torun = City(id: 4, name: "Toruń", description: "", latitude: 53.015331, longitude: 18.605700, keywords: ["old-town", "gingerbread", "tourism", "Vistula"], locations: lokacjeTorunia) 



//Krakow
var SaltaReso = Location(id: 30, type: LocationType.restaurant, name: "Salta Reso", rating: Rating.four)
var AdamMickiewiczMonument = Location(id: 31, type: LocationType.monuments, name: "Pomnik Adama Mickiewicza w Krakowie", rating: Rating.four)

var lokacjeKrakowa : Array<Location> = [SaltaReso, AdamMickiewiczMonument]

var Krakow = City(id: 5, name: "Kraków", description: "", latitude: 50.083582, longitude: 19.940198, keywords: ["old-town", "smog", "air", "Vistula"], locations: lokacjeKrakowa) 




//Bydgoszcz
var TrzyGracje = Location(id: 32, type: LocationType.monuments, name: "Trzy Gracje", rating: Rating.four)
var RestauracjaPrzystan = Location(id: 33, type: LocationType.restaurant, name: "Przystan", rating: Rating.three)

var lokacjeBydgoszczy : Array<Location> = [TrzyGracje, RestauracjaPrzystan]

var Bydgoszcz = City(id: 6, name: "Bydgoszcz", description: "", latitude: 53.144299, longitude: 18.010722, keywords: ["unsafe", "death"], locations: lokacjeKrakowa) 

//Wroclaw
var WhiskeyInTheJar =  Location(id: 34, type: LocationType.restaurant, name: "Whiskey In The Jar", rating: Rating.five)
var VinylCafe =  Location(id: 35, type: LocationType.pub, name: "VinylCafe", rating: Rating.three)

var lokacjeWroclawia : Array<Location> = [WhiskeyInTheJar, VinylCafe]

var Wroclaw = City(id: 7, name: "Wrocław", description: "", latitude: 51.12766, longitude: 16.869519, keywords: ["old-town", "Slask", "palace"], locations: lokacjeWroclawia) 


//Poznan
var Ratuszowa =  Location(id: 34, type: LocationType.restaurant, name: "Ratuszowa", rating: Rating.five)
var Rynek95 =  Location(id: 35, type: LocationType.restaurant, name: "Rynek 95", rating: Rating.three)

var lokacjePoznania : Array<Location> = [ Ratuszowa, Rynek95 ]

var Poznan = City(id: 8, name: "Poznań", description: "", latitude: 52.421685, longitude: 16.928568, keywords: ["old-town", "goats", "UAM", "PP"], locations: lokacjePoznania) 

//Tarnow
var CafeTramwaj =  Location(id: 36, type: LocationType.pub, name: "Cafe Tramwaj", rating: Rating.five)
var CzarnySezam =  Location(id: 37, type: LocationType.restaurant, name: "Czarny Sezam", rating: Rating.five)

var lokacjeTarnowa : Array<Location> = [CafeTramwaj, CzarnySezam]

var Tarnow = City(id: 9, name: "Tarnów", description: "", latitude: 50.024505, longitude: 20.981152, keywords: ["tramwaj", "railway"], locations: lokacjeTarnowa) 

//Sopot
var Mariott =  Location(id: 38, type: LocationType.restaurant, name: "Mariott", rating: Rating.five)

var lokacjeSopotu : Array<Location> = [Mariott]

var Sopot = City(id: 10, name: "Sopot", description: "", latitude: 54.441297, longitude: 18.562785, keywords: ["pier", "parties"], locations: lokacjeSopotu) 

//Gdynia
var ChwilaMoment =  Location(id: 39, type: LocationType.restaurant, name: "Chwila Moment", rating: Rating.five)

var lokacjeGdynii : Array<Location> = [ChwilaMoment]

var Gdynia = City(id: 11, name: "Gdynia", description: "", latitude: 54.525864, longitude: 18.529827, keywords: ["pier", "shipyard"], locations: lokacjeGdynii) 

//Katowice
var MuzeumSlaskie =  Location(id: 40, type: LocationType.museum, name: "Muzeum Śląskie", rating: Rating.five)

var lokacjeKatowic : Array<Location> = [MuzeumSlaskie]

var Katowice = City(id: 12, name: "Poznań", description: "", latitude: 50.287584, longitude: 19.015974, keywords: ["coal", "silesia"], locations: lokacjeKatowic) 

//Zamosc
var Mazagran =  Location(id: 41, type: LocationType.restaurant, name: "Mazagran", rating: Rating.four)

var lokacjeZamoscia : Array<Location> = [Mazagran]

var Zamosc = City(id: 13, name: "Zamość", description: "", latitude: 50.739062, longitude: 23.260811, keywords: ["Jan", "Zamoysky"], locations: lokacjeZamoscia) 

//Kielce
var Solna12 =  Location(id: 42, type: LocationType.restaurant, name: "Solna 12", rating: Rating.five)

var lokacjeKielc : Array<Location> = [Solna12]

var Kielce = City(id: 14, name: "Kielce", description: "", latitude: 50.88051, longitude: 20.630961, keywords: ["dworek", "Sienkiewicza"], locations: lokacjeKielc) 

//Bialystok
var SztukaMiesa =  Location(id: 43, type: LocationType.restaurant, name: "Ratuszowa", rating: Rating.five)

var lokacjeBialegostoku : Array<Location> = [SztukaMiesa]

var Bialystok = City(id: 15, name: "Białystok", description: "", latitude: 53.156653, longitude: 23.13859, keywords: ["Kurier", "MedicalUniversity"], locations: lokacjeBialegostoku) 

//Leba
var ZakatekKlary =  Location(id: 44, type: LocationType.restaurant, name: "Zakatek Klary", rating: Rating.five)

var lokacjeLeby : Array<Location> = [ ZakatekKlary ]

var Leba = City(id: 16, name: "Łeba", description: "", latitude: 54.769009, longitude: 17.561654, keywords: [ "pier"], locations: lokacjeLeby) 

//Kolobrzeg
var Oceanarium =  Location(id: 45, type: LocationType.museum, name: "Oceanarium", rating: Rating.five)

var lokacjeKolobrzegu: Array<Location> = [ Oceanarium ]

var Kolobrzeg = City(id: 17, name: "Kołobrzeg", description: "", latitude: 54.188155, longitude: 15.574502, keywords: [ "pier"], locations: lokacjeKolobrzegu) 

//Kalisz
var TuttiSanti =  Location(id: 46, type: LocationType.restaurant, name: "Tutti Santi", rating: Rating.five)

var lokacjeKalisza : Array<Location> = [ TuttiSanti ]

var Kalisz = City(id: 18, name: "Kalisz", description: "", latitude: 51.784834, longitude: 18.079389, keywords: [ "Ryszard"], locations: lokacjeKalisza) 

//Radom
var Matrioszka =  Location(id: 47, type: LocationType.restaurant, name: "Matrioszka", rating: Rating.five)

var lokacjeRadomia : Array<Location> = [ Matrioszka ]

var Radom = City(id: 19, name: "Radom", description: "", latitude: 51.416338, longitude: 21.147319, keywords: ["Łucznik"], locations: lokacjeRadomia) 

//Plock
var BrowarTumski =  Location(id: 48, type: LocationType.pub, name: "Browar Tumski", rating: Rating.five)

var lokacjePlocka : Array<Location> = [ BrowarTumski ]

var Plock = City(id: 20, name: "Plock", description: "", latitude: 52.54379, longitude: 19.693115, keywords: [ "Vistula", "festival"], locations: lokacjePlocka) 




var Cities : Array<City> = [Torun, Warsaw, alsoWarsaw, Gdansk, Krakow, Bydgoszcz, Wroclaw, Poznan, Plock, Radom, Kalisz, Kolobrzeg, Leba, Bialystok, Kielce, Zamosc, Katowice, Gdynia, Sopot, Tarnow ]



print("All towns named 'Warsaw':")
var warsaws = findByName(Cities, "Warsaw")
for i in warsaws{
    print(i.name, " with ID: ", i.id)
}


var citiesWithPieres = findByKeyword(Cities, "pier")
print("\nAll cities with a pier:")
for i in citiesWithPieres{
    print(i.name, " with ID: ",  i.id)
}

print("\nDistance beetween Warsaw and Radom:")
var distance = calcDistance(Warsaw , Radom)
print(distance, " km")

var user : User = User(id: 990624, latitude: 52.653160, longitude: 19.059940) 
var closestAndFurthest = findClosestAndFurthestCity(user, Cities)
print("\nCities closest and farthest from the user [in km]:")
print(closestAndFurthest)

var farthestSpreadCities = furthestSpread(Cities)
print("\nCities the most spreaded apart: [in km]:\n")
print(farthestSpreadCities)


citiesWithFiveStarRatings(Cities)
print("\n\n")
citiesWithFiveStarRestaurants(Cities)
print("\n\n")
listAllLocationsOfCityInOrder(Torun)
