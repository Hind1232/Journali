import SwiftUI

struct JournalCard: View {
    let journal: Journal
    let onBookmark: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(journal.title)
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundStyle(Color.accentText)

                Spacer()

                Button(action: onBookmark) {
                    Image(systemName: journal.isBookmarked ? "bookmark.fill" : "bookmark")
                        .foregroundStyle(Color.accentPrimary)
                }
                .buttonStyle(.plain)
            }

            Text(journal.date.formatted(date: .numeric, time: .omitted))
                .font(.system(size: 14))
                .foregroundStyle(Color.textSecondary)

            Text(journal.text)
                .font(.system(size: 16))
                .foregroundStyle(.white)
                .lineLimit(4)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.cardSurface)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    JournalCard(
        journal: Journal(title: "Great Day", text: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit."),
        onBookmark: { }
    )
    .padding()
    .background(Color.black)
}
