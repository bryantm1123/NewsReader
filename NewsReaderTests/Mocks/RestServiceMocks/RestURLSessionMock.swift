import Foundation
import NewsReader

struct RestURLSessionMock: RestURLSessionProtocol {
    let data: Data
    let response: URLResponse
    
    func data(
        for request: URLRequest,
        delegate: (any URLSessionTaskDelegate)?
    ) async throws -> (Data, URLResponse) {
        (data, response)
    }
}
