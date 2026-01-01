import SwiftUI

struct HomeView: View {

    let child: Child
    let rewards: [Reward]

    let onAddPoint: () -> Void
    let onAddReward: () -> Void

    var body: some View {
        VStack(spacing: 24) {

            Text("积点")
                .font(.headline)

            Text(child.name)
                .font(.title2)

            // 当前分数（Day 2 只显示数字）
            Text("\(child.points)")
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
                VStack(alignment: .leading, spacing: 8) {
                    Text("奖励")
                        .font(.headline)

                    ForEach(rewards) { reward in
                        Text("\(reward.title) · \(reward.targetPoints) 分")
                    }
                }
            }
        }
        .padding(24)
    }
}
