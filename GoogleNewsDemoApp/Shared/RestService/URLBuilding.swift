import Foundation

public protocol URLBuilding {
    var baseURL: String { get }
    var endpoint: EndpointProtocol { get }
}

public extension URLBuilding {
    var url: URL? {
        var urlComponents = URLComponents(string: baseURL + endpoint.path)
        urlComponents?.queryItems = endpoint.urlQueryItems
        return urlComponents?.url
    }
}
