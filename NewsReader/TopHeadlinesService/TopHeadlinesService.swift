import Foundation

public protocol TopHeadlinesServiceProtocol {
    func fetchTopHeadlines(page: String) async throws -> [ArticleResponse]
}

final class TopHeadlinesService: TopHeadlinesServiceProtocol {
    
    private var endpoint: EndpointProtocol
    private let dataHandler: any DataHandling
    private let restClient: RestClientProtocol
    private let urlBuilder: URLBuilding
    
    
    enum TopHeadlinesServiceError: Error {
        case DataError
        case InvalidEndpoint
        case InvalidURL
    }
    
    init(
        endpoint: EndpointProtocol = TopHeadlinesEndpoint(),
        dataHandler: any DataHandling = TopHeadlinesDataHandler(),
        restClient: RestClientProtocol = RestClient()
    ) {
        self.endpoint = endpoint
        self.dataHandler = dataHandler
        self.restClient = restClient
        self.urlBuilder = TopHeadlinesURLBuilder(
            baseURL: TopHeadlinesAPI.baseURL,
            endpoint: self.endpoint
        )
    }
    
    func fetchTopHeadlines(page: String) async throws -> [ArticleResponse] {
        guard let endpoint = endpoint as? TopHeadlinesEndpoint else {
            throw TopHeadlinesServiceError.InvalidEndpoint
        }
        
        try endpoint.updateQueryItem(value: page, for: TopHeadlinesEndpoint.QueryItemKeys.page)
        
        guard let url = urlBuilder.url else { throw TopHeadlinesServiceError.InvalidURL }
        
        let request = try TopHeadlinesRequestBuilder.buildRequest(url: url)
        
        let (data, _) = try await restClient.execute(request: request)
        
        guard let articles = try dataHandler.handle(data: data) as? [ArticleResponse] else {
            throw TopHeadlinesServiceError.DataError
        }
        
        return articles
    }
}
