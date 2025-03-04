import Foundation
import GoogleNewsDemoApp

struct EndpointMock: EndpointProtocol {
    let path: String
    let queryItems: [String : String]?
}
