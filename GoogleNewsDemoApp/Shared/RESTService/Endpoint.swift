import Foundation

protocol EndpointProtocol {
    var path: String { get }
    var queryItems: [String: String] { get }
}

extension EndpointProtocol {
    var urlQueryItems: [URLQueryItem] {
        queryItems.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
    }
}
