import SwiftUI

struct HomeView: View {

    let children: [Child]
    let activeChild: Child
    let rewards: [Reward]

    let onAddPoint: () -> Void
    let onSelectChild: (UUID) -> Void
    let onAddReward: () -> Void
    let onAddChild: () -> Void
    let onAddPoints: (Int) -> Void
    let onOpenDailyLimit: () -> Void
    let onOpenTallyWall: () -> Void

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
            
            Button("每日上限") {
                onOpenDailyLimit()
            }
            .font(.subheadline)
        }
        .padding(24)
        
        HStack(spacing: 16) {
            Button("+1") { onAddPoints(1) }
                .font(.title)

            Button("+2") { onAddPoints(2) }
                .font(.title2)

            Button("+3") { onAddPoints(3) }
                .font(.title2)
        }
        
        Button("给孩子看") {
            onOpenTallyWall()
        }
        .font(.subheadline)

    }
}
