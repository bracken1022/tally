import SwiftUI

struct ChildSwitcherView: View {

    let children: [Child]
    let activeChildId: UUID?
    let onSelect: (UUID) -> Void
    let onAddChild: () -> Void

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(children) { child in
                    Button(action: { onSelect(child.id) }) {
                        VStack(spacing: 6) {
                            Text(child.name)
                                .font(.system(size: 16, weight: isActive(child) ? .bold : .semibold))
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                        .frame(minWidth: 100)
                        .background(
                            isActive(child)
                                ? TallyGradients.primary
                                : LinearGradient(colors: [Color.tallySurfaceLight], startPoint: .top, endPoint: .bottom)
                        )
                        .foregroundColor(isActive(child) ? .white : .tallyTextPrimary)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(isActive(child) ? Color.clear : Color.tallyTextSecondary.opacity(0.3), lineWidth: 1)
                        )
                        .scaleEffect(isActive(child) ? 1.05 : 1.0)
                        .shadow(color: isActive(child) ? Color.tallyPrimary.opacity(0.3) : Color.clear, radius: 8)
                    }
                    .buttonStyle(.plain)
                    .animation(.spring(response: 0.3), value: activeChildId)
                }

                // Add child button
                Button(action: onAddChild) {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 32))
                        .foregroundColor(.tallySecondary)
                        .frame(minWidth: 60)
                        .padding(.vertical, 12)
                }
                .buttonStyle(.plain)
            }
        }
    }

    private func isActive(_ child: Child) -> Bool {
        child.id == activeChildId
    }
}
