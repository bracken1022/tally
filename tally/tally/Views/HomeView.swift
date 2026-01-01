import SwiftUI

struct HomeView: View {

    let children: [Child]
    let activeChild: Child
    let rewards: [Reward]

    let onAddPoint: () -> Void
    let onSelectChild: (UUID) -> Void
    let onAddReward: () -> Void
    let onAddChild: () -> Void

    var body: some View {
        VStack(spacing: 24) {

            // 顶部：孩子切换
            ChildSwitcherView(
                children: children,
                activeChildId: activeChild.id,
                onSelect: onSelectChild
            )

            // 当前分数
            Text("\(activeChild.points)")
                .font(.system(size: 48, weight: .bold))

            Button("+1") {
                onAddPoint()
            }
            .font(.title)

            Divider()

            if rewards.isEmpty {
                Button("设置一个奖励") {
                    onAddReward()
                }
            } else {
                VStack(alignment: .leading, spacing: 16) {
                    Text("奖励进度")
                        .font(.headline)

                    ForEach(rewards) { reward in
                        RewardProgressView(
                            reward: reward,
                            currentPoints: activeChild.points
                        )
                    }
                }
            }
            
            Button("添加孩子") {
                onAddChild()
            }
            .font(.subheadline)
        }
        .padding(24)
    }
}
