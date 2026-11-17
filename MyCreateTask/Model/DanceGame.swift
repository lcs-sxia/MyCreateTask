import Foundation

enum DanceGameCategory: String, CaseIterable, Identifiable {
    case rhythm = "Rhythm"
    case freeze = "Freeze"
    case mirror = "Mirror"

    var id: String {
        rawValue
    }
}

enum DanceGameEnergy: String, CaseIterable, Identifiable {
    case low = "Low Energy"
    case medium = "Medium Energy"
    case high = "High Energy"

    var id: String {
        rawValue
    }
}

struct DanceGame: Identifiable, Hashable {

    // MARK: - Stored properties

    let id: UUID
    let name: String
    let summary: String
    let duration: Int
    let groupSize: String
    let category: DanceGameCategory
    let energy: DanceGameEnergy
    let instructions: [String]

    // MARK: - Initializer

    init(
        id: UUID = UUID(),
        name: String,
        summary: String,
        duration: Int,
        groupSize: String,
        category: DanceGameCategory,
        energy: DanceGameEnergy,
        instructions: [String]
    ) {
        self.id = id
        self.name = name
        self.summary = summary
        self.duration = duration
        self.groupSize = groupSize
        self.category = category
        self.energy = energy
        self.instructions = instructions
    }
}

extension DanceGame {

    // MARK: - Sample data

    static let sampleGames: [DanceGame] = [
        DanceGame(
            name: "Freeze Dance",
            summary: "Dance while the music plays and freeze when it stops.",
            duration: 60,
            groupSize: "2 or more players",
            category: .freeze,
            energy: .high,
            instructions: [
                "Choose one person to control the music.",
                "Dance while the music plays.",
                "Freeze like a statue when the music stops."
            ]
        ),
        DanceGame(
            name: "Rhythm Echo",
            summary: "Copy a rhythm pattern with your hands and feet.",
            duration: 90,
            groupSize: "2 or more players",
            category: .rhythm,
            energy: .medium,
            instructions: [
                "Pick a leader to make a short rhythm.",
                "Everyone echoes the rhythm together.",
                "Take turns creating a new pattern."
            ]
        ),
        DanceGame(
            name: "Mirror Movement",
            summary: "Move slowly while a partner copies you like a mirror.",
            duration: 120,
            groupSize: "2 players",
            category: .mirror,
            energy: .low,
            instructions: [
                "Stand facing your partner.",
                "Move slowly and smoothly.",
                "Switch leaders after 30 seconds."
            ]
        )
    ]
}
