import Foundation

protocol URLBuilding {
    var baseURL: String { get }
    var endpoint: EndpointProtocol { get }
}

extension URLBuilding {
    var url: URL? {
        var urlComponents = URLComponents(string: baseURL + endpoint.path)
        urlComponents?.queryItems = endpoint.urlQueryItems
        return urlComponents?.url
    }
}
