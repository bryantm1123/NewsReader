import Foundation
import GoogleNewsDemoApp

struct URLBuilderMock: URLBuilding {
    let baseURL: String
    let endpoint: any EndpointProtocol
}
