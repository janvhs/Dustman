import SecurityFoundation

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
            let filePathAsString: String
            if #available(OSX 13.0, *) {
                filePathAsString = fileUrl.absoluteURL.path()
            } else {
                filePathAsString = fileUrl.absoluteURL.path
            }
            return "No such file or directory: \(filePathAsString)"
        case .platformNotSupported:
            return """
            Currently, Dustman does not support your platform.
            Please consider contributing to Dustman to add support for your platform.
            """
        }
    }
}
