import SwiftUI

struct ContentView: View {

    @State private var state: AppState = LocalStore.load()
    @State private var showAddReward = false
    @State private var showAddChild = false
    @State private var showDailyLimit = false
    @State private var showParentMode = false
    @State private var selectedChildIndex = 0

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
            } else {
                // Main screen: TallyWall with tabs for each child
                ZStack(alignment: .topTrailing) {
                    TabView(selection: $selectedChildIndex) {
                        ForEach(Array(state.children.enumerated()), id: \.element.id) { index, child in
                            TallyWallView(
                                child: child,
                                rewards: state.rewards
                            )
                            .tag(index)
                            .tabItem {
                                Text(child.name)
                            }
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .always))
                    .indexViewStyle(.page(backgroundDisplayMode: .always))

                    // Parent mode button (floating top-right)
                    Button(action: { showParentMode = true }) {
                        HStack(spacing: 8) {
                            Image(systemName: "person.circle.fill")
                            Text("家长")
                        }
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                        .background(
                            LinearGradient(
                                colors: [Color.tallyPrimary, Color.tallySecondary],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(25)
                        .shadow(color: .black.opacity(0.3), radius: 8, x: 0, y: 4)
                    }
                    .padding(.top, 60)
                    .padding(.trailing, 20)
                }
                .onChange(of: selectedChildIndex) { oldValue, newValue in
                    if newValue < state.children.count {
                        state.activeChildId = state.children[newValue].id
                        LocalStore.save(state)
                    }
                }
                .fullScreenCover(isPresented: $showParentMode) {
                    if let currentActiveChild = activeChild {
                        NavigationView {
                            HomeView(
                                children: state.children,
                                activeChild: currentActiveChild,
                                rewards: state.rewards,
                                onAddPoint: addPoint,
                                onSelectChild: selectChild,
                                onAddReward: { showAddReward = true },
                                onAddChild: { showAddChild = true },
                                onAddPoints: addPoints,
                                onOpenDailyLimit: { showDailyLimit = true },
                                onOpenTallyWall: { showParentMode = false }
                            )
                            .navigationBarTitleDisplayMode(.inline)
                            .toolbar {
                                ToolbarItem(placement: .navigationBarLeading) {
                                    Button("关闭") {
                                        showParentMode = false
                                    }
                                    .foregroundColor(.tallySecondary)
                                }
                            }
                        }
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

        // Update the tab index to match the selected child
        if let index = state.children.firstIndex(where: { $0.id == id }) {
            selectedChildIndex = index
        }

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
