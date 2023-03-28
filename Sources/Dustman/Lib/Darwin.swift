import Foundation

// TODO: There has to be a better way to conditionally compile this entire file.
#if os(macOS)
    struct DarwinTrashContext: TrashContextProtocol {
        func trashFile(file: URL) throws {
            try FileManager.default.trashItem(at: file, resultingItemURL: nil)
        }
    }
#endif
