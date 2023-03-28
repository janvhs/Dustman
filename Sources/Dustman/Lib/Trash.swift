import Foundation

protocol TrashProviderProtocol {
    func trashFile(file: URL) throws
}

struct TrashManager {
    private let trashProvider: TrashProviderProtocol

    init() throws {
        // TODO: Test if calling this multiple times is a problem.
        try ensureUserUID()
        trashProvider = try TrashManager.getPlatformSpecificTrashContext()
    }

    private static func getPlatformSpecificTrashContext() throws -> TrashProviderProtocol {
        // TODO: Update this when new platforms are supported.
        #if os(macOS)
            return DarwinTrashProvider()
        #else
            return UnsupportedTrashProvider()
        #endif
    }

    func trashFiles(files: [URL], dry: Bool = false) throws {
        for file in files {
            if dry {
                try trashFile(file: file, dry: true)
            } else {
                try trashFile(file: file)
            }
        }
    }

    func trashFile(file: URL) throws {
        try trashFile(file: file, dry: false)
    }

    func trashFile(file: URL, dry: Bool) throws {
        let filePath = file.absolutePath()

        guard FileManager.default.fileExists(atPath: filePath) else {
            throw DustmanError.noSuchFileOrDirectory(fileUrl: file)
        }

        if !dry {
            try trashProvider.trashFile(file: file)
        } else {
            print("ℹ️ Would have moved \(filePath) to the trash.")
        }
    }
}
