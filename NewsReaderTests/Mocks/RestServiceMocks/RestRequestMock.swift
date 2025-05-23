import Foundation
import NewsReader

struct RestRequestMock: RestRequesting {
    let url: URL
    let method: HTTPMethod
    let headers: [String : String]
}

struct RestRequestOverridingTimeoutMock: RestRequesting {
    let url: URL
    let method: HTTPMethod
    let headers: [String : String]
    let timeoutInterval: TimeInterval
}
