import Foundation

public typealias RestClientResponse = (Data, URLResponse)

public protocol RestClientProtocol {
    func execute<R: RestRequesting>(request: R) async throws -> RestClientResponse
}

public final class RestClient: RestClientProtocol {
    
    private var session: RestURLSessionProtocol
    
    public init(session: RestURLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    /// Executes a request asynchronously.
    /// - Parameter request: A request conforming to `RestRequesting` for which to load data.
    /// - Returns: type `RestClientResponse` which is a tuple of type `Data` and `URLResponse`.
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
