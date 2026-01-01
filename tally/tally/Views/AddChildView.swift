import SwiftUI

struct AddChildView: View {

    @State private var name: String = ""
    let onAdd: (Child) -> Void

    var body: some View {
        VStack(spacing: 24) {

            // App 名（给用户看的）
            Text("积点")
                .font(.title)
                .fontWeight(.bold)

            Text("添加孩子")
                .font(.title3)

            TextField("孩子的名字", text: $name)
                .textFieldStyle(.roundedBorder)

            Button("继续") {
                guard !name.trimmingCharacters(in: .whitespaces).isEmpty else {
                    return
                }

                let child = Child(
                    id: UUID(),
                    name: name.trimmingCharacters(in: .whitespaces)
                )
                onAdd(child)
            }
        }
        .padding(24)
    }
}
