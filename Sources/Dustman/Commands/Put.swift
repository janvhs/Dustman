import ArgumentParser
import Foundation

extension Dustman {
    struct Put: ParsableCommand {
        static var configuration = CommandConfiguration(
            abstract: "Move a file to the trash.")

        @Argument(help: "The file to move to the trash.")
        var files: [String]

        #if DEBUG
            var dry: Bool = true
        #else
            @Flag(
                name: .long,
                help: "Preview the changes without actually moving the files to the trash."
            )
            var dry: Bool = false
        #endif

        func run() throws {
            try ensureUserUID()

            let files = files.map { URL(fileURLWithPath: $0) }
            try moveFilesToTrash(files: files)
        }

        private func moveFilesToTrash(files: [URL]) throws {
            for file in files {
                try moveFileToTrash(file: file)
            }
        }

        private func moveFileToTrash(file: URL) throws {
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
                try moveFileToTrashDarwin(file: file)
            } else {
                print("ℹ️ Would have moved \(filePath) to the trash.")
            }
        }

        private func moveFileToTrashDarwin(file: URL) throws {
            try FileManager.default.trashItem(at: file, resultingItemURL: nil)
        }
    }
}
