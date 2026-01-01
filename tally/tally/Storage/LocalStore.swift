import Foundation

final class LocalStore {
    private static let key = "tally.app.state"

    static func load() -> AppState {
        guard
            let data = UserDefaults.standard.data(forKey: key),
            let state = try? JSONDecoder().decode(AppState.self, from: data)
        else {
            return AppState.initial
        }
        return state
    }

    static func save(_ state: AppState) {
        if let data = try? JSONEncoder().encode(state) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}
