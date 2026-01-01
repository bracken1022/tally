import Foundation

enum AppStatus: String, Codable {
    case empty
    case active
}

struct AppState: Codable {
    var status: AppStatus
    var children: [Child]
    var activeChildId: UUID?
    var rewards: [Reward]
}

extension AppState {
    static let initial = AppState(
        status: .empty,
        children: [],
        activeChildId: nil,
        rewards: []
    )
}
