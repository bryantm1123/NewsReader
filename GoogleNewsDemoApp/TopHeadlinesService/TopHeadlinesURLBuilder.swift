import Foundation

struct TopHeadlinesURLBuilder: URLBuilding {
    let baseURL: String
    let endpoint: any EndpointProtocol
}
