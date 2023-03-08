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

            let fileManager = FileManager.default

            try moveFilesToTrash(files: files, with: fileManager)
        }

        private func moveFilesToTrash(files: [String], with: FileManager) throws {
            for file in files {
                try moveFileToTrash(file: file, with: with)
            }
        }

        private func moveFileToTrash(file: String, with: FileManager) throws {
            let fileUrl = URL(fileURLWithPath: file)
            guard with.fileExists(atPath: file) else {
                throw DustmanError.noSuchFileOrDirectory(filePath: fileUrl)
            }

            if !dry {
                try with.trashItem(at: fileUrl, resultingItemURL: nil)
            } else {
                print("ℹ️ Would have moved \(fileUrl.lastPathComponent) to the trash.")
            }
        }
    }
}
