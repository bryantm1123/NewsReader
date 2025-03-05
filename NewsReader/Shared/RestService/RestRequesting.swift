import Foundation

public enum HTTPMethod: String {
    case GET
}

public protocol RestRequesting {
    var url: URL { get }
    var method: HTTPMethod { get }
    var timeoutInterval: TimeInterval { get }
    var headers: [String: String] { get }
}

public extension RestRequesting {
    var timeoutInterval: TimeInterval {
        60.0
    }
}
