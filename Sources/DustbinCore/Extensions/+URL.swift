import Foundation

// TODO: Move this out of core into the platform-specific modules.
public extension URL {
    func absolutePath() -> String {
        let filePath: String

        #if os(Linux)
            filePath = absoluteURL.path
        #else
            // TODO: When other platforms are supported, this will need to be updated.
            if #available(OSX 13.0, *) {
                filePath = absoluteURL.path()
            } else {
                filePath = absoluteURL.path
            }
        #endif

        return filePath
    }
}
