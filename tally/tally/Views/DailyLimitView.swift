import SwiftUI

struct DailyLimitView: View {

    @State private var enabled: Bool
    @State private var limitText: String

    let onSave: (Bool, Int?) -> Void

    init(enabled: Bool, limit: Int?, onSave: @escaping (Bool, Int?) -> Void) {
        _enabled = State(initialValue: enabled)
        _limitText = State(initialValue: limit.map(String.init) ?? "")
        self.onSave = onSave
    }

    var body: some View {
        VStack(spacing: 32) {
            // Gradient header
            VStack(spacing: 8) {
                Text("积点")
                    .font(.system(size: 48, weight: .black))
                    .foregroundStyle(TallyGradients.primary)

                Text("每日上限设置")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(.secondary)
            }
            .padding(.top, 40)

            // Toggle switch
            Toggle("开启每日上限", isOn: $enabled)
                .font(.system(size: 18, weight: .semibold))
                .padding(20)
                .background(Color.tallySurfaceLight)
                .cornerRadius(12)
                .tint(.tallySecondary)

            // Conditional text field with animation
            if enabled {
                VStack(alignment: .leading, spacing: 8) {
                    Text("上限积点数")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.secondary)

                    TextField("如：10", text: $limitText)
                        .keyboardType(.numberPad)
                        .font(.system(size: 18))
                        .padding(16)
                        .background(Color.tallySurfaceLight)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.tallySecondary, lineWidth: 2)
                        )
                }
                .transition(.move(edge: .top).combined(with: .opacity))
            }

            Spacer()

            Button("保存") {
                let limit = enabled ? Int(limitText) : nil
                onSave(enabled, limit)
            }
            .buttonStyle(TallyPrimaryButtonStyle())
        }
        .padding(32)
        .animation(.spring(), value: enabled)
    }
}
