import SecurityFoundation

enum DustmanError: Error {
    case setUIDFailed
    case noSuchFileOrDirectory(filePath: URL)
}

extension DustmanError: CustomStringConvertible {
    var description: String {
        switch self {
        case .setUIDFailed:
            return "Failed to ensure the user's UID."
        case let .noSuchFileOrDirectory(filePath):
            return "No such file or directory: \(filePath.path)"
        }
    }
}
