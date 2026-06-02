import Foundation

struct SettingsItem: Identifiable {
    let id = UUID()
    let title: String
    let value: String?
}
