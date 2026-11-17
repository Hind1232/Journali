import SwiftUI

// Shows the splash for 2 seconds, then the main screen
struct RootView: View {
    @State private var showSplash = true

    var body: some View {
        if showSplash {
            SplashView()
                .task {
                    try? await Task.sleep(for: .seconds(2))
                    withAnimation { showSplash = false }
                }
        } else {
            MainView()
        }
    }
}

#Preview {
    RootView()
}
