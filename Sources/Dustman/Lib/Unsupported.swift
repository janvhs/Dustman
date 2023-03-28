import Foundation

struct UnsupportedTrashProvider: TrashProviderProtocol {
    func trashFile(file _: URL) throws {
        throw DustmanError.platformNotSupported
    }
}
