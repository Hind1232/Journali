import SwiftUI

struct SplashView: View {
    @State private var opacity = 0.0
    @State private var scale = 0.8

    var body: some View {
        // If the content does not fit (big text), show it in a ScrollView
        ViewThatFits(in: .vertical) {
            content
            ScrollView { content }
        }
        .scaleEffect(scale)
        .opacity(opacity)
        .onAppear {
            // Fade in and grow smoothly
            withAnimation(.easeOut(duration: 1.0)) {
                opacity = 1.0
                scale = 1.0
            }
        }
    }

    private var content: some View {
        VStack {
            Image("journali-logo")
                .resizable()
                .scaledToFit()
                .containerRelativeFrame(.horizontal) { width, _ in width * 0.25 }

            Text("Journali")
                .font(.largeTitle)
                .fontWeight(.black)

            Text("Your thoughts, your story")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview("Dark") {
    SplashView().preferredColorScheme(.dark)
}

#Preview("Light") {
    SplashView().preferredColorScheme(.light)
}
