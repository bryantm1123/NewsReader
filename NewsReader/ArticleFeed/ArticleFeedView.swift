import SwiftUI

struct ArticleFeedView: View {
    @StateObject private var viewModel: ArticleFeedViewModel
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    init(viewModel: ArticleFeedViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    // All cards will be the same size, 90% of screen width, 16:9 aspect ratio
    private func cardSize(for width: CGFloat) -> CGSize {
        let cardWidth = width * 0.9
        let cardHeight = cardWidth * 9 / 16
        return CGSize(width: cardWidth, height: cardHeight)
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(viewModel.articles, id: \.id) { article in
                        let size = cardSize(for: geometry.size.width)
                        ArticleView(article: article, isLarge: false)
                            .frame(width: size.width, height: size.height)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.vertical, 10)
                            .onAppear {
                                if let last = viewModel.articles.last, last.id == article.id {
                                    Task { try? await viewModel.fetchTopHeadlines() }
                                }
                            }
                    }
                }
                .padding()
            }
        }
        .refreshable {
            await viewModel.refresh()
        }
        .task {
            try? await viewModel.fetchTopHeadlines()
        }
    }
}

#Preview {
    ArticleFeedView(
        viewModel: ArticleFeedViewModel(
            newsService: TopHeadlinesService(),
            dateConverter: ISODateStringConverter(formatter: ISO8601DateFormatter())
        )
    )
}
