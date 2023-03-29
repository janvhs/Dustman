import DustbinCore
import Foundation

#if canImport(DustbinLinux)
    import DustbinLinux
#elseif canImport(DustbinDarwin)
    import DustbinDarwin
#endif

public struct TrashManager {
    private let trashProvider: TrashProviderProtocol

    public init() throws {
        // TODO: Test if calling this multiple times is a problem.
        try ensureUserUID()
        trashProvider = TrashProvider()
    }

    public func trashFiles(files: [URL], dry: Bool = false) throws {
        for file in files {
            try trashFile(file: file, dry: dry)
        }
    }

    public func trashFile(file: URL, dry: Bool = false) throws {
        let filePath = file.absolutePath()

        guard FileManager.default.fileExists(atPath: filePath) else {
            throw DustbinError.noSuchFileOrDirectory(fileUrl: file)
        }

        if !dry {
            try trashProvider.trashFile(file: file)
        } else {
            print("ℹ️ Would have moved \(filePath) to the trash.")
        }
    }
}
