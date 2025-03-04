import Testing
import Foundation

struct RestRequestTests {

    @Test func restRequestSetsCorrectDefaultTimeoutInterval() {
        let expectedURL = URL(string: "https://spongebob.org")!
        let expectedHeaders = ["key": "value"]
        let request = RestRequestMock(url: expectedURL, method: .GET, headers: expectedHeaders)
        
        #expect(request.url == expectedURL)
        #expect(request.headers == expectedHeaders)
        #expect(request.timeoutInterval == 60.0)
    }

    @Test func restRequestOverridesDefaultTimeoutInterval() {
        let expectedURL = URL(string: "https://spongebob.org")!
        let expectedHeaders = ["key": "value"]
        let request = RestRequestOverridingTimeoutMock(url: expectedURL, method: .GET, headers: expectedHeaders, timeoutInterval: 30.0)
        
        #expect(request.url == expectedURL)
        #expect(request.headers == expectedHeaders)
        #expect(request.timeoutInterval == 30.0)
    }
}
