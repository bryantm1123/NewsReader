import Foundation

struct API {
    static let baseURL = "https://newsapi.org"
    
    struct TopHeadlines {
        static let endpoint = "/v2/top-headlines"
        static func queryItems(page: Int, pageSize: Int) -> [URLQueryItem] {
            [
                URLQueryItem(name: QueryItemKeys.country, value: "us"),
                URLQueryItem(name: QueryItemKeys.page, value: String(page)),
                URLQueryItem(name: QueryItemKeys.pageSize, value: String(pageSize))
            ]
        }
    }
    
    enum QueryItemKeys {
        static let country = "country"
        static let page = "page"
        static let pageSize = "pageSize"
    }
    
    enum HeaderKeys {
        static let xAPIKey = "X-Api-Key"
    }
    
    enum HeaderValues {
        static let apiKey = "2345e71eaacd4316a3609942d36b0530"
    }
}
