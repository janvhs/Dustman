import Foundation

enum DustmanError: Error {
    case setUIDFailed
    case noSuchFileOrDirectory(fileUrl: URL)
    case platformNotSupported
}

extension DustmanError: CustomStringConvertible {
    var description: String {
        switch self {
        case .setUIDFailed:
            return "Failed to ensure the user's UID."
        case let .noSuchFileOrDirectory(fileUrl):
            let filePathAsString = fileUrl.absolutePath()
            return "No such file or directory: \(filePathAsString)"
        case .platformNotSupported:
            return """
            Currently, Dustman does not support your platform.
            Please consider contributing to Dustman to add support for your platform.
            """
        }
    }
}
