import DustbinCore
import Foundation

// TODO: Move to LocalizedError.

/// Application-specific errors.
enum DustmanError: Error {}

extension DustmanError: CustomStringConvertible {
    var description: String {
        switch self {}
    }
}

extension DustbinError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .setUIDFailed:
            return "Failed to ensure the user's UID."
        case let .noSuchFileOrDirectory(fileUrl):
            let filePathAsString = fileUrl.canonicalizePath()
            return "No such file or directory: \(filePathAsString)"
        }
    }
}
