import Foundation

struct TopHeadlinesRequest: RESTRequest {
    let url: URL
    let method: HTTPMethod = .GET
    let headers: [String : String]
}
