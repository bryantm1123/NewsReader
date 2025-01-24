import Foundation

class NewsListViewModel {
    private var newsService: NewsServiceProtocol
    private let pageSize = 21
    private var page = 0
    private let isoDateFormatter = ISO8601DateFormatter()
    
    init(newsService: NewsServiceProtocol) {
        self.newsService = newsService
    }
    
    func fetchTopHeadlines() async throws -> [ArticleModel] {
        let topHeadlines = try await newsService.fetchTopHeadlines(page: page, pageSize: pageSize)
        page += 1
        return populateArticleModels(from: topHeadlines)
    }
    
    private func populateArticleModels(from articles: [Article]) -> [ArticleModel] {
        articles.map {
            ArticleModel(imageURL: URL(string: $0.urlToImage ?? ""),
                          title: $0.title ?? "",
                          description: $0.description ?? "",
                          content: $0.content ?? "",
                          author: "From: \($0.source.name)",
                          time: convertToDisplayString($0.publishedAt ?? ""))
        }
    }
    
    private func convertToDisplayString(_ publishedAt: String) -> String? {
        guard let date = convertToDate(publishedAt) else { return nil }
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour], from: date, to: Date.now)
        let hours = components.hour
        return "\(hours ?? 0) hrs ago"
    }
    
    private func convertToDate(_ dateString: String) -> Date? {
        isoDateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        isoDateFormatter.timeZone = TimeZone.current
        
        if let date = isoDateFormatter.date(from: dateString) {
            return date
        }
        
        isoDateFormatter.formatOptions = [.withInternetDateTime]
        if let date = isoDateFormatter.date(from: dateString) {
            return date
        }
        return nil
    }
}
