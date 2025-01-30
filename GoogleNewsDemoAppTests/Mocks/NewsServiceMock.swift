import Foundation
import Testing
@testable import GoogleNewsDemoApp

class NewsServiceMock: NewsServiceProtocol {
    func fetchTopHeadlines(page: Int, pageSize: Int) async throws -> [GoogleNewsDemoApp.ArticleDTO] {
        [
            ArticleDTO(source: Source(name: "BBC News"),
                    title: "Bonial wins Apple Design Award",
                    description: "Bonial wins Apple prestigious design award",
                    urlToImage: "www.awesomeimage.com",
                    publishedAt: "2025-01-23T04:58:38Z", // internet date time
                    content: "Today Bonial GmbH based in Berlin won Apple's most prestigious award for app design"),
            ArticleDTO(source: Source(name: "BBC News"),
                    title: "Bonial wins Apple Design Award",
                    description: "Bonial wins Apple prestigious design award",
                    urlToImage: "www.awesomeimage.com",
                    publishedAt: "2025-01-23T15:52:23.3636319Z", // fractional seconds
                    content: "Today Bonial GmbH based in Berlin won Apple's most prestigious award for app design"),
        ]
    }
}
