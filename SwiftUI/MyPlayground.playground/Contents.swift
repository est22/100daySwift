let names = ["Vincent": "van Gogh", "Pablo": "Picasso", "Claude": "Monet"]
let surnameLetter = names["Vincent"]?.first?.uppercased()
let surnameLetter = names["Vincent"]?.first?.uppercased() ?? "?"
