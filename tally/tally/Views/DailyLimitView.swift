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
        VStack(spacing: 16) {
            Toggle("开启每日上限", isOn: $enabled)

            if enabled {
                TextField("每日上限（如 10）", text: $limitText)
                    .keyboardType(.numberPad)
                    .textFieldStyle(.roundedBorder)
            }

            Button("保存") {
                let limit = enabled ? Int(limitText) : nil
                onSave(enabled, limit)
            }
        }
        .padding(24)
    }
}
