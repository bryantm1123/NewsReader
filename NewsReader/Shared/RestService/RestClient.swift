import Foundation

public typealias RestClientResponse = (Data, URLResponse)

/// Represents a client for RESTful network transactions.
public protocol RestClientProtocol {
    /// Executes a REST request asynchronously.
    /// - Parameter request: A request  for which to load data — conforming to ``RestRequesting``.
    /// - Returns: ``RestClientResponse`` — a tuple of type [Data](https://developer.apple.com/documentation/foundation/data) and [URLResponse](https://developer.apple.com/documentation/foundation/urlresponse).
    func execute<R: RestRequesting>(request: R) async throws -> RestClientResponse
}

/// An implementation of the ``RestClientProtocol``.
public final class RestClient: RestClientProtocol {
    
    /// Represents a URLSession
    private var session: RestURLSessionProtocol
    
    /// Public initializer for the ``RestClient``.
    /// - Parameter session: a session upon which to execute network requests — defaults to the shared URLSession singleton.
    public init(session: RestURLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    /// Implements the ``RestClientProtocol`` `execute(request:)` method.
    public func execute<R: RestRequesting>(request: R) async throws -> RestClientResponse {
        switch request.method {
        case .GET:
            return try await get(request: request)
        }
    }
    
    private func get<R: RestRequesting>(request: R) async throws -> RestClientResponse {
        var urlRequest = URLRequest(url: request.url, timeoutInterval: request.timeoutInterval)
        request.headers.forEach { (key, value) in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }

        return try await session.data(for: urlRequest, delegate: nil)
    }
}
