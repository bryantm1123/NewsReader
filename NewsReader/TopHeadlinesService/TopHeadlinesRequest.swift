import Foundation

struct TopHeadlinesRequest: RestRequesting {
    let url: URL
    let method: HTTPMethod = .GET
    let headers: [String : String]
}

struct TopHeadlinesRequestBuilder {
    static func buildRequest(url: URL) throws -> TopHeadlinesRequest {
        guard let apiKey = TopHeadlinesAPI.HeaderValues.apiKey else {
            throw TopHeadlinesRequestError.missingAPIKey
        }
        
        return TopHeadlinesRequest(
            url: url,
            headers: [TopHeadlinesAPI.HeaderKeys.xAPIKey : apiKey]
        )
    }
}

enum TopHeadlinesRequestError: Error {
    case missingAPIKey
}
