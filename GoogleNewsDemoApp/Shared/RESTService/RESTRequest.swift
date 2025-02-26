import Foundation

enum HTTPMethod: String {
    case GET
}

protocol RESTRequest {
    var url: URL { get }
    var method: HTTPMethod { get }
    var timeoutInterval: TimeInterval { get }
    var headers: [String: String] { get }
}

extension RESTRequest {
    var timeoutInterval: TimeInterval {
        60.0
    }
}
