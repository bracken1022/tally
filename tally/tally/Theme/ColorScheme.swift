import SwiftUI

extension Color {
    // Primary Colors - Bold & Energetic (brightened for dark mode)
    static let tallyPrimary = Color(red: 1.0, green: 0.35, blue: 0.47)       // Vibrant Pink
    static let tallySecondary = Color(red: 0.4, green: 0.78, blue: 1.0)      // Bright Blue
    static let tallyAccent = Color(red: 1.0, green: 0.8, blue: 0.2)          // Sunny Yellow

    // Kid-Friendly Colors
    static let tallyGreen = Color(red: 0.4, green: 0.95, blue: 0.65)         // Happy Green
    static let tallyPurple = Color(red: 0.75, green: 0.52, blue: 1.0)        // Fun Purple
    static let tallyOrange = Color(red: 1.0, green: 0.65, blue: 0.35)        // Playful Orange

    // Dark Mode Backgrounds
    static let tallyBackground = Color(red: 0.08, green: 0.08, blue: 0.12)   // Deep Dark Blue
    static let tallyCardBg = Color(red: 0.12, green: 0.12, blue: 0.18)       // Card Dark
    static let tallyInputBg = Color(red: 0.15, green: 0.15, blue: 0.22)      // Input Dark
    static let tallySurfaceLight = Color(red: 0.18, green: 0.18, blue: 0.25) // Surface Dark

    // Text Colors
    static let tallyTextPrimary = Color.white
    static let tallyTextSecondary = Color(red: 0.7, green: 0.7, blue: 0.75)
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
