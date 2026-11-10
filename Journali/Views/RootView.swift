import SwiftUI

// يعرض الـ Splash ثم ينتقل للصفحة الرئيسية بعد ثانيتين
struct RootView: View {
    @State private var showSplash = true

    var body: some View {
        ZStack {
            if showSplash {
                SplashView()
                    .transition(.opacity)
            } else {
                MainView()
                    .transition(.opacity)
            }
        }
        .preferredColorScheme(.dark)
        .task {
            try? await Task.sleep(for: .seconds(2))
            withAnimation { showSplash = false }
        }
    }
}

#Preview {
    RootView()
}
