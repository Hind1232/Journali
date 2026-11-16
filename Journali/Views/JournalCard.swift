import SwiftUI

struct JournalCard: View {
    let journal: Journal
    let onBookmark: () -> Void

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(journal.title)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color("AccentText"))

                Spacer()

                Button(action: onBookmark) {
                    Image(systemName: journal.isBookmarked ? "bookmark.fill" : "bookmark")
                }
                .buttonStyle(.borderless)
            }

            Text(journal.date.formatted(date: .numeric, time: .omitted))
                .font(.caption)
                .foregroundStyle(.secondary)

            Text(journal.text)
                .font(.footnote)
                .lineLimit(4)
        }
    }
}

#Preview {
    List {
        JournalCard(
            journal: Journal(title: "Great Day", text: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit."),
            onBookmark: { }
        )
    }
    .preferredColorScheme(.dark)
}
