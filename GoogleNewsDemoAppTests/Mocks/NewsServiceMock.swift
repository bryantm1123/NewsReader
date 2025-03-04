import Foundation
import Testing
@testable import GoogleNewsDemoApp

struct NewsServiceMock: TopHeadlinesServiceProtocol {
    func fetchTopHeadlines(page: Int, pageSize: Int) async throws -> [GoogleNewsDemoApp.ArticleDTO] {
        [
            ArticleDTO(source: Source(name: "BBC News"),
                    title: "Dog wins lifetime supply of free bones",
                    description: "Local dog wins lifetime supply of free bones",
                    urlToImage: "www.awesomeimage.com",
                    publishedAt: "2025-01-23T04:58:38Z", // internet date time
                    content: "Today one lucky dog never has to worry about where he buried his bone, for he has won a lifetime supply from local pet store."),
            ArticleDTO(source: Source(name: "BBC News"),
                    title: "Dog wins lifetime supply of free bones",
                    description: "Local dog wins lifetime supply of free bones",
                    urlToImage: "www.awesomeimage.com",
                    publishedAt: "2025-01-23T15:52:23.3636319Z", // fractional seconds
                    content: "Today one lucky dog never has to worry about where he buried his bone, for he has won a lifetime supply from local pet store.")
        ]
    }
}
