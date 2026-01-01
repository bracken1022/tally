import SwiftUI

struct ContentView: View {

    @State private var state: AppState = LocalStore.load()
    @State private var showAddReward = false
    @State private var showAddChild = false
    @State private var showDailyLimit = false

    var body: some View {
        Group {
            if state.status == .empty {
                AddChildView { name in
                    let id = UUID()
                    let child = Child(id: id, name: name, points: 0)

                    state = AppState(
                        status: .active,
                        children: [child],
                        activeChildId: id,
                        rewards: [],
                        dailyLimitEnabled: false,
                        dailyLimit: nil
                    )
                    LocalStore.save(state)
                }
            } else if let activeChild = activeChild {
                HomeView(
                    children: state.children,
                    activeChild: activeChild,
                    rewards: state.rewards,
                    onAddPoint: addPoint,
                    onSelectChild: selectChild,
                    onAddReward: { showAddReward = true },
                    onAddChild: { showAddChild = true },
                    onAddPoints: addPoints,
                    onOpenDailyLimit: { showDailyLimit = true }
                )
                .sheet(isPresented: $showDailyLimit) {
                    DailyLimitView(
                        enabled: state.dailyLimitEnabled,
                        limit: state.dailyLimit
                    ) { enabled, limit in
                        state.dailyLimitEnabled = enabled
                        state.dailyLimit = limit
                        LocalStore.save(state)
                        showDailyLimit = false
                    }
                }
                .sheet(isPresented: $showAddReward) {
                    AddRewardView { reward in
                        state.rewards.append(reward)
                        LocalStore.save(state)
                        showAddReward = false
                    }
                }
                .sheet(isPresented: $showAddChild) {
                    AddChildView { name in
                        addNewChild(name)
                        showAddChild = false
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

    private func selectChild(_ id: UUID) {
        state.activeChildId = id
        LocalStore.save(state)
    }
    
    private func addNewChild(_ name: String) {
        let id = UUID()
        let child = Child(id: id, name: name, points: 0)

        state.children.append(child)
        state.activeChildId = id

        LocalStore.save(state)
    }
    
    private func addPoints(_ value: Int) {
        guard let id = state.activeChildId,
              let index = state.children.firstIndex(where: { $0.id == id }) else {
            return
        }

        // 每日上限（若开启）
        if state.dailyLimitEnabled, let limit = state.dailyLimit {
            let current = state.children[index].points
            if current + value > limit {
                return // 静默不加
            }
        }

        state.children[index].points += value
        LocalStore.save(state)
    }


}
