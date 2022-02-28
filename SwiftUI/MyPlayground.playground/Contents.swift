//struct Book {
//    var name: String
//}
//
//func buy(_ book: Book) {
//    print("I'm buying \(book.name)")
//}


protocol Purchaseable {
    var name: String { get set }
}


func buy(_ item: Purchaseable) {
    print("I'm buying \(item.name)")
}


struct Book: Purchaseable {
    var name: String
    var author: String
}

struct Movie: Purchaseable {
    var name: String
    var actors: [String]
}

struct Car: Purchaseable {
    var name: String
    var manufacturer: String
}

struct Coffee: Purchaseable {
    var name: String
    var strength: Int
}

let today = Coffee(name: "Starbucks", strength: 3)
today.buy()

