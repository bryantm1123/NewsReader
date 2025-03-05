import Foundation

struct TopHeadlinesRequest: RestRequesting {
    let url: URL
    let method: HTTPMethod = .GET
    let headers: [String : String]
}
