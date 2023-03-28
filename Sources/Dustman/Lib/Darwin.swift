import SecurityFoundation

struct DarwinTrashContext: TrashContextProtocol {
    func trashFile(file: URL) throws {
        try FileManager.default.trashItem(at: file, resultingItemURL: nil)
    }
}
