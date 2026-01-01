import SwiftUI

struct AddChildView: View {

    @State private var name: String = ""
    let onContinue: (String) -> Void

    var body: some View {
        VStack(spacing: 24) {
            Text("积点")
                .font(.title)
                .fontWeight(.bold)

            Text("添加孩子")
                .font(.title3)

            TextField("孩子的名字", text: $name)
                .textFieldStyle(.roundedBorder)

            Button("继续") {
                let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
                guard !trimmed.isEmpty else { return }
                onContinue(trimmed)
            }
        }
        .padding(24)
    }
}
