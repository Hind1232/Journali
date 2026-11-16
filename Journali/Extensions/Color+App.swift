import SwiftUI

// الألوان من الـ Style Guide
extension Color {
    init(hex: UInt32) {
        self.init(
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255
        )
    }

    static let accentPrimary = Color(hex: 0x7F81FF)   // Save button, active actions
    static let accentText    = Color(hex: 0xAF99FD)   // Journal titles
    static let textSecondary = Color(hex: 0xA39A9A)   // Entry dates
    static let cardSurface   = Color(hex: 0x1C1C1E)   // Journal cards
    static let destructive   = Color(hex: 0xFD453C)   // Delete action
}
