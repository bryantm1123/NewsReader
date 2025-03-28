struct TopHeadlinesResponse: Decodable {
    let status: String
    let code: String?
    let message: String?
    let articles: [ArticleResponse]?
}

public struct ArticleResponse: Decodable {
    let source: Source
    let title: String?
    let description: String?
    let urlToImage: String?
    let publishedAt: String?
    let url: String?
}

struct Source: Decodable {
    let name: String
}

enum TopHeadlinesStatusCodes: String {
    case ok, error
}
