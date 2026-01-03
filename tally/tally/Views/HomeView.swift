import SwiftUI

struct HomeView: View {

    let children: [Child]
    let activeChild: Child
    let rewards: [Reward]
    let pointReasons: [PointReason]

    let onAddPoint: () -> Void
    let onSelectChild: (UUID) -> Void
    let onAddReward: () -> Void
    let onAddChild: () -> Void
    let onAddPoints: (Int) -> Void
    let onOpenTallyWall: () -> Void
    let onAddPointReason: () -> Void
    let onOpenDeletePointReasons: () -> Void

    var body: some View {
        ZStack {
            // Dark mode background
            Color.tallyBackground
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 20) {

                    // Section 1: Child Switcher & Points Display (Card)
                    VStack(spacing: 16) {
                        ChildSwitcherView(
                            children: children,
                            activeChildId: activeChild.id,
                            onSelect: onSelectChild,
                            onAddChild: onAddChild
                        )

                        // Large points display with gradient
                        Text("\(activeChild.points)")
                            .font(.system(size: 64, weight: .black))
                            .foregroundStyle(TallyGradients.primary)
                            .padding(.vertical, 20)
                    }
                    .frame(maxWidth: .infinity)
                    .tallyCard()

                    // Section 2: Point Reasons (Card)
                    VStack(spacing: 16) {
                        HStack {
                            Text("加分原因")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.tallyTextPrimary)
                            Spacer()
                            HStack(spacing: 16) {
                                Button(action: onOpenDeletePointReasons) {
                                    Image(systemName: "minus.circle.fill")
                                        .font(.system(size: 24))
                                        .foregroundColor(.gray.opacity(0.5))
                                }
                                Button(action: onAddPointReason) {
                                    Image(systemName: "plus.circle.fill")
                                        .font(.system(size: 24))
                                        .foregroundColor(.tallySecondary)
                                }
                            }
                        }

                        ScrollView(.vertical, showsIndicators: false) {
                            VStack(spacing: 12) {
                                ForEach(pointReasons) { reason in
                                    Button(action: { onAddPoints(reason.points) }) {
                                        HStack(spacing: 16) {
                                            Text(reason.title)
                                                .font(.system(size: 18, weight: .semibold))
                                                .foregroundColor(.white)

                                            Spacer()

                                            Text("+\(reason.points)")
                                                .font(.system(size: 24, weight: .heavy))
                                                .foregroundColor(.white)
                                        }
                                        .padding(.horizontal, 24)
                                        .padding(.vertical, 20)
                                        .frame(maxWidth: .infinity)
                                        .background(
                                            LinearGradient(
                                                colors: [.tallyPrimary, .tallySecondary],
                                                startPoint: .leading,
                                                endPoint: .trailing
                                            )
                                        )
                                        .cornerRadius(16)
                                        .shadow(color: Color.tallyPrimary.opacity(0.4), radius: 6, x: 0, y: 3)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            .padding(.vertical, 8)
                        }
                        .frame(height: 300)
                    }
                    .frame(maxWidth: .infinity)
                    .tallyCard()

                    // Section 3: Rewards (Card)
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("奖励进度")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.tallyTextPrimary)
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
                            VStack(spacing: 12) {
                                ForEach(rewards) { reward in
                                    RewardProgressView(
                                        reward: reward,
                                        currentPoints: activeChild.points
                                    )
                                    .frame(maxWidth: .infinity)
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .tallyCard()
                }
                .padding(20)
            }
        }
    }
}
