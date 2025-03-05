import Foundation
import NewsReader

struct EndpointMock: EndpointProtocol {
    let path: String
    let queryItems: [String : String]?
}
