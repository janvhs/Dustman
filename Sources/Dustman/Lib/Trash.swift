import SecurityFoundation

protocol TrashContextProtocol {
    func trashFile(file: URL) throws
}

struct TrashContext: TrashContextProtocol {
    private let platformSpecificTrashContext: TrashContextProtocol

    init() throws {
        try ensureUserUID()
        platformSpecificTrashContext = try TrashContext.getPlatformSpecificTrashContext()
    }

    private static func getPlatformSpecificTrashContext() throws -> TrashContextProtocol {
        #if os(macOS)
            return DarwinTrashContext()
        #else
            throw DustmanError.platformNotSupported
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
        let filePath: String
        if #available(OSX 13.0, *) {
            filePath = file.absoluteURL.path()
        } else {
            filePath = file.absoluteURL.path
        }

        guard FileManager.default.fileExists(atPath: filePath) else {
            throw DustmanError.noSuchFileOrDirectory(fileUrl: file)
        }

        if !dry {
            try platformSpecificTrashContext.trashFile(file: file)
        } else {
            print("ℹ️ Would have moved \(filePath) to the trash.")
        }
    }
}
