import SwiftUI

// Card Style
struct TallyCardStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(20)
            .background(Color.tallyCardBg)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 4)
    }
}

// Primary Button
struct TallyPrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 18, weight: .bold))
            .foregroundColor(.white)
            .padding(.horizontal, 32)
            .padding(.vertical, 16)
            .background(TallyGradients.primary)
            .cornerRadius(12)
            .shadow(color: Color.tallyPrimary.opacity(0.4), radius: 8, x: 0, y: 4)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.spring(response: 0.3), value: configuration.isPressed)
    }
}

// Point Button
struct TallyPointButtonStyle: ButtonStyle {
    let color: Color

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 32, weight: .heavy))
            .foregroundColor(.white)
            .frame(width: 80, height: 80)
            .background(color)
            .cornerRadius(20)
            .shadow(color: color.opacity(0.5), radius: 8, x: 0, y: 4)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: configuration.isPressed)
    }
}

// Extensions
extension View {
    func tallyCard() -> some View {
        modifier(TallyCardStyle())
    }
}
