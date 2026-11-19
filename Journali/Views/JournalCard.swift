import SwiftUI

// The palette from the design


struct JournalCard: View {
    let journal: Journal
    let onBookmark: () -> Void

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(journal.title)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(AppColor.title)

                Spacer()

                Button(action: onBookmark) {
                    Image(systemName: journal.isBookmarked ? "bookmark.fill" : "bookmark")
                        .foregroundStyle(AppColor.title)
                }
                .buttonStyle(.borderless)
            }

            Text(journal.date.formatted(date: .numeric, time: .omitted))
                .font(.caption)
                .foregroundStyle(AppColor.secondaryText)

            Text(journal.text)
                .font(.footnote)
                .foregroundStyle(.primary)
                .lineLimit(5)
        }
        .padding()
        .background(Color(white: 0.11), in: .rect(cornerRadius: 20))
    }
}
