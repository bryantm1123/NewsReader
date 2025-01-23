import Foundation

protocol NewsServceProtocol {
    func fetchTopHeadlines(page: Int, pageSize: Int) async throws -> [Article]
}

final class NewsService: NewsServceProtocol {
    
    private var session: URLSession
    private let baseURL = "https://newsapi.org"
    private let apiKey = "2345e71eaacd4316a3609942d36b0530"
    
    enum ServiceError: Error {
        case InvalidURL
        case EndpointError(String?, String?)
    }
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func fetchTopHeadlines(page: Int, pageSize: Int) async throws -> [Article] {
        let endpoint = "/v2/top-headlines"
        let queryItems = [
            URLQueryItem(name: "country", value: "us"),
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "pageSize", value: "\(pageSize)")
        ]
        var urlComponents = URLComponents(string: baseURL + endpoint)
        urlComponents?.queryItems = queryItems
        
        guard let url = urlComponents?.url else { throw ServiceError.InvalidURL }
        
        var request = URLRequest(url: url)
        request.addValue(apiKey, forHTTPHeaderField: "X-Api-Key")
        
        let (data, response) = try await session.data(for: request)
        let decoded = try JSONDecoder().decode(TopHeadlinesAPIModel.self, from: data)
        
        guard decoded.status == TopHeadlinesStatusCodes.ok.rawValue,
               let articles = decoded.articles else {
            throw ServiceError.EndpointError(decoded.code, decoded.message)
        }
        
        return articles
    }
}
