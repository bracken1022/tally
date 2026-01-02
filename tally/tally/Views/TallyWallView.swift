import SwiftUI

struct TallyWallView: View {

    let child: Child
    let rewards: [Reward]
    var onOpenParentMode: (() -> Void)? = nil

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Rainbow gradient background - fills entire screen including status bar
                TallyGradients.rainbow
                    .ignoresSafeArea(.all, edges: .all)

                VStack(spacing: 0) {
                    // Add padding for status bar
                    Color.clear
                        .frame(height: geometry.safeAreaInsets.top)

                    // Header bar - positioned below status bar
                    HStack {
                        Text("积点")
                            .font(.system(size: 28, weight: .black))
                            .foregroundColor(.white)

                        Spacer()

                        if let openParentMode = onOpenParentMode {
                            Button(action: openParentMode) {
                                HStack(spacing: 6) {
                                    Image(systemName: "person.circle.fill")
                                        .font(.system(size: 18))
                                    Text("去积分")
                                        .font(.system(size: 16, weight: .semibold))
                                }
                                .foregroundColor(.white)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(
                                    Color.white.opacity(0.2)
                                )
                                .cornerRadius(20)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.white.opacity(0.3), lineWidth: 2)
                                )
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 30)
                    .padding(.top, 50)
                    .background(
                        Color.white.opacity(0.15)
                    )
                    .overlay(
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.white.opacity(0.3)),
                        alignment: .bottom
                    )

                    // Main content area
                    VStack(spacing: 32) {
                        // Child name and title
                        VStack(spacing: 12) {
                            Text(child.name)
                                .font(.system(size: 36, weight: .black))
                                .foregroundColor(.white)

                            Text("当前积点")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white.opacity(0.9))
                        }
                        .padding(.top, 80)

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
                                .padding(.bottom, geometry.safeAreaInsets.bottom + 20)
                            }
                        }
                    }
                }
            }
        }
    }
}
