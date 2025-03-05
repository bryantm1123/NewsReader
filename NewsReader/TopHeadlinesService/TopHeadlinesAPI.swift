import Foundation

struct TopHeadlinesAPI {
    static let baseURL = "https://newsapi.org"
    
    enum HeaderKeys {
        static let xAPIKey = "X-Api-Key"
    }
    
    enum HeaderValues {
        static let apiKey = "" // FixME: Add your API key here.
    }
}
