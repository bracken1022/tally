import SwiftUI

struct AddPointReasonView: View {

    @State private var title: String = ""
    @State private var points: String = ""

    let onAdd: (PointReason) -> Void

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

                    Text("添加加分原因")
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundColor(.secondary)
                }
                .padding(.top, 40)
                .frame(maxWidth: .infinity)

                // Form fields
                VStack(spacing: 20) {
                    // Title field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("原因名称")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.tallyTextSecondary)

                        TextField("如：帮忙洗碗", text: $title)
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

                    // Points field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("积分数")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.tallyTextSecondary)

                        TextField("如：1", text: $points)
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

                Button("保存原因") {
                    guard
                        !title.isEmpty,
                        let pointsValue = Int(points),
                        pointsValue > 0
                    else { return }

                    let reason = PointReason(
                        id: UUID(),
                        title: title,
                        points: pointsValue
                    )
                    onAdd(reason)
                }
                .buttonStyle(TallyPrimaryButtonStyle())
                .frame(maxWidth: .infinity)
                .disabled(title.isEmpty || Int(points) == nil || Int(points) ?? 0 <= 0)
                .opacity((title.isEmpty || Int(points) == nil || Int(points) ?? 0 <= 0) ? 0.5 : 1.0)
            }
            .padding(32)
        }
    }
}
