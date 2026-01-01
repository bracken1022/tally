import SwiftUI

struct AddRewardView: View {

    @State private var title: String = ""
    @State private var target: String = ""

    let onAdd: (Reward) -> Void

    var body: some View {
        VStack(spacing: 16) {
            Text("设置奖励")
                .font(.title3)

            TextField("奖励名称（如：买玩具）", text: $title)
                .textFieldStyle(.roundedBorder)

            TextField("目标积点（如：20）", text: $target)
                .keyboardType(.numberPad)
                .textFieldStyle(.roundedBorder)

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
        }
        .padding(24)
    }
}
