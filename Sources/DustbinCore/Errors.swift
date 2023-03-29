import Foundation

// TODO: Move to LocalizedError.

/// Library-specific errors.
public enum DustbinError: Error {
    case setUIDFailed
    case noSuchFileOrDirectory(fileUrl: URL)
}
