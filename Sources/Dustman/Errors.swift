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
        case let .fileNotDeletable(fileUrl):
            let filePathAsString = fileUrl.canonicalizePath()
            let fileAttributes = try? FileManager.default.attributesOfItem(atPath: filePathAsString)
            let fileOwner = fileAttributes?[.ownerAccountName] as? String
            let fileGroup = fileAttributes?[.groupOwnerAccountName] as? String

            let ownAccountName = NSUserName()

            return """
            The file at \(filePathAsString) is not deletable.

            Currently, you can not delete files where you don't have write access to.

            Your account name:  \(ownAccountName)

            File owner:         \(fileOwner ?? "unknown")
            File group:         \(fileGroup ?? "unknown")
            """
        case let .appleScriptNotCompilable(source):
            return """
            Can not compile the following AppleScript

            \(source)
            """
        case let .appleScriptError(errorDict):
            return """
            Unknown AppleScript error:

            \(errorDict)
            """
        case let .appleScriptAppNotAllowed(appName, message):
            return """
            \(message ?? "Apple Script authorization")

            Please do the following to fix the error:

            1. Open System Preferences
            2. Navigate to Security & Privacy
            3. Under the section Privacy, click on Automation
            4. Find the App you're currently using and click on the carat (the triangle)
            5. Check \(appName ?? "Unknown but probably Finder")
            6. Try again
            """
        }
    }
}
