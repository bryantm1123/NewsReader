struct Article: Decodable {
    let source: Source
    let title: String?
    let description: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

struct Source: Decodable {
    let name: String
}
