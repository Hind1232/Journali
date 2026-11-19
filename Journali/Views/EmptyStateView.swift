import SwiftUI

struct EmptyStateView: View {
    var body: some View {
        VStack {
            Image("empty-book")
                .resizable()
                .scaledToFit()
                .containerRelativeFrame(.horizontal) { width, _ in width * 0.35 }

            Text("Begin Your Journal")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(Color(red: 0.686, green: 0.6, blue: 0.992))

            Text("Craft your personal diary, tap the plus icon to begin")
                .font(.body)
                .fontWeight(.light)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
    }
}


#Preview("Dark") {
    EmptyStateView().preferredColorScheme(.dark)
}

#Preview("Light") {
    EmptyStateView().preferredColorScheme(.light)
}
