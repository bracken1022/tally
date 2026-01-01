import SwiftUI

struct ContentView: View {

    @State private var state: AppState = LocalStore.load()
    @State private var showAddReward = false

    var body: some View {
        Group {
            if state.status == .empty {
                AddChildView { childName in
                    let newId = UUID()
                    let child = Child(id: newId, name: childName, points: 0)

                    state = AppState(
                        status: .active,
                        children: [child],
                        activeChildId: newId,
                        rewards: []
                    )
                    LocalStore.save(state)
                }
            } else if let activeChild = activeChild {
                HomeView(
                    child: activeChild,
                    rewards: state.rewards,
                    onAddPoint: addPoint,
                    onAddReward: { showAddReward = true }
                )
                .sheet(isPresented: $showAddReward) {
                    AddRewardView { reward in
                        state.rewards.append(reward)
                        LocalStore.save(state)
                        showAddReward = false
                    }
                }
            }
        }
    }

    private var activeChild: Child? {
        guard let id = state.activeChildId else { return nil }
        return state.children.first { $0.id == id }
    }

    private func addPoint() {
        guard let id = state.activeChildId,
              let index = state.children.firstIndex(where: { $0.id == id }) else {
            return
        }

        state.children[index].points += 1
        LocalStore.save(state)
    }
}
