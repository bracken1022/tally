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
        ScrollView {
            VStack(spacing: 24) {

                // Section 1: Child Switcher & Points Display (Card)
                VStack(spacing: 16) {
                    ChildSwitcherView(
                        children: children,
                        activeChildId: activeChild.id,
                        onSelect: onSelectChild
                    )

                    // Large points display with gradient
                    Text("\(activeChild.points)")
                        .font(.system(size: 64, weight: .black))
                        .foregroundStyle(TallyGradients.primary)
                        .padding(.vertical, 20)
                }
                .tallyCard()

                // Section 2: Quick Actions (Card)
                VStack(spacing: 16) {
                    Text("快速加分")
                        .font(.system(size: 18, weight: .bold))

                    HStack(spacing: 16) {
                        Button("+1") { onAddPoints(1) }
                            .buttonStyle(TallyPointButtonStyle(color: .tallyPrimary))

                        Button("+2") { onAddPoints(2) }
                            .buttonStyle(TallyPointButtonStyle(color: .tallySecondary))

                        Button("+3") { onAddPoints(3) }
                            .buttonStyle(TallyPointButtonStyle(color: .tallyAccent))
                    }
                }
                .tallyCard()

                // Section 3: Rewards (Card)
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text("奖励进度")
                            .font(.system(size: 20, weight: .bold))
                        Spacer()
                        if !rewards.isEmpty {
                            Button(action: onAddReward) {
                                Image(systemName: "plus.circle.fill")
                                    .font(.system(size: 24))
                                    .foregroundColor(.tallySecondary)
                            }
                        }
                    }

                    if rewards.isEmpty {
                        Button("设置一个奖励") {
                            onAddReward()
                        }
                        .buttonStyle(TallyPrimaryButtonStyle())
                        .frame(maxWidth: .infinity)
                    } else {
                        ForEach(rewards) { reward in
                            RewardProgressView(
                                reward: reward,
                                currentPoints: activeChild.points
                            )
                        }
                    }
                }
                .tallyCard()

                // Section 4: Settings & Actions
                VStack(spacing: 12) {
                    Button("添加孩子") {
                        onAddChild()
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(Color.tallySurfaceLight)
                    .cornerRadius(10)
                    .foregroundColor(.primary)

                    Button("每日上限") {
                        onOpenDailyLimit()
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(Color.tallySurfaceLight)
                    .cornerRadius(10)
                    .foregroundColor(.primary)

                    Button("给孩子看") {
                        onOpenTallyWall()
                    }
                    .buttonStyle(TallyPrimaryButtonStyle())
                }
            }
            .padding(24)
        }
    }
}
