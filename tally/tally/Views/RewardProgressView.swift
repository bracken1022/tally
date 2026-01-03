import SwiftUI

enum DisplayMode {
    case parent
    case kid
}

struct RewardProgressView: View {

    let reward: Reward
    let currentPoints: Int
    var displayMode: DisplayMode = .parent
    var onClearPoints: (() -> Void)? = nil

    @State private var showClearConfirmation = false

    var progress: Double {
        guard reward.targetPoints > 0 else { return 0 }
        return min(Double(currentPoints) / Double(reward.targetPoints), 1.0)
    }

    var isAchieved: Bool {
        currentPoints >= reward.targetPoints
    }

    var body: some View {
        if displayMode == .parent {
            parentView
        } else {
            kidView
        }
    }

    private var parentView: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(reward.title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.tallyTextPrimary)
                Spacer()
                Text("\(currentPoints)/\(reward.targetPoints)")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(isAchieved ? .tallyGreen : .tallySecondary)
            }

            // Custom progress bar
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.tallyInputBg)
                        .frame(height: 12)

                    RoundedRectangle(cornerRadius: 8)
                        .fill(isAchieved ? LinearGradient(colors: [.tallyGreen, .tallySecondary], startPoint: .leading, endPoint: .trailing) : TallyGradients.reward)
                        .frame(width: geometry.size.width * progress, height: 12)
                        .animation(.spring(), value: progress)
                }
            }
            .frame(height: 12)

            // Show redeem button when achieved
            if isAchieved, let clearPoints = onClearPoints {
                Button(action: { showClearConfirmation = true }) {
                    HStack {
                        Image(systemName: "gift.fill")
                            .font(.system(size: 16))
                        Text("兑换奖励")
                            .font(.system(size: 16, weight: .bold))
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(
                        LinearGradient(
                            colors: [.tallyGreen, .tallySecondary],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(10)
                }
                .buttonStyle(.plain)
                .alert("兑换奖励", isPresented: $showClearConfirmation) {
                    Button("取消", role: .cancel) { }
                    Button("确认兑换") {
                        clearPoints()
                    }
                } message: {
                    Text("确认兑换「\(reward.title)」并将积分清零吗？\n当前积分：\(currentPoints)")
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(16)
        .background(isAchieved ? Color.tallyGreen.opacity(0.1) : Color.tallyCardBg)
        .cornerRadius(12)
        .shadow(color: isAchieved ? Color.tallyGreen.opacity(0.3) : .black.opacity(0.3), radius: 8, x: 0, y: 4)
    }

    private var kidView: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("🏆")
                    .font(.system(size: 48))

                VStack(alignment: .leading, spacing: 4) {
                    Text(reward.title)
                        .font(.system(size: 24, weight: .black))
                        .foregroundColor(.white)

                    Text("\(currentPoints) / \(reward.targetPoints)")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white.opacity(0.9))
                }

                Spacer()
            }

            // Large progress bar
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.white.opacity(0.3))
                        .frame(height: 24)

                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.white)
                        .frame(width: geometry.size.width * progress, height: 24)
                        .animation(.spring(), value: progress)
                }
            }
            .frame(height: 24)
        }
        .padding(24)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white.opacity(0.2))
        )
    }
}
