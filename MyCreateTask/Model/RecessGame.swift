import Foundation

struct RecessGame: Identifiable {

    // MARK: - Stored properties

    let id: UUID
    let name: String
    let minPlayers: Int
    let equipment: String

    // MARK: - Initializer

    init(
        id: UUID = UUID(),
        name: String,
        minPlayers: Int,
        equipment: String
    ) {
        self.id = id
        self.name = name
        self.minPlayers = minPlayers
        self.equipment = equipment
    }
}
