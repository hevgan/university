class User{
    var id:Int
    var nickname:String
    var posts = Array<LinkedInPost>()
    var comments = Array<Comments>()
    var reactions = Array<Reactions>()
    init( nickname: String, id: Int, database: UserDataBase){
        self.nickname = nickname 
        self.id = id
        database.list.append(self)
    }
    func displayUsersReactions(){
        if self.reactions.count != 0 {
            print("all of", self.nickname, "reactions:")
        }
        for reaction in self.reactions{
            print(reaction.reactionType, "on post by:", reaction.location.author.nickname)
        }
    }
    func displayUsersPosts(){
        if self.posts.count != 0 {
            print("all of", self.nickname, "posts:")
        }
           for post in self.posts{
            print(post)
        }

    }
    func displayUsersComments(){
        if self.comments.count != 0 {
            print("all of", self.nickname, "comments:")

        }
        for comment in self.comments{
            print(comment.contents, "on post: by:", comment.location.author.nickname)
        }

    }

}

class Reactions{
    var reactionType:ReactionType
    var author:User
    var location:LinkedInPost
    init(reactionType:ReactionType, author:User, location: LinkedInPost, database: ReactionDataBase){
        self.reactionType = reactionType
        self.author = author
        self.location = location
        self.author.reactions.append(self)
        self.location.reactions.append(self)
        database.list.append(self)
    }
    func type(){
        print(self.reactionType, "by ", self.author.nickname)
    }
}

class Comments{
    var author:User
    var contents:String
    var reactions = Array<Reactions>()
    var replies = Array<Comments>()
    var location : LinkedInPost 

    init(author: User, contents:String, location:LinkedInPost, database: CommentDataBase){
        self.author = author
        self.contents = contents
        self.location = location
        self.author.comments.append(self)
        self.location.comments.append(self)
        database.list.append(self)
    }
    
    func type(){
        print("\"", self.contents, "\" by",author.nickname )
    }

}

class LinkedInPost {
    var author:User
    var reactions = Array<Reactions>()
    var comments = Array<Comments>()
    var description:String?
    var frame:Bool = false
    var hyperlink:String?

    init( author: User){
        self.author = author
        self.author.posts.append(self)
    }


    func displayReactions(){
          if self.reactions.count > 1{
            print("reactions: ")
          }
          else if (self.reactions.count == 1){
            print("reaction: ")
          }
          for reaction in self.reactions{
           reaction.type()
        }
    }


    func type(separator: Separator){
        separator.type()
        print("\nPost by ", author.nickname,":")
        if self.description != nil{
            print("\"", self.description!, "\"")
            print()
        }

        if self.frame {
            printFrame()  
        }
        if let link = self.hyperlink{
            print("[ resource located at: ",link, "]\n")
        }

        if !comments.isEmpty{
            if comments.count == 1{
                print("1 comment:")
            }
            else {
                print(comments.count , "comments:")
            }
            for comment in comments{
                comment.type()
            }
            print()
        }  

        let counter: Int = reactions.count
        if counter != 0{
            if counter == 1{
                print(counter, "reaction:")
            }
            else{
                    print(counter, "reactions:")
            }
            for reaction in self.reactions{
                reaction.type()
            }
        }
        separator.type()
    }
}

class PostWithPicture: LinkedInPost {
    var picture:String

    init(picture: String, author: User, database: PostDataBase){
        self.picture = picture
        super.init(author: author)
        database.list.append(self)
        self.frame = true
        self.hyperlink = picture
    } 
}

class TextPost: LinkedInPost {
    init(description: String, author: User, database: PostDataBase){
        super.init(author:author)
        self.description = description
        database.list.append(self)
    } 
}

public enum ReactionType{
    case Like
    case Celebrate
    case Love
    case Curious
    case Insightful
    case Support
    case Default

    public var rawValue: String{
        switch self{
            case .Like:
                return "Like"
            case .Celebrate:
                return "Celebrate"
            case .Love:
                return "Love"    
            case .Curious:
                return "Curious"
            case .Insightful:
                return "Insightful"
            case .Support:
                return "Support" 
            case .Default:
                return "Reaction value unset!!!!"             
        }
    }
}

func printFrame(){ //ugliest function ever
    let width:Int = 30
    let height:Int = 10
    for _ in 1...width{
        print("-", terminator:"")
    } 
    print()
    for w in 1...height{
        for k in 1...width{
            if k == 1 {
                print("|", terminator:"")
            }
            else if k == width {
                print("|")
            }
            else
            {
                print(" ", terminator:"")
            }
        }
         if (w == Int(height/2)-1){
                print("|", terminator:"")
                for _ in 1...(width/2)-4{
                    print(" ", terminator:"")
                }
                print("PHOTO", terminator:"")
                for _ in 1...(width/2)-3{
                      print(" ", terminator:"")
                }
                print("|", terminator:"")
                print()
            }
    }
    for _ in 1...width{
        print("-", terminator:"")
    } 
    print()
}

struct  Separator{
    let width:Int = 50
    func type(){
        for _ in 1...width{
        print("_", terminator:"")
    }
    print()
    }

}

class LinkedInDatabase{
}
class UserDataBase:LinkedInDatabase{
    var list = Array<User>()
}
class CommentDataBase:LinkedInDatabase{
    var list = Array<Comments>()
}
class ReactionDataBase:LinkedInDatabase{
    var list = Array<Reactions>()
}
class PostDataBase:LinkedInDatabase{
    var list = Array<LinkedInPost>()
}

var users = UserDataBase()
var comments = CommentDataBase()
var reactions = ReactionDataBase() 
var posts = PostDataBase()

let separator = Separator()


let numernabis = User(nickname: "numernabis" ,id: 0, database: users)
let asteriks = User(nickname: "asteriks" ,id: 1, database: users)
let obeliks = User(nickname: "obeliks", id: 2, database: users)
let skryba = User(nickname: "skryba", id: 3, database: users)
let panoramiks = User(nickname: "panoramiks", id: 4, database: users)

let post1 = TextPost(description: "Ludzie pytaja mnie \"Jak to jest byc skryba? Dobrze?\" Moim zdaniem to nie ma tak, ze dobrze albo ze nie dobrze. Gdybym mial powiedziec, co cenie w zyciu najbardziej, powiedzialbym, ze ludzi. Ekhm... Ludzi, ktorzy podali mi pomocna dlon, kiedy sobie nie radzilem, kiedy bylem sam. I co ciekawe, to wlasnie przypadkowe spotkania wplywaja na nasze zycie. Chodzi o to, ze kiedy wyznaje sie pewne wartosci, nawet pozornie uniwersalne, bywa, ze nie znajduje sie zrozumienia, ktore by tak rzec, ktore pomaga sie nam rozwijac. Ja mialem szczescie, by tak rzec, poniewaz je znalazlem. I dziekuje zyciu. Dziekuje mu, zycie to spiew, zycie to taniec, zycie to milosc. Wielu ludzi pyta mnie o to samo, ale jak ty to robisz?, skad czerpiesz te radosc? A ja odpowiadam, ze to proste, to umilowanie zycia, to wlasnie ono sprawia, ze dzisiaj na przyklad buduje maszyny, a jutro... kto wie, dlaczego by nie, oddam sie pracy spolecznej i bede ot, chocby sadzic... znaczy... marchew.", author: skryba, database: posts)
let reaction1 = Reactions(reactionType:ReactionType.Like , author: panoramiks, location: post1, database: reactions)
let reaction2 = Reactions(reactionType:ReactionType.Support , author: numernabis, location: post1, database: reactions)
let comment1_1 = Comments(author: asteriks, contents:"A pietruszke moze?", location: post1, database: comments)
let comment1_2 = Comments(author: panoramiks, contents:"To jak to w koncu jest byc tym skryba?", location: post1, database: comments)
let comment1_3 = Comments(author: obeliks, contents:"Sa tu jacys Rzymianie?", location: post1, database: comments)
post1.type(separator: separator)




let wanda = User(nickname: "wanda", id: 5, database: users)
let vision = User(nickname: "vision", id: 6, database: users)
let darcy = User(nickname: "darcy", id: 7, database: users)
let agness = User(nickname: "agness", id: 8, database: users)
let monica = User(nickname: "monica", id: 9, database: users)
let marvelcomics = User(nickname: "marvelcomics", id: 10, database: users)
let jonfavreau = User(nickname: "jonfavreau", id: 11, database: users)
let jacschaeffer = User(nickname: "jacschaeffer", id: 12, database: users)

let post2 = PostWithPicture(picture: "https://bit.ly/3syh2XY", author: wanda, database: posts)
let comment2_1 = Comments(author: vision, contents:"What is going on with this place?", location: post2, database: comments)
let comment2_2 = Comments(author: agness, contents:"You guys make such a wonderful couple!", location: post2, database: comments)
let comment2_3 = Comments(author: monica, contents:"What the hell is going on in there?!", location: post2, database: comments)
let comment2_4 = Comments(author: darcy, contents:"OMG she recast Pietro!", location: post2, database: comments)
let reaction2_1 = Reactions(reactionType:ReactionType.Like , author: marvelcomics, location: post2, database: reactions)
let reaction2_2 = Reactions(reactionType:ReactionType.Insightful , author: jonfavreau, location: post2, database: reactions)
let reaction2_3 = Reactions(reactionType:ReactionType.Celebrate , author: jacschaeffer, location: post2, database: reactions)
post2.type(separator: separator)





print()
print("\nall reactions from post 1:")
post1.displayReactions()

obeliks.displayUsersComments()
print("\nall users in the database:")
for user in users.list{
    print(user.nickname)
}
