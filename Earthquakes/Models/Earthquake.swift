struct Earthquake: Decodable, Hashable {
    let datetime: String
    let magnitude: Double
    let lat: Double
    let lng: Double
    let depth: Double
    let src: String
    let eqid: String
}

struct Earthquakes: Decodable {
    let earthquakes: [Earthquake]
}
