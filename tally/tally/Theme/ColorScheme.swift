import SwiftUI

extension Color {
    // Primary Colors - Bold & Energetic
    static let tallyPrimary = Color(red: 0.92, green: 0.29, blue: 0.38)      // Vibrant Pink
    static let tallySecondary = Color(red: 0.29, green: 0.71, blue: 0.98)    // Bright Blue
    static let tallyAccent = Color(red: 1.0, green: 0.73, blue: 0.0)         // Sunny Yellow

    // Kid-Friendly Colors
    static let tallyGreen = Color(red: 0.31, green: 0.89, blue: 0.55)        // Happy Green
    static let tallyPurple = Color(red: 0.66, green: 0.43, blue: 0.98)       // Fun Purple
    static let tallyOrange = Color(red: 1.0, green: 0.56, blue: 0.26)        // Playful Orange

    // Backgrounds
    static let tallySurfaceLight = Color(red: 0.98, green: 0.98, blue: 1.0)
    static let tallyCardBg = Color.white
}

struct TallyGradients {
    static let primary = LinearGradient(
        colors: [.tallyPrimary, .tallySecondary],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let accent = LinearGradient(
        colors: [.tallyAccent, .tallyOrange],
        startPoint: .leading,
        endPoint: .trailing
    )

    static let reward = LinearGradient(
        colors: [.tallyGreen, .tallySecondary],
        startPoint: .leading,
        endPoint: .trailing
    )

    static let rainbow = LinearGradient(
        colors: [.tallyPrimary, .tallyPurple, .tallySecondary, .tallyGreen],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}
