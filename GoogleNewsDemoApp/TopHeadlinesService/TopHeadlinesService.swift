import Foundation

public protocol TopHeadlinesServiceProtocol {
    func fetchTopHeadlines(page: String) async throws -> [ArticleDTO]
}

final class TopHeadlinesService: TopHeadlinesServiceProtocol {
    
    private var endpoint: EndpointProtocol
    private let dataHandler: any DataHandling
    private let restClient: RESTClientProtocol
    private let urlBuilder: URLBuilding
    
    
    enum TopHeadlinesServiceError: Error {
        case DataError
        case InvalidEndpoint
        case InvalidURL
    }
    
    init(
        endpoint: EndpointProtocol,
        dataHandler: any DataHandling,
        restClient: RESTClientProtocol,
        urlBuilder: URLBuilding
    ) {
        self.endpoint = endpoint
        self.dataHandler = dataHandler
        self.restClient = restClient
        self.urlBuilder = urlBuilder
    }
    
    func fetchTopHeadlines(page: String) async throws -> [ArticleDTO] {
        guard var endpoint = endpoint as? TopHeadlinesEndpoint else {
            throw TopHeadlinesServiceError.InvalidEndpoint
        }
        
        try endpoint.updateQueryItem(value: page, for: TopHeadlinesEndpoint.QueryItemKeys.page)
        
        guard let url = urlBuilder.url else { throw TopHeadlinesServiceError.InvalidURL }
        
        let request = TopHeadlinesRequest(
            url: url,
            headers: [
                BaseAPI.HeaderKeys.xAPIKey: BaseAPI.HeaderValues.apiKey
            ]
        )
        
        let (data, _) = try await restClient.execute(request: request)
        
        guard let articles = try dataHandler.handle(data: data) as? [ArticleDTO] else {
            throw TopHeadlinesServiceError.DataError
        }
        
        return articles
    }
}
