import Foundation

class NewsListViewModel {
    private var newsService: NewsServiceProtocol
    private let dateConverter: ISODateStringConverterProtocol
    private let pageSize = 21
    private var page = 0
    
    @Published var articles = [ArticleModel]()
    var isLoading = false
    
    init(newsService: NewsServiceProtocol,
         dateConverter: ISODateStringConverterProtocol) {
        self.newsService = newsService
        self.dateConverter = dateConverter
    }
    
    @discardableResult
    func fetchTopHeadlines() async throws -> [ArticleModel] {
        isLoading = true
        let topHeadlines = try await newsService.fetchTopHeadlines(page: page, pageSize: pageSize)
        page += 1
        
        let articleModels = mapToArticleModels(topHeadlines)
        
        await MainActor.run {
            articles.append(contentsOf: articleModels)
        }
        return articleModels
    }
    
    private func mapToArticleModels(_ articleDTOs: [ArticleDTO]) -> [ArticleModel] {
        articleDTOs.map {
            ArticleModel(imageURL: URL(string: $0.urlToImage ?? ""),
                         title: $0.title ?? "",
                         description: $0.description ?? "",
                         content: $0.content ?? "",
                         source: "From: \($0.source.name)",
                         time: dateConverter.convert(isoDateString: $0.publishedAt ?? "",
                                                     toTimeFrom: Date.now))
        }
    }
}
