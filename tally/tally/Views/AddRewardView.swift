import SwiftUI

struct AddRewardView: View {

    @State private var title: String = ""
    @State private var target: String = ""

    let onAdd: (Reward) -> Void

    var body: some View {
        ZStack {
            // Dark mode background
            Color.tallyBackground
                .ignoresSafeArea()

            VStack(spacing: 32) {
                // Gradient header
                VStack(spacing: 8) {
                    Text("积点")
                        .font(.system(size: 48, weight: .black))
                        .foregroundStyle(TallyGradients.primary)

                    Text("设置奖励")
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundColor(.secondary)
                }
                .padding(.top, 40)
                .frame(maxWidth: .infinity)

                // Form fields
                VStack(spacing: 20) {
                    // Title field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("奖励名称")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.tallyTextSecondary)

                        TextField("如：买玩具", text: $title)
                            .font(.system(size: 18))
                            .padding(16)
                            .background(Color.tallyInputBg)
                            .foregroundColor(.tallyTextPrimary)
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.tallySecondary, lineWidth: 2)
                            )
                    }
                    .frame(maxWidth: .infinity)

                    // Target points field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("目标积点")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.tallyTextSecondary)

                        TextField("如：20", text: $target)
                            .keyboardType(.numberPad)
                            .font(.system(size: 18))
                            .padding(16)
                            .background(Color.tallyInputBg)
                            .foregroundColor(.tallyTextPrimary)
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.tallySecondary, lineWidth: 2)
                            )
                    }
                    .frame(maxWidth: .infinity)
                }

                Spacer()

                Button("保存奖励") {
                    guard
                        !title.isEmpty,
                        let points = Int(target),
                        points > 0
                    else { return }

                    let reward = Reward(
                        id: UUID(),
                        title: title,
                        targetPoints: points
                    )
                    onAdd(reward)
                }
                .buttonStyle(TallyPrimaryButtonStyle())
                .frame(maxWidth: .infinity)
                .disabled(title.isEmpty || Int(target) == nil || Int(target) ?? 0 <= 0)
                .opacity((title.isEmpty || Int(target) == nil || Int(target) ?? 0 <= 0) ? 0.5 : 1.0)
            }
            .padding(32)
        }
    }
}
