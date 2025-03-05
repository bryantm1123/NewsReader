import Foundation

/// Represents a URLSession
public protocol RestURLSessionProtocol {
    
    /// Mimics the [data(for:delegate:)](https://developer.apple.com/documentation/foundation/urlsession/3767352-data) method on URLSession for the purpose of creating a mock of URLSession for testing purposes.
    /// - Parameters:
    ///   - request: a request for which to load data.
    ///   - delegate: a delegate that receives life-cycle and authentication challenges.
    /// - Returns:  a tuple of type [Data](https://developer.apple.com/documentation/foundation/data) and [URLResponse](https://developer.apple.com/documentation/foundation/urlresponse).
    func data(for request: URLRequest, delegate: (any URLSessionTaskDelegate)?) async throws -> (Data, URLResponse)
}

extension URLSession: RestURLSessionProtocol {}
