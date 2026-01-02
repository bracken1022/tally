import Foundation

struct Child: Identifiable, Codable {
    let id: UUID
    let name: String

    var points: Int
    var rewards: [Reward]
}
