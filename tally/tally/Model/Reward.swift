import Foundation

struct Reward: Identifiable, Codable {
    let id: UUID
    let title: String
    let targetPoints: Int
}
