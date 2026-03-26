import Foundation
import SwiftUI

struct PlayerMatchesViewModel {
    var matches: [PlayerMatchesProcessed]
    var action: () -> Void
    var isLoading: Bool {
        get {
            return matches.isEmpty
        }
    }
}


