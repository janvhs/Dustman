import ArgumentParser
import SecurityFoundation

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
            let files = files.map { URL(fileURLWithPath: $0) }
            let trashContext = try TrashContext()
            try trashContext.trashFiles(files: files, dry: dry)
        }
    }
}
