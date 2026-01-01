import SwiftUI

struct TallyWallView: View {

    let child: Child
    let rewards: [Reward]

    var body: some View {
        VStack(spacing: 24) {
            Text("积点")
                .font(.headline)

            Text("\(child.points)")
                .font(.system(size: 64, weight: .bold))

            VStack(alignment: .leading, spacing: 16) {
                ForEach(rewards) { reward in
                    RewardProgressView(
                        reward: reward,
                        currentPoints: child.points
                    )
                }
            }
        }
        .padding(24)
    }
}
