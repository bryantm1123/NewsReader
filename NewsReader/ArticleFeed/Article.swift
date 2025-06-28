import Foundation

struct Article: Identifiable {
    let id = UUID()
    let imageURL: String?
    let title: String
    let description: String?
    let source: String
    let time: String
    let url: String
}
