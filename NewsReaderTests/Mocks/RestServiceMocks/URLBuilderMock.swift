import Foundation
import NewsReader

struct URLBuilderMock: URLBuilding {
    let baseURL: String
    let endpoint: any EndpointProtocol
}
