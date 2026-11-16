import Foundation

struct Journal: Identifiable {
    let id = UUID()
    var title: String
    var text: String
    var date: Date = Date()
    var isBookmarked: Bool = false
}
