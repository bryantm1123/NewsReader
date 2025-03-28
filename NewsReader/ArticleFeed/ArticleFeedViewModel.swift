import Foundation

class ArticleFeedViewModel {
    // dependencies
    private var newsService: TopHeadlinesServiceProtocol
    private let dateConverter: ISODateStringConverterProtocol
    
    // data source
    @Published var articles = [Article]()
    
    // pagination variables
    private var page = 0
    var isLoading = false
    
    init(
        newsService: TopHeadlinesServiceProtocol,
        dateConverter: ISODateStringConverterProtocol
    ) {
        self.newsService = newsService
        self.dateConverter = dateConverter
    }
    
    @discardableResult
    func fetchTopHeadlines() async throws -> [Article] {
        isLoading = true
        let topHeadlines = try await newsService.fetchTopHeadlines(page: String(page))
        page += 1
        
        let articleModels = mapToArticleModels(topHeadlines)
        
        await MainActor.run {
            articles.append(contentsOf: articleModels)
        }
        return articleModels
    }
    
    private func mapToArticleModels(_ articleDTOs: [ArticleResponse]) -> [Article] {
        articleDTOs.map {
            Article(imageURL: $0.urlToImage,
                    title: $0.title,
                    description: $0.description,
                    source: "From: \($0.source.name)",
                    time: dateConverter.convert(
                        isoDateString: $0.publishedAt,
                        toTimeFrom: Date.now
                    ),
                    url: $0.url
            )
        }
    }
}
