import Foundation

public protocol NewsServiceProtocol {
    func fetchTopHeadlines(page: Int, pageSize: Int) async throws -> [ArticleDTO]
}

final class NewsService: NewsServiceProtocol {
    
    private let restClient: RESTClientProtocol
    private let dataHandler: any DataHandling
    
    enum NewsServiceError: Error {
        case InvalidURL
        case DataError
    }
    
    init(
        restClient: RESTClientProtocol = RESTClient(),
        dataHandler: any DataHandling = TopHeadlinesDataHandler()
    ) {
        self.restClient = restClient
        self.dataHandler = dataHandler
    }
    
    func fetchTopHeadlines(page: Int, pageSize: Int) async throws -> [ArticleDTO] {
        guard let url = TopHeadlinesUrlFactory.makeTopHeadlinesUrl(
            page: page,
            pageSize: pageSize
        ) else {
            throw NewsServiceError.InvalidURL
        }
        
        let request = TopHeadlinesRequest(
            url: url,
            headers: [
                API.HeaderKeys.xAPIKey: API.HeaderValues.apiKey
            ]
        )
        
        let (data, _) = try await restClient.execute(request: request)
        
        guard let articles = try dataHandler.handle(data: data) as? [ArticleDTO] else {
            throw NewsServiceError.DataError
        }
        
        return articles
    }
}
