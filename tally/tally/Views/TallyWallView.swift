import SwiftUI

struct TallyWallView: View {

    let child: Child
    let rewards: [Reward]

    var body: some View {
        ZStack {
            // Rainbow gradient background
            TallyGradients.rainbow
                .ignoresSafeArea()

            VStack(spacing: 32) {
                // Header section
                VStack(spacing: 12) {
                    Text(child.name)
                        .font(.system(size: 36, weight: .black))
                        .foregroundColor(.white)

                    Text("积点")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white.opacity(0.9))
                }
                .padding(.top, 60)

                // Huge point display
                Text("\(child.points)")
                    .font(.system(size: 120, weight: .heavy))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)

                Spacer()

                // Reward cards
                if !rewards.isEmpty {
                    ScrollView {
                        VStack(spacing: 20) {
                            ForEach(rewards) { reward in
                                RewardProgressView(
                                    reward: reward,
                                    currentPoints: child.points,
                                    displayMode: .kid
                                )
                                .padding(.horizontal, 24)
                            }
                        }
                        .padding(.bottom, 40)
                    }
                }
            }
        }
    }
}
