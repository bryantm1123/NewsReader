import Foundation

struct TopHeadlinesRequest: RestRequesting {
    let url: URL
    let method: HTTPMethod = .GET
    let headers: [String : String]
}

struct TopHeadlinesRequestBuilder {
    static func buildRequest(url: URL) -> TopHeadlinesRequest {
        assert(!TopHeadlinesAPI.HeaderValues.apiKey.isEmpty, "API Key value is empty.")
        
        return TopHeadlinesRequest(
            url: url,
            headers: [
                TopHeadlinesAPI.HeaderKeys.xAPIKey: TopHeadlinesAPI.HeaderValues.apiKey
            ]
        )
    }
}
