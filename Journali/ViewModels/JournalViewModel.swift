import SwiftUI
import Combine

// VIEWMODEL: المنطق (إضافة، تعديل، حذف، بحث، ترتيب)
class JournalViewModel: ObservableObject {
    @Published var journals: [Journal] = []
    @Published var searchText = ""
    @Published var sortByBookmark = false

    // القائمة اللي تنعرض بعد البحث والترتيب
    var displayedJournals: [Journal] {
        var result = journals

        if !searchText.isEmpty {
            result = result.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.text.localizedCaseInsensitiveContains(searchText)
            }
        }

        result.sort { a, b in
            if sortByBookmark, a.isBookmarked != b.isBookmarked {
                return a.isBookmarked
            }
            return a.date > b.date
        }
        return result
    }

    func add(title: String, text: String) {
        journals.append(Journal(title: title, text: text))
    }

    func update(_ journal: Journal, title: String, text: String) {
        guard let index = journals.firstIndex(where: { $0.id == journal.id }) else { return }
        journals[index].title = title
        journals[index].text = text
    }

    func toggleBookmark(_ journal: Journal) {
        guard let index = journals.firstIndex(where: { $0.id == journal.id }) else { return }
        journals[index].isBookmarked.toggle()
    }

    func delete(_ journal: Journal) {
        journals.removeAll { $0.id == journal.id }
    }
}
