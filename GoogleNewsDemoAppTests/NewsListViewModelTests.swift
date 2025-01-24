import Testing
import Foundation
@testable import GoogleNewsDemoApp

class NewsListViewModelTests {
    
    var newsServiceMock: NewsServiceMock?
    var viewModel: NewsListViewModel?
    
    init() {
        newsServiceMock = NewsServiceMock()
        viewModel = NewsListViewModel(newsService: newsServiceMock!)
    }

    @Test func testViewModelCorrectlyPopulatesModelsFromArticles() async throws {
        let models = try await viewModel?.fetchTopHeadlines()
        #expect(models?.count == 2)
        let model = models?.first
        #expect(model?.title == "Bonial wins Apple Design Award")
        #expect(model?.description == "Bonial wins Apple prestigious design award")
        #expect(model?.imageURL == URL(string: "www.awesomeimage.com"))
        #expect(model?.time != nil)
        #expect(model?.content == "Today Bonial GmbH based in Berlin won Apple's most prestigious award for app design")
        #expect(model?.author == "From: BBC News")
        
        // The date parser must handle fractional seconds in the article.publishedAt date/time stamp
        let modelWithFractionalSeconds = models?[1]
        #expect(modelWithFractionalSeconds?.time != nil)
    }
    
    deinit {
        newsServiceMock = nil
        viewModel = nil
    }
}
