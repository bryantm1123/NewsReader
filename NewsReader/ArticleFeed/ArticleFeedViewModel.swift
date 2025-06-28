import SwiftUI

@MainActor
class ArticleFeedViewModel: ObservableObject {
    // dependencies
    private var newsService: TopHeadlinesServiceProtocol
    private let dateConverter: ISODateStringConverterProtocol
    
    // data source
    @Published private(set) var articles = [Article]()
    @Published private(set) var isLoading = false
    
    // pagination variables
    private var page = 0
    
    init(
        newsService: TopHeadlinesServiceProtocol,
        dateConverter: ISODateStringConverterProtocol
    ) {
        self.newsService = newsService
        self.dateConverter = dateConverter
    }
    
    func refresh() async {
        page = 0
        articles.removeAll()
        try? await fetchTopHeadlines()
    }
    
    func fetchTopHeadlines() async throws {
        guard !isLoading else { return }
        
        isLoading = true
        defer { isLoading = false }
        
        let topHeadlines = try await newsService.fetchTopHeadlines(page: String(page))
        page += 1
        
        let articleModels = mapToArticleModels(topHeadlines)
        articles.append(contentsOf: articleModels)
    }
    
    private func mapToArticleModels(_ articleDTOs: [ArticleResponse]) -> [Article] {
        articleDTOs.map {
            Article(
                imageURL: $0.urlToImage,
                title: $0.title ?? "",
                description: $0.description,
                source: "From: \($0.source.name)",
                time: dateConverter.convert(
                    isoDateString: $0.publishedAt,
                    toTimeFrom: Date.now
                ) ?? "",
                url: $0.url ?? ""
            )
        }
    }
}
