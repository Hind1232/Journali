import SwiftUI

struct EmptyStateView: View {
    var body: some View {
        ViewThatFits(in: .vertical) {
            content

            ScrollView {
                content
            }
        }
    }

    private var content: some View {
        VStack {
            Image("empty-book")
                .resizable()
                .scaledToFit()
                .containerRelativeFrame(.horizontal) { width, _ in width * 0.35 }

            Text("Begin Your Journal")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(Color("AccentText"))

            Text("Craft your personal diary, tap the plus icon to begin")
                .font(.body)
                .fontWeight(.light)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
    }
}

#Preview {
    EmptyStateView()
        .preferredColorScheme(.dark)
}

#Preview("Large text") {
    EmptyStateView()
        .environment(\.dynamicTypeSize, .accessibility3)
        .preferredColorScheme(.dark)
}
