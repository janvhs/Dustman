import Foundation

public enum DustbinError: Error {
    case setUIDFailed
    case noSuchFileOrDirectory(fileUrl: URL)
}

// TODO: Move this out of the core into the implementer.
extension DustbinError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .setUIDFailed:
            return "Failed to ensure the user's UID."
        case let .noSuchFileOrDirectory(fileUrl):
            let filePathAsString = fileUrl.absolutePath()
            return "No such file or directory: \(filePathAsString)"
        }
    }
}
