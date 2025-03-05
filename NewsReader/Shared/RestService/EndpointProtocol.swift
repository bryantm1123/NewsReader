import Foundation

public protocol EndpointProtocol {
    var path: String { get }
    var queryItems: [String: String]? { get }
}

public extension EndpointProtocol {
    var urlQueryItems: [URLQueryItem]? {
        queryItems?.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
    }
}
