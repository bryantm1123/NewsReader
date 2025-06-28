import SwiftUI

struct ArticleView: View {
    let article: Article
    let isLarge: Bool
    @Environment(\.openURL) private var openURL
    
    var body: some View {
        GeometryReader { geometry in
            Button(action: {
                if let url = URL(string: article.url) {
                    openURL(url)
                }
            }) {
                VStack(alignment: .leading, spacing: 8) {
                    if let imageURL = article.imageURL,
                       let url = URL(string: imageURL) {
                        AsyncImage(url: url) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .clipped()
                            case .failure:
                                Image(systemName: "arrow.trianglehead.2.clockwise.rotate.90.icloud.fill")
                                    .foregroundColor(.gray)
                            @unknown default:
                                EmptyView()
                            }
                        }
                        .frame(height: geometry.size.height * 9 / 16)
                        .clipped()
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(article.title)
                            .font(.headline)
                            .lineLimit(3)
                        
                        if let description = article.description {
                            Text(description)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .lineLimit(3)
                        }
                        
                        HStack {
                            Text(article.source)
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            Spacer()
                            
                            Text(article.time)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.horizontal, isLarge ? geometry.size.width * 0.1 : 0)
                    .padding(.bottom)
                }
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(radius: 3)
            }
            .buttonStyle(.plain)
        }
        .frame(height: isLarge ? 380 : nil)
    }
}

#Preview {
    ArticleView(
        article: Article(
            imageURL: "https://example.com/image.jpg",
            title: "Sample Article Title",
            description: "This is a sample article description that might span multiple lines to show how the text wraps.",
            source: "From: News Source",
            time: "2 hours ago",
            url: "https://example.com"
        ),
        isLarge: true
    )
    .padding()
    .background(Color(.systemGroupedBackground))
}
