import Foundation

protocol DataHandling {
    associatedtype Model
    
    func handle(data: Data) throws -> Model
}

struct TopHeadlinesDataHandler: DataHandling {
    typealias Model = [ArticleDTO]
    
    enum TopHeadlinesError: Error {
        case EndpointError(String?, String?)
    }
    
    func handle(data: Data) throws -> [ArticleDTO] {
        let decoded = try JSONDecoder().decode(TopHeadlinesAPIModel.self, from: data)
        
        guard decoded.status == TopHeadlinesStatusCodes.ok.rawValue,
              let articles = decoded.articles else {
            throw TopHeadlinesError.EndpointError(decoded.code, decoded.message)
        }
        
        return articles
    }
}
