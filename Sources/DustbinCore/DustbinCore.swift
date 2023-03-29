import Foundation

public protocol TrashProviderProtocol {
    func trashFile(file: URL) throws
}
