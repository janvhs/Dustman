import Foundation

// TODO: There has to be a better way to conditionally compile this entire file.
#if os(macOS)
    struct DarwinTrashProvider: TrashProviderProtocol {
        func trashFile(file: URL) throws {
            try FileManager.default.trashItem(at: file, resultingItemURL: nil)
        }
    }
#endif
