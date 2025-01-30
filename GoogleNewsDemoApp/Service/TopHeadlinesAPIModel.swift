struct TopHeadlinesAPIModel: Decodable {
    let status: String
    let code: String?
    let message: String?
    let articles: [ArticleDTO]?
}

public struct ArticleDTO: Decodable {
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

enum TopHeadlinesStatusCodes: String {
    case ok, error
}
