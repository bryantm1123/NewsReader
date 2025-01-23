import Foundation

class NewsViewModel {
    private var newsService: NewsServceProtocol
    private let pageSize = 21
    private var page = 1
    private let dateFormatter: DateFormatter = DateFormatter()
    
    init(newsService: NewsServceProtocol) {
        self.newsService = newsService
    }
    
    func fetchTopHeadlines() async throws -> [NewsCellModel] {
        let topHeadlines = try await newsService.fetchTopHeadlines(page: page, pageSize: pageSize)
        page += 1
        return populateCellModels(from: topHeadlines)
    }
    
    private func populateCellModels(from articles: [Article]) -> [NewsCellModel] {
        articles.map {
            NewsCellModel(imageURL: URL(string: $0.urlToImage ?? ""),
                          title: $0.title ?? "",
                          description: $0.description ?? "",
                          author: "From: \($0.source.name)",
                          time: convertToDisplayString($0.publishedAt ?? ""))
        }
    }
    
    private func convertToDisplayString(_ publishedAt: String) -> String? {
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
        
        guard let date = dateFormatter.date(from: publishedAt) else {
            // Could have a log statement here
            return nil
        }
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour], from: date, to: Date.now)
        let hours = components.hour
        return "\(hours ?? 0) hrs ago"
    }
}
