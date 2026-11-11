import Foundation

struct DanceGame: Identifiable, Hashable {

    // MARK: - Stored properties

    let id: UUID
    let name: String
    let summary: String

    // MARK: - Initializer

    init(id: UUID = UUID(), name: String, summary: String) {
        self.id = id
        self.name = name
        self.summary = summary
    }
}

extension DanceGame {

    // MARK: - Sample data

    static let sampleGames: [DanceGame] = [
        DanceGame(
            name: "Freeze Dance",
            summary: "Dance while the music plays and freeze when it stops."
        ),
        DanceGame(
            name: "Follow the Leader",
            summary: "Take turns leading the group through creative movements."
        ),
        DanceGame(
            name: "Dance Copycat",
            summary: "Mirror a partner's moves and invent a new sequence together."
        )
    ]
}
