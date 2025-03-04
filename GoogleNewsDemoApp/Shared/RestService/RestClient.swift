import Foundation

typealias RestClientResponse = (Data, URLResponse)

protocol RestClientProtocol {
    func execute<R: RestRequesting>(request: R) async throws -> RestClientResponse
}

final class RestClient: RestClientProtocol {
    
    private var session: URLSession // TODO: Make a wrapper 
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func execute<R: RestRequesting>(request: R) async throws -> RestClientResponse {
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
        
        return try await session.data(for: urlRequest)
    }
}
