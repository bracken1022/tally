import SwiftUI

struct AddChildView: View {

    @State private var name: String = ""
    let onContinue: (String) -> Void

    var body: some View {
        ZStack {
            // Dark mode background
            Color.tallyBackground
                .ignoresSafeArea()

            VStack(spacing: 32) {
                // Gradient header
                VStack(spacing: 8) {
                    Text("添加孩子")
                        .font(.system(size: 24, weight: .black))
                        .foregroundStyle(TallyGradients.primary)
                }
                .padding(.top, 40)
                .frame(maxWidth: .infinity)

                // Styled text field
                VStack(alignment: .leading, spacing: 8) {
                    Text("孩子的名字")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.tallyTextSecondary)

                    TextField("", text: $name)
                        .font(.system(size: 18))
                        .padding(16)
                        .background(Color.tallyInputBg)
                        .foregroundColor(.tallyTextPrimary)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.tallySecondary, lineWidth: 2)
                        )
                }
                .frame(maxWidth: .infinity)

                Spacer()

                Button("继续") {
                    let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
                    guard !trimmed.isEmpty else { return }
                    onContinue(trimmed)
                }
                .buttonStyle(TallyPrimaryButtonStyle())
                .frame(maxWidth: .infinity)
                .disabled(name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                .opacity(name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? 0.5 : 1.0)
            }
            .padding(32)
        }
    }
}
