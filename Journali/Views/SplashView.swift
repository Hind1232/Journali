import SwiftUI

struct SplashView: View {
    @State private var opacity = 0.0
    @State private var scale = 0.8

    var body: some View {
        ViewThatFits(in: .vertical) {
            content

            ScrollView {
                content
            }
        }
        .scaleEffect(scale)
        .opacity(opacity)
        .onAppear {
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

#Preview {
    SplashView()
        .preferredColorScheme(.dark)
}

#Preview("Large text") {
    SplashView()
        .environment(\.dynamicTypeSize, .accessibility3)
        .preferredColorScheme(.dark)
}
