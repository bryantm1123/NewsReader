import Foundation

struct TopHeadlinesAPI {
    static let baseURL = "https://newsapi.org"
    
    enum HeaderKeys {
        static let xAPIKey = "X-Api-Key"
    }
    
    enum HeaderValues {
        static var apiKey: String? {
            ProcessInfo.processInfo.environment["API_KEY"]
        }
    }
}
