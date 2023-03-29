import DustbinCore
import Foundation

public struct TrashProvider: TrashProviderProtocol {
    public init() {}

    public func trashFile(file: URL) throws {
        try FileManager.default.trashItem(at: file, resultingItemURL: nil)
    }
}
