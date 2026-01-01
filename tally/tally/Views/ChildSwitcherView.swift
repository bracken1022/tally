import SwiftUI

struct ChildSwitcherView: View {

    let children: [Child]
    let activeChildId: UUID?
    let onSelect: (UUID) -> Void

    var body: some View {
        Menu {
            ForEach(children) { child in
                Button(child.name) {
                    onSelect(child.id)
                }
            }
        } label: {
            HStack {
                Text(activeChildName)
                    .font(.headline)
                Image(systemName: "chevron.down")
            }
        }
    }

    private var activeChildName: String {
        children.first(where: { $0.id == activeChildId })?.name ?? "选择孩子"
    }
}
