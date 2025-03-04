import Testing
import Foundation
@testable import GoogleNewsDemoApp

struct RestClientTests {

    @Test func restClientReturnsDataAndResponse() async throws {
        let data = "spongebob".data(using: .utf8)!
        let url = URL(string: "https://spongebob.com")!
        let httpResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
        let restURLSessionMock = RestURLSessionMock(data: data, response: httpResponse)
        let restClient = RestClient(session: restURLSessionMock)
        let request = RestRequestMock(url: url, method: .GET, headers: ["key":"value"])
        
        let response = try await restClient.execute(request: request)
        
        #expect(response.0 == data)
        #expect((response.1 as? HTTPURLResponse) == httpResponse)
    }

}
