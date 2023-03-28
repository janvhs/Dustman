import Foundation

#if os(Linux)
    /// The Linux implementation follows the [FreeDesktop Trash Specification](https://specifications.freedesktop.org/trash-spec/trashspec-1.0.html)
    internal struct LinuxTrashProvider: TrashProviderProtocol {
        private let trashDirectory: URL

        init() {
            trashDirectory = LinuxTrashProvider.getTrashDirectory()
        }

        func trashFile(file _: URL) throws {}

        private static func getTrashDirectory() -> URL {
            let xdgDataHome = ProcessInfo.processInfo.environment["XDG_DATA_HOME"] ?? ""
            if xdgDataHome.isEmpty {
                return URL(fileURLWithPath: ".local/share/Trash", relativeTo: FileManager.default.homeDirectoryForCurrentUser)
            } else {
                let xdgDataHomeURL = URL(fileURLWithPath: xdgDataHome)
                return URL(fileURLWithPath: "Trash", relativeTo: xdgDataHomeURL)
            }
        }
    }
#endif
