import Testing
import Foundation
@testable import NewsReader

class NewsListViewModelTests {
    
    var newsServiceMock: NewsServiceMock?
    var isoDateConverterMock: ISODateStringConverterProtocolMock?
    var viewModel: ArticleFeedViewModel?
    
    init() {
        newsServiceMock = NewsServiceMock()
        isoDateConverterMock = ISODateStringConverterProtocolMock()
        viewModel = ArticleFeedViewModel(newsService: newsServiceMock!,
                                      dateConverter: isoDateConverterMock!)
    }

    @Test func viewModelCorrectlyPopulatesModelsFromArticles() async throws {
        let models = try await viewModel?.fetchTopHeadlines()
        #expect(models?.count == 2)
        let model = models?.first
        #expect(model?.title == "Dog wins lifetime supply of free bones")
        #expect(model?.description == "Local dog wins lifetime supply of free bones")
        #expect(model?.imageURL == "www.awesomeimage.com")
        #expect(model?.time == "4 hrs ago")
        #expect(model?.source == "From: BBC News")
    }
    
    deinit {
        newsServiceMock = nil
        viewModel = nil
    }
}
