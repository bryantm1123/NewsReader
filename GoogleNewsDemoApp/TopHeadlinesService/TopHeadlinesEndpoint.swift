import Foundation

struct TopHeadlinesEndpoint: EndpointProtocol {
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
    let pageSize = "20" // hard-coded to represent a requirement
    let page: String
    var queryItems = [String : String]()
    
    init(page: String) {
        self.page = page
        populateQueryItems()
    }
    
    private mutating func populateQueryItems() {
        queryItems[QueryItemKeys.country.rawValue] = CountryValues.us.rawValue
        queryItems[QueryItemKeys.pageSize.rawValue] = pageSize
        queryItems[QueryItemKeys.page.rawValue] = page
    }
    
    mutating func updateQueryItem(value: String, for key: TopHeadlinesEndpoint.QueryItemKeys) throws {
        switch key {
        case .page:
            queryItems[QueryItemKeys.page.rawValue] = value
        default:
            throw TopHeadlinesEndpointError.InvalidQueryItemUpdate
        }
    }
    
}
