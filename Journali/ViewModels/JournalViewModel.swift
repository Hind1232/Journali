import SwiftUI
import Combine

// Holds all the journals and the logic (add, edit, delete, search, sort)
class JournalViewModel: ObservableObject {
    @Published var journals: [Journal] = []
    @Published var searchText = ""
    @Published var sortByBookmark = false

    // The list the screen shows (after search and sort)
    var displayedJournals: [Journal] {
        var result = journals

        // Search: keep journals that contain the typed word
        if !searchText.isEmpty {
            result = result.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.text.localizedCaseInsensitiveContains(searchText)
            }
        }

        // Sort: bookmarked first (if chosen), otherwise newest first
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
