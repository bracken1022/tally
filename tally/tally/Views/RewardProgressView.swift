import SwiftUI

enum DisplayMode {
    case parent
    case kid
}

struct RewardProgressView: View {

    let reward: Reward
    let currentPoints: Int
    var displayMode: DisplayMode = .parent

    var progress: Double {
        guard reward.targetPoints > 0 else { return 0 }
        return min(Double(currentPoints) / Double(reward.targetPoints), 1.0)
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
                Spacer()
                Text("\(currentPoints)/\(reward.targetPoints)")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.tallySecondary)
            }

            // Custom progress bar
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.gray.opacity(0.15))
                        .frame(height: 12)

                    RoundedRectangle(cornerRadius: 8)
                        .fill(TallyGradients.reward)
                        .frame(width: geometry.size.width * progress, height: 12)
                        .animation(.spring(), value: progress)
                }
            }
            .frame(height: 12)
        }
        .padding(16)
        .background(Color.tallySurfaceLight)
        .cornerRadius(12)
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
