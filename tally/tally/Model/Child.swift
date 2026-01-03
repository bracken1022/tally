import Foundation

struct Child: Identifiable, Codable {
    let id: UUID
    let name: String

    var points: Int
    var rewards: [Reward]
    var pointReasons: [PointReason]
}

extension Child {
    static let defaultPointReasons: [PointReason] = [
        PointReason(id: UUID(), title: "写作业", points: 1),
        PointReason(id: UUID(), title: "打扫卫生", points: 1),
        PointReason(id: UUID(), title: "早起", points: 1),
        PointReason(id: UUID(), title: "吃蔬菜", points: 1),
        PointReason(id: UUID(), title: "礼貌用语", points: 1)
    ]
}
