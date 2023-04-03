import Foundation

// TODO: Move to LocalizedError.

/// Library-specific errors.
public enum DustbinError: Error {
    case setUIDFailed
    case noSuchFileOrDirectory(fileUrl: URL)
    // TODO: Currently unused. Remove this
    case fileNotDeletable(fileUrl: URL)
    // Darwin-specific
    case appleScriptNotCompilable(source: String)
    case appleScriptError(errorDict: NSDictionary)
    case appleScriptAppNotAllowed(appName: String?, message: String?)
}
