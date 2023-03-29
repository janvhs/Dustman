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
        // INFO: This will prevent the recycling of protected files,
        //       but it will also ensue the file will not end up in a
        //       place where it can be deleted completely.
        try ensureUserUID()
        trashProvider = TrashProvider()
    }

    public func trashFiles(files: [URL], dry: Bool = false) throws {
        for file in files {
            try trashFile(file: file, dry: dry)
        }
    }

    public func trashFile(file: URL, dry: Bool = false) throws {
        let filePath = file.canonicalizePath()

        guard FileManager.default.fileExists(atPath: filePath) else {
            throw DustbinError.noSuchFileOrDirectory(fileUrl: file)
        }

        // TODO: This seems to have strange behaviour. Maybe I should just try to delete the file and catch the error.
        guard FileManager.default.isDeletableFile(atPath: filePath) else {
            throw DustbinError.fileNotDeletable(fileUrl: file)
        }

        if !dry {
            try trashProvider.trashFile(file: file)
        } else {
            print("ℹ️ Would have moved \(filePath) to the trash.")
        }
    }
}
