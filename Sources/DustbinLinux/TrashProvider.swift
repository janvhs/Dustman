import DustbinCore
import Foundation
import Glibc

// TODO: Instead of implementing this myself, I could use gio (C) or kio (C++)
// REFERENCES: https://wiki.archlinux.org/title/Trash_management
// KDE REFERENCE:
// - https://github.com/KDE/kde-cli-tools/blob/master/kioclient/kioclient.cpp#L472
// - https://github.com/KDE/kde-cli-tools/blob/master/kioclient/kioclient.cpp#L312
// GNOME REFERENCE:
// - https: // gitlab.gnome.org/GNOME/glib/-/blob/main/gio/gio-tool-trash.c#L269

/// The Linux implementation follows the [FreeDesktop Trash Specification](https://specifications.freedesktop.org/trash-spec/trashspec-1.0.html)
public struct TrashProvider: TrashProviderProtocol {
    private let trashDirectory: URL

    public init() {
        trashDirectory = TrashProvider.getTrashDirectory()
    }

    public func trashFile(file: URL) throws {
        // TODO: Use g_file_trash() from gio
        let filePath = file.canonicalizePath()
    }

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
