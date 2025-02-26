import Foundation

typealias RESTClientResponse = (Data, URLResponse)

protocol RESTClientProtocol {
    func execute<R: RESTRequest>(request: R) async throws -> RESTClientResponse
}

final class RESTClient: RESTClientProtocol {
    
    private var session: URLSession // TODO: Make a wrapper 
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func execute<R: RESTRequest>(request: R) async throws -> RESTClientResponse {
        switch request.method {
        case .GET:
            return try await get(request: request)
        }
    }
    
    private func get<R: RESTRequest>(request: R) async throws -> RESTClientResponse {
        var urlRequest = URLRequest(url: request.url, timeoutInterval: request.timeoutInterval)
        request.headers.forEach { (key, value) in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        
        return try await session.data(for: urlRequest)
    }
}
