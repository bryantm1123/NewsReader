import Testing
import Foundation

struct EndpointProtocolTests {

    @Test func endpointCreatesURLQueryParameters() {
        let expectedPath = "/path-to-resource"
        let queryItemName = "name"
        let queryItemValue = "Spongebob"
        let expectedQueryItems = [queryItemName: queryItemValue]
        let expectedURLQueryItems = [URLQueryItem(name: queryItemName, value: queryItemValue)]
        let endpoint = EndpointMock(path: expectedPath, queryItems: expectedQueryItems)
        
        #expect(endpoint.path == expectedPath)
        #expect(endpoint.queryItems == expectedQueryItems)
        #expect(endpoint.urlQueryItems == expectedURLQueryItems)
    }

}
