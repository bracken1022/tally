import SwiftUI

struct RewardProgressView: View {

    let reward: Reward
    let currentPoints: Int

    var progress: Double {
        guard reward.targetPoints > 0 else { return 0 }
        return Double(currentPoints) / Double(reward.targetPoints)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("\(reward.title)")
                .font(.subheadline)

            ProgressView(value: min(progress, 1.0))
            
            Text("\(currentPoints) / \(reward.targetPoints) 分")
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}
