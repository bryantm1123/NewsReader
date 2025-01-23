struct TopHeadlinesAPIModel: Decodable {
    let status: String
    let code: String?
    let message: String?
    let articles: [Article]?
}

enum TopHeadlinesStatusCodes: String {
    case ok, error
}
