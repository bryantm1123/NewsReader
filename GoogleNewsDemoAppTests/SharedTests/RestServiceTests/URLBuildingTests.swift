import Testing

struct URLBuildingTests {

    @Test func urlBuilderBuildsURL() {
        let baseURL = "https://myapp.io"
        let path = "/path-to-resource"
        let expeectedURLString = baseURL + path
        let endPoint = EndpointMock(path: path, queryItems: nil)
        let urlBuilder = URLBuilderMock(baseURL: baseURL, endpoint: endPoint)
        let url = urlBuilder.url
        let urlString = url?.relativeString
        
        #expect(urlString == expeectedURLString)
    }
    
    @Test func urlBuilderBuildsURLWithQueryItems() {
        let baseURL = "https://myapp.io"
        let path = "/path-to-resource"
        let queryItemName = "name"
        let queryItemValue = "Spongebob"
        let expeectedURLString = "\(baseURL)\(path)?\(queryItemName)=\(queryItemValue)"
        let endPoint = EndpointMock(path: path, queryItems: [queryItemName: queryItemValue])
        let urlBuilder = URLBuilderMock(baseURL: baseURL, endpoint: endPoint)
        let url = urlBuilder.url
        let urlString = url?.relativeString
        
        #expect(urlString == expeectedURLString)
    }

}
