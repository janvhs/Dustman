import DustbinCore
import Foundation

// TODO: There has to be a better way to conditionally compile this entire file.
public struct TrashProvider: TrashProviderProtocol {
    public func trashFile(file: URL) throws {
        try FileManager.default.trashItem(at: file, resultingItemURL: nil)
    }
}
