import SwiftUI

struct ContentView: View {

    @State private var state: AppState = LocalStore.load()

    var body: some View {
        Group {
            if state.status == .empty {
                AddChildView { child in
                    state = AppState(
                        status: .active,
                        children: [child],
                        activeChildId: child.id
                    )
                    LocalStore.save(state)
                }
            } else {
                if let activeId = state.activeChildId,
                   let child = state.children.first(where: { $0.id == activeId }) {
                    HomeView(child: child)
                } else {
                    AddChildView { child in
                        state = AppState(
                            status: .active,
                            children: [child],
                            activeChildId: child.id
                        )
                        LocalStore.save(state)
                    }
                }
            }
        }
    }
}
