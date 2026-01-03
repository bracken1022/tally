import Foundation

struct PointReason: Identifiable, Codable {
    let id: UUID
    var title: String
    var points: Int
}
