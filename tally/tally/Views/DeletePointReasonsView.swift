import SwiftUI

struct DeletePointReasonsView: View {

    let pointReasons: [PointReason]
    let onDelete: (PointReason) -> Void
    let onClose: () -> Void

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

                    Text("删除加分原因")
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundColor(.secondary)
                }
                .padding(.top, 40)
                .frame(maxWidth: .infinity)

                if pointReasons.isEmpty {
                    VStack(spacing: 16) {
                        Text("暂无加分原因")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.tallyTextSecondary)

                        Button("关闭") {
                            onClose()
                        }
                        .buttonStyle(TallyPrimaryButtonStyle())
                        .frame(maxWidth: .infinity)
                    }
                    .padding(.horizontal, 32)
                } else {
                    // List of reasons
                    ScrollView {
                        VStack(spacing: 12) {
                            ForEach(pointReasons) { reason in
                                HStack(spacing: 16) {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(reason.title)
                                            .font(.system(size: 18, weight: .semibold))
                                            .foregroundColor(.tallyTextPrimary)

                                        Text("+\(reason.points) 分")
                                            .font(.system(size: 14, weight: .medium))
                                            .foregroundColor(.tallyTextSecondary)
                                    }

                                    Spacer()

                                    Button(action: { onDelete(reason) }) {
                                        Image(systemName: "trash.fill")
                                            .font(.system(size: 20))
                                            .foregroundColor(.white)
                                            .padding(12)
                                            .background(Color.red)
                                            .cornerRadius(10)
                                    }
                                }
                                .padding(.horizontal, 20)
                                .padding(.vertical, 16)
                                .background(Color.tallyCardBg)
                                .cornerRadius(12)
                                .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                            }
                        }
                        .padding(.horizontal, 24)
                    }
                }

                Spacer()

                Button("完成") {
                    onClose()
                }
                .buttonStyle(TallyPrimaryButtonStyle())
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 32)
            }
            .padding(.bottom, 32)
        }
    }
}
