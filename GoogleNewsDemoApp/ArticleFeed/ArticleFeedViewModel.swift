import Foundation

class ArticleFeedViewModel {
    private var newsService: TopHeadlinesServiceProtocol
    private let dateConverter: ISODateStringConverterProtocol
    private var page = 0
    
    @Published var articles = [Article]()
    var isLoading = false
    
    init(newsService: TopHeadlinesServiceProtocol,
         dateConverter: ISODateStringConverterProtocol) {
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
            Article(imageURL: URL(string: $0.urlToImage ?? ""),
                    title: $0.title ?? "",
                    description: $0.description ?? "",
                    content: $0.content ?? "",
                    source: "From: \($0.source.name)",
                    time: dateConverter.convert(
                        isoDateString: $0.publishedAt ?? "",
                        toTimeFrom: Date.now
                    )
            )
        }
    }
}
