import Foundation
import Observation

@Observable
final class ReadingHelperViewModel {

    // MARK: - Stored properties

    let readingItems: [ReadingItem] = ReadingItem.sampleItems
    var readingText: String = ""
}
