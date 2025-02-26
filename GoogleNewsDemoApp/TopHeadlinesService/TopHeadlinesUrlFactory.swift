import Foundation

struct TopHeadlinesUrlFactory {
    static func makeTopHeadlinesUrl(page: Int, pageSize: Int) -> URL? {
        var urlComponents = URLComponents(string: API.baseURL + API.TopHeadlines.endpoint)
        urlComponents?.queryItems = API.TopHeadlines.queryItems(page: page, pageSize: pageSize)
        
        return urlComponents?.url
    }
}
