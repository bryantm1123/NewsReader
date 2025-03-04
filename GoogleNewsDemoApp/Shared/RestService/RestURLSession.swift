import Foundation

public protocol RestURLSessionProtocol {
    func data(for request: URLRequest, delegate: (any URLSessionTaskDelegate)?) async throws -> (Data, URLResponse)
}

extension URLSession: RestURLSessionProtocol {}
