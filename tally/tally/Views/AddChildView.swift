import SwiftUI

struct AddChildView: View {

    @State private var name: String = ""
    let onContinue: (String) -> Void

    var body: some View {
        VStack(spacing: 32) {
            // Gradient header
            VStack(spacing: 8) {
                Text("积点")
                    .font(.system(size: 48, weight: .black))
                    .foregroundStyle(TallyGradients.primary)

                Text("添加孩子")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(.secondary)
            }
            .padding(.top, 40)

            // Styled text field
            VStack(alignment: .leading, spacing: 8) {
                Text("孩子的名字")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.secondary)

                TextField("", text: $name)
                    .font(.system(size: 18))
                    .padding(16)
                    .background(Color.tallySurfaceLight)
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.tallySecondary, lineWidth: 2)
                    )
            }

            Spacer()

            Button("继续") {
                let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
                guard !trimmed.isEmpty else { return }
                onContinue(trimmed)
            }
            .buttonStyle(TallyPrimaryButtonStyle())
            .disabled(name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            .opacity(name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? 0.5 : 1.0)
        }
        .padding(32)
    }
}
