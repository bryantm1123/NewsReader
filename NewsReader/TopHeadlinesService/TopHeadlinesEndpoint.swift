import Foundation

class TopHeadlinesEndpoint: EndpointProtocol {
    enum QueryItemKeys: String {
        case country, page, pageSize
    }
    
    enum CountryValues: String {
        case us
    }
    
    enum TopHeadlinesEndpointError: Error {
        case InvalidQueryItemUpdate
    }
    
    let path = "/v2/top-headlines"
    let pageSize = "20" // hard-coded as a requirement
    let page: String
    var queryItems: [String : String]? = [:]
    
    init(page: String = "0") {
        self.page = page
        populateQueryItems()
    }
    
    private func populateQueryItems() {
        queryItems?[QueryItemKeys.country.rawValue] = CountryValues.us.rawValue
        queryItems?[QueryItemKeys.pageSize.rawValue] = pageSize
        queryItems?[QueryItemKeys.page.rawValue] = page
    }
    
    func updateQueryItem(value: String, for key: TopHeadlinesEndpoint.QueryItemKeys) throws {
        switch key {
        case .page:
            queryItems?[QueryItemKeys.page.rawValue] = value
        default:
            throw TopHeadlinesEndpointError.InvalidQueryItemUpdate
        }
    }
    
}
