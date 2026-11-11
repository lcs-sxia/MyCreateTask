import Foundation

struct ReadingItem: Identifiable, Hashable {

    // MARK: - Stored properties

    let id: UUID
    let title: String
    let author: String
    let summary: String

    // MARK: - Initializer

    init(id: UUID = UUID(), title: String, author: String, summary: String) {
        self.id = id
        self.title = title
        self.author = author
        self.summary = summary
    }
}

extension ReadingItem {

    // MARK: - Sample data

    static let sampleItems: [ReadingItem] = [
        ReadingItem(
            title: "My Reading Notes",
            author: "Personal journal",
            summary: "Write a short summary or question about what you are reading."
        )
    ]
}
